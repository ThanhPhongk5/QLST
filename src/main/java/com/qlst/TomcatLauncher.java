package com.qlst;

import java.awt.Desktop;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class TomcatLauncher {

    private static final int MYSQL_PORT = 3306;
    private static final String APP_URL = "http://localhost:8080/QLSieuThi/";

    public static void main(String[] args) {
        System.out.println("================================================================================");
        System.out.println("       HỆ THỐNG QUẢN LÝ SIÊU THỊ (QLST) - KHỞI ĐỘNG TOMCAT 9 TÍCH HỢP");
        System.out.println("                         MSSV: 10B23DCCN646");
        System.out.println("================================================================================");

        File projectDir = new File(".").getAbsoluteFile();
        if (projectDir.getName().equals(".")) {
            projectDir = projectDir.getParentFile();
        }

        File tomcatDir = new File(projectDir, "tomcat");
        if (!tomcatDir.exists()) {
            System.err.println("[LỖI] Không tìm thấy thư mục tomcat tại: " + tomcatDir.getAbsolutePath());
            return;
        }

        // 1. Kiểm tra CSDL MySQL
        checkAndStartMySQL();

        // 2. Đồng bộ mã nguồn webapp (src -> tomcat) & kích hoạt Hot-Sync thời gian thực
        syncWebapp(projectDir, tomcatDir);

        // 3. Khởi động Tomcat 9
        startTomcat(tomcatDir);
    }

    private static void checkAndStartMySQL() {
        System.out.print("[1/3] Kiểm tra CSDL MySQL (Port " + MYSQL_PORT + ")... ");
        try (Socket socket = new Socket("localhost", MYSQL_PORT)) {
            System.out.println("ĐANG CHẠY (Sẵn sàng!)");
        } catch (Exception e) {
            System.out.println("Chưa bật. Đang kích hoạt MySQL...");
            try {
                new ProcessBuilder("cmd.exe", "/c", "docker start mysql-8.0.43").start().waitFor();
                Thread.sleep(2000);
            } catch (Exception ignored) {
            }

            try (Socket socket = new Socket("localhost", MYSQL_PORT)) {
                System.out.println("      -> MySQL đã sẵn sàng!");
            } catch (Exception ex) {
                System.out.println("      [Lưu ý] Hãy đảm bảo MySQL đang chạy để kết nối CSDL.");
            }
        }
    }

    private static void syncWebapp(File projectDir, File tomcatDir) {
        System.out.println("[2/3] Đồng bộ mã nguồn webapp (src -> tomcat)...");
        try {
            File srcWebapp = new File(projectDir, "src/main/webapp");
            File targetWebapp = new File(tomcatDir, "webapps/QLSieuThi");
            File targetClasses = new File(projectDir, "target/classes");
            File tomcatClasses = new File(targetWebapp, "WEB-INF/classes");

            if (srcWebapp.exists() && targetWebapp.exists()) {
                // Đồng bộ các file JSP, CSS, hình ảnh từ src/main/webapp sang tomcat
                copyDirectoryRecursively(srcWebapp.toPath(), targetWebapp.toPath(), false);
                System.out.println("      -> Đã đồng bộ toàn bộ file JSP, CSS, hình ảnh sang máy chủ.");
            }

            if (targetClasses.exists() && tomcatClasses.exists()) {
                // Đồng bộ file class mới nhất từ target/classes
                copyDirectoryRecursively(targetClasses.toPath(), tomcatClasses.toPath(), true);
            }

            // Kích hoạt Daemon Thread tự động theo dõi và sao chép thời gian thực (Hot-Sync)
            startRealtimeWatcher(srcWebapp.toPath(), targetWebapp.toPath());
            System.out.println("      -> Đã kích hoạt Hot-Sync: Mọi thay đổi trong src/main/webapp sẽ tự cập nhật ngay!");

        } catch (Exception e) {
            System.err.println("      [Cảnh báo] Lỗi khi đồng bộ webapp: " + e.getMessage());
        }
    }

    private static void copyDirectoryRecursively(Path source, Path target, boolean overwriteAll) throws IOException {
        Files.walkFileTree(source, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException {
                // Không ghi đè thư mục lib chứa jar
                if (dir.endsWith("WEB-INF\\lib") || dir.endsWith("WEB-INF/lib")) {
                    return FileVisitResult.SKIP_SUBTREE;
                }
                Path destDir = target.resolve(source.relativize(dir));
                if (!Files.exists(destDir)) {
                    Files.createDirectories(destDir);
                }
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                Path destFile = target.resolve(source.relativize(file));
                if (overwriteAll || !Files.exists(destFile)
                        || Files.getLastModifiedTime(file).toMillis() > Files.getLastModifiedTime(destFile).toMillis()) {
                    Files.copy(file, destFile, StandardCopyOption.REPLACE_EXISTING);
                }
                return FileVisitResult.CONTINUE;
            }
        });
    }

    private static void startRealtimeWatcher(Path srcDir, Path targetDir) {
        Thread watcherThread = new Thread(() -> {
            try {
                WatchService watcher = FileSystems.getDefault().newWatchService();
                Map<WatchKey, Path> keyPathMap = new ConcurrentHashMap<>();

                // Đăng ký toàn bộ thư mục và thư mục con
                registerAll(srcDir, watcher, keyPathMap);

                while (!Thread.currentThread().isInterrupted()) {
                    WatchKey key;
                    try {
                        key = watcher.take();
                    } catch (InterruptedException e) {
                        break;
                    }

                    Path dir = keyPathMap.get(key);
                    if (dir == null) continue;

                    for (WatchEvent<?> event : key.pollEvents()) {
                        WatchEvent.Kind<?> kind = event.kind();
                        if (kind == StandardWatchEventKinds.OVERFLOW) continue;

                        @SuppressWarnings("unchecked")
                        WatchEvent<Path> ev = (WatchEvent<Path>) event;
                        Path filename = ev.context();
                        Path child = dir.resolve(filename);

                        // Nếu là thư mục mới, đăng ký theo dõi
                        if (kind == StandardWatchEventKinds.ENTRY_CREATE && Files.isDirectory(child)) {
                            try {
                                registerAll(child, watcher, keyPathMap);
                            } catch (IOException ignored) {}
                        }

                        // Nếu là file được tạo/sửa đổi -> lập tức copy sang tomcat
                        if (Files.isRegularFile(child)) {
                            Path relative = srcDir.relativize(child);
                            Path dest = targetDir.resolve(relative);
                            try {
                                Thread.sleep(60); // Đợi IDE hoàn tất ghi file
                                Path parent = dest.getParent();
                                if (parent != null && !Files.exists(parent)) {
                                    Files.createDirectories(parent);
                                }
                                Files.copy(child, dest, StandardCopyOption.REPLACE_EXISTING);
                                System.out.println("[Hot-Sync] Tự động cập nhật: " + relative + " -> Tomcat (Sẵn sàng F5)");
                            } catch (Exception ignored) {}
                        }
                    }

                    boolean valid = key.reset();
                    if (!valid) {
                        keyPathMap.remove(key);
                        if (keyPathMap.isEmpty()) break;
                    }
                }
            } catch (Exception ignored) {}
        });

        watcherThread.setDaemon(true);
        watcherThread.setName("Webapp-HotSync-Thread");
        watcherThread.start();
    }

    private static void registerAll(final Path start, final WatchService watcher, final Map<WatchKey, Path> keyPathMap)
            throws IOException {
        Files.walkFileTree(start, new SimpleFileVisitor<Path>() {
            @Override
            public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException {
                WatchKey key = dir.register(watcher,
                        StandardWatchEventKinds.ENTRY_CREATE,
                        StandardWatchEventKinds.ENTRY_MODIFY);
                keyPathMap.put(key, dir);
                return FileVisitResult.CONTINUE;
            }
        });
    }

    private static void startTomcat(File tomcatDir) {
        System.out.println("[3/3] Đang khởi động Apache Tomcat 9 nội bộ...\n");
        try {
            File binDir = new File(tomcatDir, "bin");
            File catalinaBat = new File(binDir, "catalina.bat");

            ProcessBuilder pb = new ProcessBuilder("cmd.exe", "/c", catalinaBat.getAbsolutePath(), "run");
            pb.directory(binDir);

            Map<String, String> env = pb.environment();
            env.put("JAVA_HOME", "C:\\Program Files\\Java\\jdk-24");
            env.put("CATALINA_HOME", tomcatDir.getAbsolutePath());
            env.put("CATALINA_BASE", tomcatDir.getAbsolutePath());

            Process process = pb.start();

            // Tự động dừng Tomcat khi dừng process trong IDE
            Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                try {
                    new ProcessBuilder("cmd.exe", "/c", new File(binDir, "shutdown.bat").getAbsolutePath())
                            .directory(binDir)
                            .start()
                            .waitFor();
                } catch (Exception ignored) {
                }
                process.destroy();
            }));

            // Đọc và in log thời gian thực từ stdout
            boolean[] browserOpened = { false };
            Thread stdoutThread = new Thread(() -> {
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println(line);

                        if (!browserOpened[0]
                                && (line.contains("Starting ProtocolHandler") || line.contains("Server startup in"))) {
                            browserOpened[0] = true;
                            printSuccessBanner();
                            openBrowser(APP_URL);
                        }
                    }
                } catch (Exception ignored) {
                }
            });
            stdoutThread.start();

            // Đọc và in log từ stderr
            Thread stderrThread = new Thread(() -> {
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(process.getErrorStream(), StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.err.println(line);

                        if (!browserOpened[0]
                                && (line.contains("Starting ProtocolHandler") || line.contains("Server startup in"))) {
                            browserOpened[0] = true;
                            printSuccessBanner();
                            openBrowser(APP_URL);
                        }
                    }
                } catch (Exception ignored) {
                }
            });
            stderrThread.start();

            int exitCode = process.waitFor();
            System.out.println("\n[TomcatLauncher] Máy chủ đã dừng. (Exit code: " + exitCode + ")");

        } catch (Exception e) {
            System.err.println("[LỖI] Khởi chạy máy chủ thất bại:");
            e.printStackTrace();
        }
    }

    private static void printSuccessBanner() {
        System.out.println("\n================================================================================");
        System.out.println("                 MÁY CHỦ TOMCAT 9 ĐÃ KHỞI ĐỘNG THÀNH CÔNG!");
        System.out.println("================================================================================");
        System.out.println("  * Trang chủ ứng dụng    : " + APP_URL);
        System.out.println("  * Module 1 (Đăng ký TV) : " + APP_URL + "register.jsp");
        System.out.println("  * Đăng nhập             : " + APP_URL + "login.jsp");
        System.out.println("  * Chế độ Hot-Sync       : ĐANG BẬT (sửa file trong src/ sẽ tự đồng bộ ngay)");
        System.out.println("================================================================================\n");
    }

    private static void openBrowser(String url) {
        try {
            if (Desktop.isDesktopSupported() && Desktop.getDesktop().isSupported(Desktop.Action.BROWSE)) {
                Desktop.getDesktop().browse(new URI(url));
            } else {
                new ProcessBuilder("cmd.exe", "/c", "start", url).start();
            }
        } catch (Exception ignored) {
        }
    }
}

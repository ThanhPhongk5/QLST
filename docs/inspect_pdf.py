import pypdf, sys
sys.stdout.reconfigure(encoding='utf-8')

def search_pdf(path, keywords):
    try:
        reader = pypdf.PdfReader(path)
        print(f"=== {path} ({len(reader.pages)} pages) ===")
        for i, page in enumerate(reader.pages):
            text = page.extract_text() or ''
            for kw in keywords:
                if kw.lower() in text.lower():
                    print(f"Page {i+1} mentions '{kw}':")
                    lines = [l.strip() for l in text.split('\n') if kw.lower() in l.lower()]
                    for l in lines[:2]:
                        print('  ', l[:100])
                    break
    except Exception as e:
        print("Error:", e)

if __name__ == '__main__':
    search_pdf(r"C:\Users\ADMIN\Documents\NĂM 4\Phân tích thiết kế hệ thống\LAB1-JavaProgrammingBasic.pdf", ['sơ đồ', 'thiết kế', 'tầng', 'DAO'])
    search_pdf(r"C:\Users\ADMIN\Documents\NĂM 4\Phân tích thiết kế hệ thống\BG HP TTTN 2 CNPM 2020 final (1).pdf", ['sơ đồ lớp', 'thiết kế'])

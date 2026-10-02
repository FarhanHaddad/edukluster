# CONVENTIONS — EduCluster

## Layering (server)
Alur: Request -> middleware -> routes -> controller -> service -> Prisma -> MySQL
- routes: hanya mapping URL+method ke controller; nol logika.
- controller: baca req, validasi Zod, panggil service, bentuk response + status code; DILARANG business logic & DILARANG sentuh Prisma.
- service: seluruh business rule (FR-xxx) & transaksi; tidak kenal req/res; melempar ApiError.
- utils: fungsi murni (euclidean, dbi, min-max); wajib unit-testable.
- validations: Zod schema; pakai shared/ bila dipakai FE+BE.

## FE Conventions
- Theme: semantic CSS variables (:root=light, .dark=dark) di-map via Tailwind v4 `@theme inline`; komponen hanya pakai token semantik; prefix `dark:` dilarang; toggle = class `dark` di <html> + localStorage.
- Components: DRY/LEGO — UI berulang diekstrak ke components (primitif ui + domain) dengan props; page hanya mengomposisi, dilarang copy-paste markup.

## Aturan File
- Naming: x.routes.js, x.controller.js, x.service.js, x.validation.js
- Controller <= ~100 baris; Service <= ~200 baris; lebih = pecah per domain.
- 1 file = 1 tanggung jawab; 1 fungsi = 1 pekerjaan.

## Git
- main protected; semua kerjaan lewat branch feat/*, fix/*, chore/*, docs/*; masuk via Pull Request.
- Conventional Commits: type(scope): deskripsi (feat|fix|chore|refactor|test|docs); imperative, lowercase, <=72 karakter; 1 commit = 1 perubahan logis.
- Versi = tag SemVer: v0.x.y selama development; minor per fitur/sprint; patch per bugfix; v1.0.0 = sidang-ready. Tag hanya di main setelah merge.
- Wajib git pull sebelum edit lokal.

## Security
- .env TIDAK PERNAH di-commit (repo public); yang di-commit hanya .env.example.
- Semua input divalidasi Zod; password bcrypt; JWT expired 1 jam.
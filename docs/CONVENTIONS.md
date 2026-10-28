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

## REST Client Collections (server/http/)
- Satu file .rest per fitur/menu: auth.rest, periode.rest, dashboard.rest, siswa.rest, preprocessing.rest, kmeans.rest, profiling.rest, laporan.rest, riwayat.rest, admin.rest.
- Struktur wajib tiap file: baris `@baseUrl = http://localhost:5000/api` → blok login `# @name login` (komentar status wajib) → baris `@token = {{login.response.body.data.token}}` → request fitur pakai `Authorization: Bearer {{token}}`.
- Tiap request punya nomor + komentar ekspektasi status & tujuan (mis. `### 4. Create Duplikat (Wajib 409)`).
- SYNC RULE (kontrak FE↔BE): file .rest = sumber kebenaran URL. Hook/lib FE WAJIB memanggil path yang sama persis dengan request di .rest. Setiap tiket yang menambah/mengubah endpoint BE wajib update file .rest terkait di commit yang sama + menyebutnya di laporan.
- REGRESSION RULE: sebelum PR di-merge, Owner menjalankan semua blok file .rest fitur tersebut.

## REST CLIENT FILE GRAMMAR (file server/http/*.rest)

Ekspansi operasional dari bagian "REST Client Collections" di atas (tidak mengubah aturan lama).
Diagram zona satu blok request (contoh nyata: kmeans.rest):

```
@baseUrl = http://localhost:5000/api      <- ZONA VARIABEL GLOBAL (sebelum method line pertama)

### 3. GET /kmeans/runs/latest — ...      <- judul: penomoran + komentar ekspektasi status
# Shape data: { ... }                     <- komentar kontrak response (wajib utk GET read-model)
GET {{baseUrl}}/kmeans/runs/latest?periodeId=1   <- METHOD LINE (pembuka zona header)
Authorization: Bearer {{token}}           <- ZONA HEADER (baris `Key: value`, setelah method line)
                                          <- baris kosong = pemisah header/body
{ "key": "value" }                        <- ZONA BODY = baris TERAKHIR blok, tepat sebelum ### berikutnya
```

Aturan:
- ZONA VARIABEL (`@baseUrl`, `@token = {{login.response.body.data.token}}`): WAJIB berada SEBELUM
  method line; deklarasi `@token` hanya boleh di blok login/awal file (baris setelah body JSON login),
  bukan di dalam zona body request lain. DILARANG menaruh baris `@token = ...` (atau variabel apa pun)
  di dalam zona body — REST Client memaknainya sebagai isi body, bukan deklarasi variabel.
- Penomoran request wajib berurutan (`### 0.` login, lalu `### 1.` dst.) dengan komentar ekspektasi
  status code + tujuan, mis. `(Wajib 200; ...)`, `(Wajib 409 Bahasa Indonesia)`; kasus error diberi
  nomor sendiri (mis. `### 8A/8B/8C`) supaya bisa dijalankan sekuensial.
- Zona body = baris terakhir sebelum `###` berikutnya; header selalu baris `Key: value` langsung
  setelah method line. Response chaining hanya lewat `{{nama.response.body...}}`.
- Pointer SYNC RULE: setiap perubahan shape response service yang didokumentasikan di komentar blok
  (mis. field baru `features`, `summary.k`, `summary.totalStudents`, `iterations[].isConverged` pada
  blok 3 kmeans.rest) WAJIB didokumentasikan ulang di file .rest terkait pada commit yang sama —
  lihat SYNC RULE di bagian "REST Client Collections" di atas.

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
---
name: EduCluster SMA Widuri
colors:
  surface: '#fcf8fb'
  surface-dim: '#dcd9dc'
  surface-bright: '#fcf8fb'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f2f5'
  surface-container: '#f0edf0'
  surface-container-high: '#eae7ea'
  surface-container-highest: '#e5e1e4'
  on-surface: '#1c1b1d'
  on-surface-variant: '#4f4350'
  inverse-surface: '#313032'
  inverse-on-surface: '#f3f0f2'
  outline: '#817382'
  outline-variant: '#d2c1d2'
  surface-tint: '#8e35ad'
  primary: '#6f0f8f'
  on-primary: '#ffffff'
  primary-container: '#8a31a9'
  on-primary-container: '#f4c3ff'
  inverse-primary: '#efb0ff'
  secondary: '#5d5e66'
  on-secondary: '#ffffff'
  secondary-container: '#dfdfe8'
  on-secondary-container: '#61626a'
  tertiary: '#2a29bb'
  on-tertiary: '#ffffff'
  tertiary-container: '#4547d3'
  on-tertiary-container: '#d0cfff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#fad7ff'
  primary-fixed-dim: '#efb0ff'
  on-primary-fixed: '#330045'
  on-primary-fixed-variant: '#731592'
  secondary-fixed: '#e2e2eb'
  secondary-fixed-dim: '#c6c6cf'
  on-secondary-fixed: '#1a1b22'
  on-secondary-fixed-variant: '#45464e'
  tertiary-fixed: '#e1e0ff'
  tertiary-fixed-dim: '#c0c1ff'
  on-tertiary-fixed: '#06006c'
  on-tertiary-fixed-variant: '#2e2ebe'
  background: '#fcf8fb'
  on-background: '#1c1b1d'
  surface-variant: '#e5e1e4'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 30px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.015em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.015em
  headline-sm:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
  label-xs:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.04em
  metric-lg:
    fontFamily: JetBrains Mono
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.02em
  metric-md:
    fontFamily: JetBrains Mono
    fontSize: 16px
    fontWeight: '500'
    lineHeight: 20px
  metric-sm:
    fontFamily: JetBrains Mono
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  margin: 1.5rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1rem
  space-xl: 1.5rem
---

Design style: modern admin dashboard, shadcn/ui component style, Linear-inspired clarity.
Theme: light and dark supported; THIS GENERATION PASS = LIGHT MODE ONLY. Dark variants are produced later in a dedicated consistency pass.
Surface elevation rule: cards always one step lighter than the background (bg #F4F4F5 vs card #FFFFFF, shadow-sm).
Primary CTA buttons are SOLID filled: bg #A64DC4 with white text (hover #8F39AC, active #793191). Outline style is reserved for secondary actions only.
Semantic colors used ONLY as soft tinted badges (10-15% tint background + solid text): green success, amber warning, red destructive, blue info.
Font: Inter; JetBrains Mono ONLY for NIS, numbers, scores, timestamps, code chips.
Form labels: uppercase 12px semibold (label-xs), brand-colored asterisk for required fields. When an inline error is shown, hide the helper text.
Corner radius 8px. Minimal shadows. No gradients, no neon glow, data-dense but clean.
Layout: left sidebar 240px with grouped sections (GENERAL: Dashboard, Periode, Data Siswa; PROCESSING: Preprocessing, K-Means & Visualisasi; OUTPUT: Profiling & Rekomendasi, Laporan, Riwayat; OTHER: Manajemen Admin), logo row "EduCluster / SMA Widuri", footer avatar "satnaing / Admin SMA Widuri"; top bar + main content.
Responsive: desktop sidebar expanded, tablet icon rail, mobile off-canvas drawer; tables scroll horizontally on small screens.
Language of all visible UI text: Indonesian.
Cluster chart palette (fixed): C1 #6366F1, C2 #0EA5E9, C3 #10B981, C4 #D97706, C5 #EF4444, C6 #EC4899, C7 #65A30D, C8 #F97316, C9 #14B8A6, C10 #8B5CF6.

GLOBAL LOCK RULES (v1.4):
1. Top bar contains ONLY: global search input with K shortcut hint, theme toggle button, avatar with name and role. No notification bell, no help button, no extra icons.
2. Use ONLY the zinc neutral scale + brand tokens above. Never use Material Design 3 color role names, never use pink-tinted neutrals.
3. 8pt spacing grid: page padding 24px, section gaps 24px, card inner padding 24px, inner gaps 8/12/16px. All buttons 40px height. CTA rows use 12px gap and must never overlap or touch.
4. ONE FRAME = ONE STATE. Never composite dialogs, toasts, open dropdowns, or sheets on top of a page frame; each overlay lives in its own standalone frame on a plain dimmed backdrop.
5. Content whitelist: render ONLY the labels and texts explicitly written in each frame spec. Do not invent badges, breadcrumbs, version numbers, standard names, extra info panels, or marketing cards.
6. No breadcrumb rows. Page header style: title + description on the left, period chip "Periode: 2025/2026 Ganjil" on the right.
7. Page skeleton (strict order, single column): ROW 1 page header; ROW 2 tab bar (only for screens inside Data Siswa); ROW 3 one single content card; nothing below ROW 3.
8. Sidebar active item is set per screen spec below.

## SHELL & IDENTITY LOCK
Single source of truth untuk aset brand & identitas admin di SEMUA screen dan SEMUA prompt.
- File aset brand: `widuri.png` (emblem). Dipakai di tepat 3 tempat:
  1. Sidebar logo row: widuri.png di dalam container rounded-lg (8px) dengan brand tint
     (#A64DC4 10%) + teks "EduCluster" (14px semibold) dan "SMA Widuri" (12px muted).
  2. Topbar avatar: widuri.png, 32px, circle.
  3. Sidebar footer avatar: widuri.png, 32px, circle.
- Identitas admin (FIXED, tidak boleh di-invent per frame):
  - Nama: "satnaing" (14px semibold)
  - Role: "Admin SMA Widuri" (12px muted)
  - Kebab (more_vert) icon button di kanan baris footer sidebar.
- DILARANG: icon orang generik, glyph hub ungu, glyph mirip huruf, kotak placeholder
  abu "img", atau pengganti apa pun untuk widuri.png; menambah/mengganti nama admin.
- Setiap prompt (frame baru maupun revisi) WAJIB membawa IDENTITY CLAUSE verbatim;
  kalau hasil generate drift, perbaiki lewat revisi surgical yang mereferensi lock ini.

SCREEN INDEX & STATUS:
- Screen 1 Login — LOCKED (light+dark)
- Screen 2 Dashboard — LOCKED (light+dark)
- Screen 3 Periode — LOCKED (light+dark, frames 3A-3D)
- Screen 4 Data Siswa list — LOCKED (light+dark, frames 4A-4E)
- Screen 5 Single Input + Edit Data Siswa — LOCKED (light+dark; nilai akademik = tabel 4 kolom MATA PELAJARAN/RAPOR/PTS/PAS)

DARK MODE CONTRACT (v1.0) — apply to this frame. Generate DARK variant ONLY.
Tokens: page background #09090B; sidebar, topbar, cards #18181B; elevated (table header, accordion header, dropdown) #1E1E24; recessed inputs #121215; borders #27272A; strong borders/chips #3F3F46; primary text #FAFAFA; secondary text #A1A1AA; placeholder #71717A.
Brand: #BE7DD4; brand tint bg = #BE7DD4 at 15%; on-brand text #18181B; solid primary CTA bg #BE7DD4 text #18181B (hover #B266CC); focus border/ring + checkbox/radio accent = #BE7DD4; checked radio inner dot #18181B.
Semantic dark tints (bg 15% / border 40% / solid text): success #16A34A / #4ADE80; warning #D97706 / #FBBF24; destructive #DC2626 / #F87171; info #2563EB / #60A5FA.
Disabled: bg #27272A, text #71717A, border #3F3F46 at 60%, cursor not-allowed. Outline button: transparent bg, border #3F3F46, text #FAFAFA.
Type: Inter; JetBrains Mono ONLY for NIS, numbers, scores, timestamps, code chips. Table headers Inter 12px semibold uppercase #A1A1AA (never mono).
Geometry: radius 8px; 8pt spacing grid; page padding 24px; section gaps 24px; card padding 24px; buttons 40px; CTA row gap 12px.
Shell: sidebar 240px grouped GENERAL/PROCESSING/OUTPUT/OTHER; logo = widuri.png emblem in rounded-lg container bg #BE7DD4 at 15% + border #BE7DD4 at 25%; footer = emblem avatar 32px + "satnaing" + muted "Admin SMA Widuri" + kebab; topbar ONLY search (placeholder "Cari data, menu, laporan..."), theme toggle, avatar. Sidebar icons locked: grid_view, calendar_today, group, tune, bubble_chart, psychology, description, history, admin_panel_settings.
Standalone overlay backdrop (dialog/toast) = #0B0B0D.
Layout tree MUST be identical to the light counterpart frame; only tokens change.
FORBIDDEN: any Material-3 token or class (primary-fixed, surface-container, on-surface, fcF8fb-family), light tints (#EFECF8, #fad7ff), #8a31a9 as surface, emerald-950/green-950 ad-hoc tints.
Rules: ONE frame = ONE state; render ONLY whitelisted texts; no gradients, no neon glow.
NO-SCRIPT RULE: frames MUST NOT contain any <script> that mutates nav/element classes.
Sidebar active state = STATIC classes only (active: bg #BE7DD4/15 + text #BE7DD4 + font-semibold, NO border; inactive: text #A1A1AA + hover bg #27272A).
FORBIDDEN classes anywhere: bg-primary-fixed, text-primary, text-on-surface-variant, hover:bg-surface-container, and any M3 token from the project YAML.
SHELL TOKEN LOCK (dark): search input bg #121215 border #27272A; ⌘K chip bg #27272A border #3F3F46; theme toggle bg #27272A border #3F3F46; topbar avatar = plain widuri.png 32px circle (NO tint wrapper); period chip bg #18181B border #27272A shadow-sm h-10; page h1 font-semibold.

CHANGELOG:
CHANGELOG (sequential — paste all):
- v1.4 — Replace Material-3 YAML tokens with zinc+brand tokens; light-first generation pass; add screen index; reinforce ONE FRAME = ONE STATE and uppercase label rule.
- v1.5 — STEPPER LOCK: wizard stepper = identical component across frames. Circle 32px on top, label 14px semibold below (8px gap, one line, plain step name, no number/sublabel/overline). Circle states: pending = neutral + muted number; active = brand + white number; running = brand + white spinner; completed = success + white check; failed = destructive + white cross.
- v1.5.1 — STEPPER LOCK amendment: connector 2px aligned to circle center; color rule = green if left step completed, red if right step failed, else neutral border ("brand if left active" clause removed).
- v1.6 — Screen 6 light locked as light reference; dark pass for screens 6-12 deferred to a batched dark pass.
- v1.7 — Screen 7 Preprocessing: pipeline visualized as TABS per stage with status badges (Selesai/Menunggu/Reset/Terkunci); stage titles in Indonesian: Integrasi Data, Cleaning Data, Transformasi Data, Reduksi Data; imputation = one global radio group; category mapping = inline prefilled table; invalidation = amber banner + Reset badge; one primary action per footer (no draft).
- v1.8 — Screen 7 Transformasi: sub-tahap Inisialisasi (accordion 7 tabel encoding, kolom NO/BIDANG/CONTOH NILAI ASLI/KODE editable) + Normalisasi (Min-Max 0-1); kontrak fitur = 18 akademik + 7 encoded = 25 kolom; frame plan 7A-7E.
- v1.9 — Screen 7 round #4: 7A = pratinjau data sumber (sheet tabs RAPOR/PTS/PAS/NON-AKADEMIK + tabel 5 baris + note "Menampilkan 1-5 dari 105 baris") menggantikan empty state; 7C = pola assignment Inisialisasi: block "Nilai Belum Terpetakan" (select value-driven per nilai + opsi "+ Buat bidang baru"), CONTOH NILAI ASLI = chips netral, kolom kelima AKSI = tombol hapus per baris sebagai undo path, gate CTA disabled selama unmapped > 0; 7F = toast sukses standalone (copy PRD-strict); Jenis Kelamin terkunci dibuang di Reduksi (fitur final 25 numerik + NIS meta).
- v1.10 — SHELL & IDENTITY LOCK: widuri.png sebagai satu-satunya aset untuk logo sidebar, avatar topbar, dan avatar footer sidebar; identitas admin fixed "satnaing / Admin SMA Widuri" + kebab; IDENTITY CLAUSE wajib di setiap prompt.
- v1.11 — Screen 7C Inisialisasi assignment pattern: block "Nilai Belum Terpetakan" dikelompokkan per atribut dengan checkbox bulk-select + radio chips bidang tujuan (semua opsi terlihat, tanpa dropdown) + chip "+ Buat Bidang Baru" yang membentangkan field inline (nama + kode auto editable); frame 7C-2 (pembuatan bidang) dan 7C-3 (semua terpetakan, CTA enable) ditambah; NIS preview = mono primary text.
- v1.12 — Screen 7C interaction model locked: petakan ke bidang existing = satu klik radio chip (immediate apply, tanpa tombol simpan); "Simpan & Petakan" HANYA ada di baris creation bidang baru (commit text input); grup dalam block unmapped dipisahkan sub-header + divider 1px #FDE68A; 7C default = komponen bulk state unselected (per-row select dibuang); success note + CTA enable = derived state (unmapped.length === 0); frame 7C/7C-2/7C-3 = 3 state satu komponen dinamis.
- v1.13 — Screen 8 K-Means & Visualisasi: DBI ditampilkan -1.949 persis PRD/skripsi; riwayat iterasi = dialog centered standalone dengan row accordion (numbering mulai iterasi 0, konvergen di iterasi 4); Scatter Bubble = select sumbu X/Y dari 25 fitur ternormalisasi (titik = siswa, warna = cluster, ukuran = jarak ke centroid); Parallel Coordinates = semua 105 garis, opacity 0.3 untuk tumpukan, hover fokus; frame plan awal 8A-8E.
- v1.14 — DARK MODE CONTRACT v1.0 defined (zinc dark tokens + brand #BE7DD4 + semantic dark tints + forbidden M3 list); Screen 7 dark unified via DARK CONSISTENCY PASS; batched dark pass screens 6-12 wajib prepend contract ini.
- v1.15 — DARK MODE CONTRACT v1.1: NO-SCRIPT RULE (dilarang script mutate class nav; active state static only) + larangan class M3 (bg-primary-fixed dkk) + SHELL TOKEN LOCK dark (search input #121215, ⌘K & toggle #27272A/#3F3F46, avatar polos, period chip shadow-sm); Frame 7D dark direbuild penuh (bug duplikasi kartu di ROW 1 + id dobel + period chip hilang).
- v1.16 — Screen 8 light (8A-8E versi dialog) verified pass: kontrak angka 10 / 5 / -1.949 / distribusi 105 / perpindahan 105-34-12-3-0 sinkron lintas frame; palette C1-C10 locked.
- v1.17 — Screen 8 round 2: dialog riwayat RETIRED → dua tab audit in-page di ujung kanan tab row dengan divider 1px ("Riwayat Iterasi" = convergence card + accordion iterasi 0-4 + tabel proses per iterasi LANGKAH|PERHITUNGAN|HASIL, mock expanded iterasi 4; "Evaluasi DBI" = value card -1.949 + badge "Konvergen & valid" + komponen rumus + cara membaca + interpretasi kualitatif); tabel hasil = HASIL AKHIR (cluster_result) sehingga HANYA ada di 3 tab chart (8B-8D), TIDAK di tab audit; setiap tabel hasil punya toolbar FILTER CLUSTER (Semua Cluster/C1-C10) + URUTKAN (NIS default, cluster asc/desc, distance asc/desc); footer frame hasil = single primary "Jalankan Ulang K-Means"; label kepala chart 8D diresmikan ke whitelist.
- v1.18 — Screen 8 light final: kontrak angka disinkronkan ke Excel skripsi (distribusi 3/3/22/5/14/26/5/12/8/7; perpindahan 105/14/7/2/0); tabel hasil pakai data real + kolom KELAS + toolbar FILTER CLUSTER & URUTKAN (default NIS asc); tab audit "Riwayat Iterasi" & "Evaluasi DBI" right-aligned setelah divider; 8E = in-page tab state dengan 2 expand (Iterasi 1 = daftar perpindahan + tabel perhitungan; Iterasi 4 = bukti konvergen); 8F = panel Evaluasi DBI; tabel hasil HANYA di 3 tab chart; footer frame hasil = single primary.
- v1.19 — Screen 9 light (4 frame: 9A–9D). Navigasi 2 tab (Profil Cluster | Rekomendasi Siswa); cluster selector chips C1–C10 dengan palette; profil card 3 kolom (Akademik/Non-Akademik/Minat); perhitungan bobot transparan 3 komponen per rekomendasi (Prioritas & Alternatif); nuance note "Prioritas ≠ bobot tertinggi"; toolbar tabel rekomendasi = FILTER CLUSTER + FILTER KELAS + URUTKAN; frame 9D bukti filter C5 aktif (14 siswa); tanpa footer bar.
- v1.20 — Screen 9 light verified (9A-9D pass kontrak: chips C1-C10, bobot C3 71/74, pagination 105 & 14); toolbar tab Rekomendasi Siswa jadi 2 baris: baris 1 sub-header "Rekomendasi Jurusan per Siswa" sendiri, baris 2 = search input table-level (placeholder "Cari nama atau NIS siswa...", scope nama contains OR NIS starts-with, AND dengan filter aktif) paling kiri satu baris dengan FILTER CLUSTER / FILTER KELAS / URUTKAN; kolom NIS & BOBOT tabel rekomendasi ditegaskan JetBrains Mono; warna KELAS + weight NAMA disamakan antar 9C/9D; footer sidebar 9B dipin ke dasar halaman; frame plan tetap 4 (9E tidak dibuat).  Screen 9 light LOCKED (9A-9D): toolbar tab Rekomendasi Siswa 2 baris (baris 1 sub-header sendiri; baris 2 = search table-level "Cari nama atau NIS siswa..." paling kiri + FILTER CLUSTER + FILTER KELAS + URUTKAN); scope search = nama contains OR NIS starts-with, AND dengan filter aktif; NIS & BOBOT mono; KELAS/NAMA disamakan antar frame; sidebar 9B stretch penuh. Frame plan tetap 4 (tanpa 9E).
- v1.21 — Screen 10 light LOCKED (3 frame: 10A-10C). Kop PDF = letterhead resmi dari surat (emblem widuri.png + Yayasan/SMA Keluarga Widuri Jakarta + akreditasi A + alamat/telp); blok tanda tangan halaman terakhir (Mengetahui, Kepala Sekolah — Sasmito + stempel, pola dari surat); strict FR-G01 = 2 tabel tanpa lampiran; CTA ganda: outline "Buka PDF" (pdfmake.open) + primary "Unduh PDF"; dokumen rekap 105 baris urut per kelas (XII-1→XII-4) lalu nama A-Z dengan warna baris per kelas (XII-1 #EEF2FF, XII-2 #ECFDF5, XII-3 #FFFBEB, XII-4 #FDF2F8) + legend; nama file mono "Laporan_Rekomendasi_K-Means_2025-2026_Ganjil.pdf"; layout 2 kolom (paper preview + settings card), meta row audit menggantikan info cards.
- v1.22 — Screen 10 light FINAL (4 frame: 10A-10D). 10D = mock dialog print browser light (trigger: outline "Cetak PDF" → pdfmake .print()): preview page 1 penuh (kop letterhead + Tabel 1 10 baris tint XII-1 + continuation note + footer Hal 1/4) + page 2 peek (tint XII-2, bukti pewarnaan per kelas lintas halaman) + panel setting native (Destination Save as PDF, Pages All, Layout Portrait, More settings collapsed) + [Save][Cancel]; "Unduh PDF" = .download() + toast 10C; topbar 10A/10B disamakan ke shell terkunci (tanpa ⌘K, single toggle); toast filename satu baris.
- v1.23 — Screen 10 round 2: identity dipulihkan (logo sidebar + avatar topbar + avatar footer + emblem kop paper = widuri.png di 10A/10B); topbar 10A/10B bersih (tanpa ⌘K, single toggle); outline button resmi "Cetak PDF"; legend "URUTAN & WARNA BARIS" = 4 swatch beda nyata (fill tint + border 1px shade kuat per kelas); toast 10C filename satu baris; [opsional] 10D page-2 peek menampilkan 3 baris tint XII-2 sebagai bukti pewarnaan per kelas.
- v1.22 — Screen 10 light LOCKED (4 frame: 10A-10D): identity widuri.png dipulihkan di shell + kop paper; legend "URUTAN & WARNA BARIS" = 4 swatch beda nyata (fill tint + border shade per kelas); toast filename satu baris; 10D = mock dialog print browser (preview page 1 + page 2 peek + panel setting native + Save/Cancel) dipicu outline "Cetak PDF"; "Unduh PDF" = .download() + toast.
- v1.23 — Screen 11 light LOCKED-plan (4 frame: 11A-11D): dua tab "Riwayat K-Means" | "Riwayat Preprocessing" (kmeans_run vs preprocessing_run sesuai ERD); FILTER PERIODE select (default aktif + lama + Semua Periode); dialog Detail Run = iterasi penuh per run (accordion 0-4) dengan jarak Euclidean per iterasi (1.050 jarak) + tabel perpindahan anggota cluster (NIS • nama • Cx → Cy), angka sinkron kontrak Screen 8 (14/7/2/0); note read-only permanen + nol tombol mutasi (NFR RESTRICT); tab Preprocessing menampilkan metode imputasi + tahapan 4/4.
- v1.24 — Screen 11 light verified (11A-11D): konten & kontrak angka lolos (run #3 sinkron Screen 8/10: 12 Okt 2025 11:25 • 5 iterasi • -1.949 • 105 siswa • perpindahan 105/14/7/2/0; tab Preprocessing 5 run lintas periode tanpa kolom aksi); revisi shell: topbar tanpa blok nama (konsisten Screen 9-10) + footer sidebar tanpa truncate; tipografi info card (Run Terakhir mono 16px satu baris, Eksekutor 16px semibold); kolom ITERASI & SISWA mono; tombol "Lihat Detail" nowrap.
- v1.25 — Screen 12 light PLAN (5 frame: 12A-12E) + generate round 1: dialog 12B/12C/12D LOLOS (form add/edit/delete sesuai whitelist, CTA ungu solid di dialog, eye toggle ×2); frame 12A/12E konten LOLOS (3 baris/1 baris admin, badge Aktif/Nonaktif, delete disabled grey = proteksi P-1 & P-2, note pagination) TAPI shell cacat: logo sidebar glyph + footer inisial "SW" (bukan widuri.png), tanpa active state "Manajemen Admin", CTA outline double-plus, header tabel hitam, 12E overflow kanan + badge "Anda" polos + pagination tanpa chevron.
- v1.26 — DICABUT: revision pass #1 (REV-12-SHELL) GAGAL MENDARAT — nol perubahan visual (Stitch revision engine skip shell changes + crash jaringan). Tidak ada perubahan desain yang sah dari entri ini.
- v1.27 — DICABUT: revision pass #2 (REV-12A-FIX / REV-12E-FIX) GAGAL MENDARAT — sama, nol perubahan. Keputusan pengganti: frame 12A & 12E DIREGENERASI PENUH dari nol (REGEN-12A / REGEN-12E) dengan kontrak lengkap baked-in; 12B/12C/12D tidak diregenerasi.
- v1.28 — Screen 12 light LOCKED (12A-12E): CRUD admin (FR-A03) lengkap — tabel daftar admin tanpa info cards; dialog Tambah/Edit (username + password + confirm, eye toggle); dialog Delete konfirmasi destructive; proteksi P-1 (delete disabled + tooltip di baris "Anda") & P-2 (12E: total=1, delete disabled); rebuild 12A/12E sukses (identity widuri.png, active state, CTA solid single-plus, header tabel muted, pill "Anda", pagination chevron). 🏁 SELURUH MENU SIDEBAR SELESAI (Screen 1-12).
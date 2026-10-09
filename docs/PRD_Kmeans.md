**PRODUCT REQUIREMENTS DOCUMENT (PRD)**

**Sistem Rekomendasi Jurusan Perguruan Tinggi Menggunakan K-Means
Clustering**

**Studi Kasus:** SMA Keluarga Widuri\
**Versi Dokumen:** 1.0 (FINAL & LOCKED)\
**Tanggal:** September 2026

**1. RINGKASAN EKSEKUTIF**

**1.1 Latar Belakang**

Penentuan jurusan perguruan tinggi yang kurang tepat menyebabkan 87%
mahasiswa Indonesia merasa salah jurusan. Di SMA Keluarga Widuri,
rekomendasi jurusan masih berfokus pada nilai akademik dan mengabaikan
aspek minat, bakat, dan non-akademik.

**1.2 Solusi Produk**

Aplikasi web berbasis data mining yang mengintegrasikan data akademik
(Rapor, PTS, PAS) dan non-akademik, memprosesnya melalui pipeline
*preprocessing*, dan menjalankan algoritma **K-Means (K=10)** secara
*custom* untuk menghasilkan *profiling* cluster serta dua rekomendasi
jurusan (Prioritas & Alternatif) per siswa.

**1.3 Nilai Jual & Dampak**

-   Memberikan rekomendasi objektif berbasis data (Davies-Bouldin Index
    target: -1.949).

-   Menyediakan *audit trail* penuh dari data mentah hingga rekomendasi
    (transparansi pipeline).

-   Mendukung pengambilan keputusan guru BK dengan visualisasi data
    interaktif.

**2. USER PERSONA**

Sistem ini dirancang untuk **SATU jenis pengguna (Single Actor)**:

-   **Role:** Admin (Guru BK / Staff Sekolah)

-   **Karakteristik:** Familiar dengan Excel dan operasi web dasar,
    namun tidak memiliki latar belakang *data science* atau *coding*.

-   **Kebutuhan Utama:** Antarmuka yang memandu (wizard/step-by-step),
    pencegahan error (validasi ketat), dan laporan yang bisa dicetak
    untuk dibagikan ke siswa/orang tua.

**3. TECH STACK FINAL (TERKUNCI)**

Keputusan teknologi dikunci berdasarkan prinsip *best practice*,
*maintainability*, dan kesesuaian dengan use-case.

**🖥️ Frontend (React Ecosystem) --- 11 library**

  -----------------------------------------------------------------------------------
  **\#**   **Library**            **Versi/Fungsi**       **Alasan Kunci**
  -------- ---------------------- ---------------------- ----------------------------
  **1**    **React**              **UI framework utama** **Standar industri**

  **2**    **Vite**               **Build tool & dev     **Lebih cepet dari CRA (CRA
                                  server**               deprecated)**

  **3**    **react-router-dom**   **Routing SPA**        **Standar routing React**

  **4**    **Tailwind CSS**       **Styling              **Standar industri 2026**
                                  utility-first**        

  **5**    **shadcn/ui**          **Component library**  **Full control, bukan
                                                         library kaku**

  **6**    **TanStack Query**     **Data fetching &      **Handle
                                  caching**              loading/error/refetch
                                                         otomatis**

  **7**    **React Hook Form**    **Form management**    **Performa bagus, minim
                                                         re-render**

  **8**    **Zod**                **Schema validation**  **Dipakai frontend + backend
                                                         (single source)**

  **9**    **Axios**              **HTTP client**        **Interceptor JWT enak**

  **10**   **echarts +            **Grafik: Bar, Scatter **Satu-satunya yang support
           echarts-for-react**    Bubble, Parallel**     ketiganya**

  **11**   **pdfmake**            **Generate PDF laporan **Deklaratif, client-side,
                                  (tabel)**              jago tabel**
  -----------------------------------------------------------------------------------

**⚙️ Backend (Node.js Ecosystem) --- 10 library**

  ----------------------------------------------------------------------------------
  **\#**   **Library**        **Fungsi**            **Alasan Kunci**
  -------- ------------------ --------------------- --------------------------------
  **12**   **Express.js**     **HTTP framework**    **Klasik, stabil, banyak
                                                    referensi**

  **13**   **Prisma**         **ORM MySQL**         **Type-safe, migration gampang**

  **14**   **Zod**            **Validasi request**  **Konsisten sama frontend**

  **15**   **bcryptjs**       **Hash password**     **Anti plain text**

  **16**   **jsonwebtoken**   **Token auth (JWT)**  **Standar industri**

  **17**   **xlsx (SheetJS)** **Parse file Excel**  **Paling populer buat Excel**

  **18**   **dotenv**         **Environment         **Secret nggak boleh hardcoded**
                              variables**           

  **19**   **cors**           **Handle CORS**       **Wajib frontend-backend beda
                                                    port**

  **20**   **helmet**         **Security headers**  **Best practice keamanan dasar**

  **21**   **morgan**         **Logging HTTP        **Trace & debugging**
                              request**             
  ----------------------------------------------------------------------------------

**🧠 K-Means & Data Processing**

  -------------------------------------------------------------------------------
  **\#**   **Item**      **Keputusan**
  -------- ------------- --------------------------------------------------------
  **22**   **K-Means     **Custom implementation (bukan library) --- biar lu
           Algorithm**   paham Euclidean distance, iterasi, konvergensi dari
                         nol**

  **23**   **Worker      **Built-in Node.js --- biar K-Means nggak blocking event
           Threads**     loop**
  -------------------------------------------------------------------------------

**🧪 Testing**

  --------------------------------------------------------------------------
  **\#**   **Library**         **Fungsi**
  -------- ------------------- ---------------------------------------------
  **24**   **Jest**            **Test runner & assertion**

  **25**   **Supertest**       **Testing API endpoint**
  --------------------------------------------------------------------------

**Catatan Teknis:**

-   Algoritma K-Means diimplementasikan **Custom (Synchronous)** di
    Node.js karena volume data (105 siswa) selesai di bawah 50ms,
    sehingga tidak memblokir *Event Loop* (tidak perlu Worker Thread).

-   Tidak menggunakan date-fns karena periode menggunakan format teks
    sederhana (\"2025/2026 Ganjil\").

**4. FUNCTIONAL REQUIREMENTS (FITUR DETAIL)**

**4.1 Autentikasi & Manajemen Admin**

-   **FR-A01:** Login menggunakan Username & Password (disimpan dengan
    hash bcrypt).

-   **FR-A02:** Proteksi rute menggunakan JWT (expired 1 jam).

-   **FR-A03:** CRUD akun Admin lain (dengan proteksi agar tidak bisa
    menghapus akun sendiri/akun terakhir).

**4.2 Manajemen Periode & Dashboard**

-   **FR-B01:** Membuat dan memilih Periode Aktif (Tahun Ajaran +
    Semester).

-   **FR-B02:** Mencegah duplikasi periode (Unique Constraint).

-   **FR-B03:** Dashboard menampilkan ringkasan statistik siswa, status
    pipeline preprocessing, dan status K-Means pada periode aktif.

**4.3 Input Data Siswa**

-   **FR-C01 (Single Input):** Form input manual. Nilai mata pelajaran
    yang diinput otomatis disalin ke Rapor, PTS, dan PAS. Data ditandai
    dengan flag source_type = \'single_input\'.

-   **FR-C02 (Import Excel):** Upload 1 file Excel dengan 4 sheet
    (Rapor, PTS, PAS, Non-Akademik). Sistem melakukan validasi template,
    preview data, dan import massal.

-   **FR-C03 (Blokir Hapus):** Sistem **MEMBLOKIR** (RESTRICT)
    penghapusan data siswa jika siswa tersebut sudah memiliki hasil
    clustering (cluster_result) dan rekomendasi.

**4.4 Pipeline Preprocessing**

-   **FR-D01 (Integration):** Dijalankan **saat Admin klik tombol** di
    modul preprocessing (bukan saat import). Menghitung rata-rata
    Rapor/PTS/PAS dan menggabungkan data non-akademik.

-   **FR-D02 (Cleaning Interaktif):** Sistem mendeteksi *missing values*
    dan meminta Admin memilih metode imputasi (Mean/Median/Modus). Admin
    juga memetakan kategori yang penulisannya berbeda (misal: \"TI\" =
    \"Teknik Informatika\").

-   **FR-D03 (Transformation):** Konversi kategorikal ke numerik
    berdasarkan tabel mapping skripsi, dilanjutkan Min-Max Scaling
    (0-1).

-   **FR-D04 (Reduction):** Membuang atribut identitas (Nama, Kelas) dan
    mempertahankan NIS sebagai *role meta*.

-   **FR-D05 (Pipeline State):** Jika Admin mengubah konfigurasi di
    tahap hulu (Cleaning), sistem otomatis menghapus (invalidate) hasil
    di tahap hilir (Transformed/Reduced).

**4.5 K-Means Clustering**

-   **FR-E01:** Menjalankan K-Means dengan K=10.

-   **FR-E02:** Menyimpan riwayat setiap iterasi (centroid, jarak,
    penempatan cluster) hingga konvergen.

-   **FR-E03:** Menghitung Davies-Bouldin Index (DBI) untuk evaluasi.

-   **FR-E04:** Menampilkan 3 visualisasi interaktif: Bar Columns,
    Scatter Bubble, dan Parallel Coordinates.

**4.6 Profiling & Rekomendasi**

-   **FR-F01:** Menghasilkan profil karakteristik per cluster (Modus
    dari mapel, ekskul, minat).

-   **FR-F02:** Menghasilkan 2 rekomendasi jurusan per siswa (Prioritas
    & Alternatif).

-   **FR-F03:** Menghitung dan menyimpan skor bobot rekomendasi
    (Akademik 0.6 + Non-Akademik 0.2 + Minat 0.2).

**4.7 Laporan & Riwayat**

-   **FR-G01:** Generate PDF berisi tabel hasil clustering dan
    rekomendasi (tanpa grafik) menggunakan pdfmake.

-   **FR-G02:** Melihat riwayat hasil clustering berdasarkan periode
    (Read-Only).

**5. NON-FUNCTIONAL REQUIREMENTS (NFR)**

1.  **Data Integrity:** Database menggunakan Foreign Key dengan aturan
    ON DELETE RESTRICT untuk memproteksi data historis clustering, dan
    ON DELETE CASCADE untuk data mentah/olahan agar mudah di-reset.

2.  **Security:** Semua input divalidasi menggunakan Zod. Password tidak
    pernah disimpan dalam bentuk plain text.

3.  **Performance:** Waktu proses K-Means untuk 105 siswa \< 1 detik.

4.  **Audit Trail:** Setiap eksekusi preprocessing dan K-Means dicatat
    dalam tabel run beserta ID Admin yang mengeksekusi.

**6. RANCANGAN DATABASE (ERD FINAL)**

**6.1 Entitas Master & Input**

  ---------------------------------------------------------------------------
  **Tabel**        **Fungsi Utama**           **Constraints Penting**
  ---------------- -------------------------- -------------------------------
  admins           Akun administrator         username (Unique)

  periode          Konteks waktu data         tahun_ajaran + semester
                                              (Unique)

  siswa            Identitas dasar siswa      nis (Unique)

  siswa_periode    Relasi siswa ke periode &  siswa_id + periode_id (Unique)
                   source                     

  nilai_akademik   Data mentah Rapor/PTS/PAS  siswa_periode_id + jenis_nilai
                                              (Unique)

  non_akademik     Data mentah ekskul/minat   siswa_periode_id (Unique)
  ---------------------------------------------------------------------------

**6.2 Entitas Preprocessing Pipeline**

  ----------------------------------------------------------------------------
  **Tabel**           **Fungsi Utama**      **Constraints Penting**
  ------------------- --------------------- ----------------------------------
  preprocessing_run   Audit trail eksekusi  FK ke periode, admins
                      pipeline              

  integrated_data     Hasil rata-rata &     preprocessing_run_id +
                      penggabungan          siswa_periode_id (Unique)

  category_mapping    Kamus standardisasi   FK ke preprocessing_run
                      kategori              

  cleaned_data        Data setelah imputasi FK ke preprocessing_run

  transformed_data    Data numerik &        FK ke preprocessing_run
                      ternormalisasi        

  reduced_data        Dataset final untuk   FK ke preprocessing_run
                      K-Means               
  ----------------------------------------------------------------------------

**6.3 Entitas Clustering & Output**

  -----------------------------------------------------------------------------
  **Tabel**            **Fungsi Utama**          **Constraints Penting**
  -------------------- ------------------------- ------------------------------
  kmeans_run           Audit trail eksekusi      FK ke preprocessing_run,
                       K-Means                   admins

  kmeans_iteration     Riwayat iterasi ke-1 s/d  FK ke kmeans_run
                       konvergen                 

  centroid             Titik pusat cluster per   FK ke kmeans_iteration
                       iterasi                   

  cluster_assignment   Penempatan siswa per      FK ke kmeans_iteration
                       iterasi                   

  cluster_result       Hasil cluster final per   kmeans_run_id +
                       siswa                     siswa_periode_id (Unique)

  cluster_profile      Profiling & bidang studi  kmeans_run_id + cluster_code
                       cluster                   (Unique)

  recommendation       Jurusan prioritas &       kmeans_run_id +
                       alternatif + bobot        siswa_periode_id (Unique)
  -----------------------------------------------------------------------------

**6.4 Aturan Integritas (Delete Rules)**

-   **RESTRICT (Blokir Hapus):** Diterapkan pada relasi dari
    cluster_result, cluster_assignment, dan recommendation ke
    siswa_periode. *Artinya: Siswa yang sudah di-cluster tidak bisa
    dihapus dari database.*

-   **CASCADE (Hapus Berantai):** Diterapkan pada relasi data olahan
    (cleaned_data, transformed_data, dll) ke preprocessing_run.
    *Artinya: Jika Admin mereset/menghapus sebuah run preprocessing,
    semua data hasil olahannya ikut terhapus otomatis.*

**7. MILESTONES & SPRINT PLAN**

  -----------------------------------------------------------------------------
  **Sprint**   **Fokus            **Deliverable Utama**
               Pengembangan**     
  ------------ ------------------ ---------------------------------------------
  **Sprint 1** Setup & Auth       Repo FE/BE, Prisma DB, Login JWT, Routing
                                  Proteksi

  **Sprint 2** Master Data        CRUD Periode, Admin, Dashboard UI

  **Sprint 3** Ingestion Data     Single Input, Import Excel (SheetJS),
                                  Validasi Zod

  **Sprint 4** Preprocessing      Logic Integration, Cleaning Interaktif,
                                  Transform, Reduce

  **Sprint 5** Core Algorithm     Custom K-Means, Iterasi, DBI, ECharts
                                  Visualizations

  **Sprint 6** Profiling & Output Logic Bobot, Rekomendasi, PDF Export
                                  (pdfmake)

  **Sprint 7** Polish & Test      Error handling, UI Loading states,
                                  Jest/Supertest
  -----------------------------------------------------------------------------

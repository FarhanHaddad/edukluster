-- CreateTable
CREATE TABLE `admins` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NULL,
    `username` VARCHAR(50) NULL,
    `email` VARCHAR(100) NULL,
    `password` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `email`(`email` ASC),
    UNIQUE INDEX `username`(`username` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `category_mapping` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `preprocessing_run_id` BIGINT NOT NULL,
    `field_name` VARCHAR(50) NULL,
    `raw_value` VARCHAR(150) NULL,
    `standard_value` VARCHAR(150) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `preprocessing_run_id`(`preprocessing_run_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `centroid` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `kmeans_iteration_id` BIGINT NOT NULL,
    `cluster_code` VARCHAR(5) NULL,
    `agama` DECIMAL(8, 4) NULL,
    `pkn` DECIMAL(8, 4) NULL,
    `b_indonesia` DECIMAL(8, 4) NULL,
    `b_inggris` DECIMAL(8, 4) NULL,
    `mtk_wajib` DECIMAL(8, 4) NULL,
    `sejarah` DECIMAL(8, 4) NULL,
    `pjok` DECIMAL(8, 4) NULL,
    `seni_rupa` DECIMAL(8, 4) NULL,
    `b_jepang` DECIMAL(8, 4) NULL,
    `biologi` DECIMAL(8, 4) NULL,
    `fisika` DECIMAL(8, 4) NULL,
    `kimia` DECIMAL(8, 4) NULL,
    `informatika` DECIMAL(8, 4) NULL,
    `mtk_lanjut` DECIMAL(8, 4) NULL,
    `geografi` DECIMAL(8, 4) NULL,
    `sosial` DECIMAL(8, 4) NULL,
    `pkwu` DECIMAL(8, 4) NULL,
    `ekonomi` DECIMAL(8, 4) NULL,
    `ekstrakurikuler` DECIMAL(8, 4) NULL,
    `prestasi` DECIMAL(8, 4) NULL,
    `kemampuan` DECIMAL(8, 4) NULL,
    `organisasi` DECIMAL(8, 4) NULL,
    `kursus` DECIMAL(8, 4) NULL,
    `jurusan_1` DECIMAL(8, 4) NULL,
    `jurusan_2` DECIMAL(8, 4) NULL,
    `created_at` TIMESTAMP(0) NULL,

    INDEX `kmeans_iteration_id`(`kmeans_iteration_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cleaned_data` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `preprocessing_run_id` BIGINT NOT NULL,
    `siswa_periode_id` BIGINT NOT NULL,
    `agama` DECIMAL(8, 4) NULL,
    `pkn` DECIMAL(8, 4) NULL,
    `b_indonesia` DECIMAL(8, 4) NULL,
    `b_inggris` DECIMAL(8, 4) NULL,
    `mtk_wajib` DECIMAL(8, 4) NULL,
    `sejarah` DECIMAL(8, 4) NULL,
    `pjok` DECIMAL(8, 4) NULL,
    `seni_rupa` DECIMAL(8, 4) NULL,
    `b_jepang` DECIMAL(8, 4) NULL,
    `biologi` DECIMAL(8, 4) NULL,
    `fisika` DECIMAL(8, 4) NULL,
    `kimia` DECIMAL(8, 4) NULL,
    `informatika` DECIMAL(8, 4) NULL,
    `mtk_lanjut` DECIMAL(8, 4) NULL,
    `geografi` DECIMAL(8, 4) NULL,
    `sosial` DECIMAL(8, 4) NULL,
    `pkwu` DECIMAL(8, 4) NULL,
    `ekonomi` DECIMAL(8, 4) NULL,
    `ekstrakurikuler` VARCHAR(100) NULL,
    `prestasi` VARCHAR(100) NULL,
    `kemampuan` VARCHAR(100) NULL,
    `organisasi` VARCHAR(100) NULL,
    `kursus` VARCHAR(100) NULL,
    `jurusan_1` VARCHAR(150) NULL,
    `jurusan_2` VARCHAR(150) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `preprocessing_run_id`(`preprocessing_run_id` ASC),
    INDEX `siswa_periode_id`(`siswa_periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cluster_assignment` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `kmeans_iteration_id` BIGINT NOT NULL,
    `siswa_periode_id` BIGINT NOT NULL,
    `cluster_code` VARCHAR(5) NULL,
    `nearest_distance` DECIMAL(12, 8) NULL,
    `created_at` TIMESTAMP(0) NULL,

    INDEX `kmeans_iteration_id`(`kmeans_iteration_id` ASC),
    INDEX `siswa_periode_id`(`siswa_periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cluster_profile` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `kmeans_run_id` BIGINT NOT NULL,
    `cluster_code` VARCHAR(5) NULL,
    `bidang_studi` VARCHAR(150) NULL,
    `jurusan_spesifik` VARCHAR(150) NULL,
    `deskripsi` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `cluster_profile_index_6`(`kmeans_run_id` ASC, `cluster_code` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cluster_result` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `kmeans_run_id` BIGINT NOT NULL,
    `siswa_periode_id` BIGINT NOT NULL,
    `cluster_code` VARCHAR(5) NULL,
    `distance` DECIMAL(12, 8) NULL,
    `created_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `cluster_result_index_5`(`kmeans_run_id` ASC, `siswa_periode_id` ASC),
    INDEX `siswa_periode_id`(`siswa_periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `integrated_data` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `preprocessing_run_id` BIGINT NOT NULL,
    `siswa_periode_id` BIGINT NOT NULL,
    `agama` DECIMAL(8, 4) NULL,
    `pkn` DECIMAL(8, 4) NULL,
    `b_indonesia` DECIMAL(8, 4) NULL,
    `b_inggris` DECIMAL(8, 4) NULL,
    `mtk_wajib` DECIMAL(8, 4) NULL,
    `sejarah` DECIMAL(8, 4) NULL,
    `pjok` DECIMAL(8, 4) NULL,
    `seni_rupa` DECIMAL(8, 4) NULL,
    `b_jepang` DECIMAL(8, 4) NULL,
    `biologi` DECIMAL(8, 4) NULL,
    `fisika` DECIMAL(8, 4) NULL,
    `kimia` DECIMAL(8, 4) NULL,
    `informatika` DECIMAL(8, 4) NULL,
    `mtk_lanjut` DECIMAL(8, 4) NULL,
    `geografi` DECIMAL(8, 4) NULL,
    `sosial` DECIMAL(8, 4) NULL,
    `pkwu` DECIMAL(8, 4) NULL,
    `ekonomi` DECIMAL(8, 4) NULL,
    `ekstrakurikuler` VARCHAR(100) NULL,
    `prestasi` VARCHAR(100) NULL,
    `kemampuan` VARCHAR(100) NULL,
    `organisasi` VARCHAR(100) NULL,
    `kursus` VARCHAR(100) NULL,
    `jurusan_1` VARCHAR(150) NULL,
    `jurusan_2` VARCHAR(150) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `integrated_data_index_4`(`preprocessing_run_id` ASC, `siswa_periode_id` ASC),
    INDEX `siswa_periode_id`(`siswa_periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kmeans_iteration` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `kmeans_run_id` BIGINT NOT NULL,
    `iteration_number` INTEGER NULL,
    `is_converged` BOOLEAN NULL,
    `created_at` TIMESTAMP(0) NULL,

    INDEX `kmeans_run_id`(`kmeans_run_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `kmeans_run` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `preprocessing_run_id` BIGINT NOT NULL,
    `admin_id` BIGINT NOT NULL,
    `k` INTEGER NULL DEFAULT 10,
    `distance_method` VARCHAR(30) NULL,
    `status` VARCHAR(20) NULL,
    `total_iteration` INTEGER NULL,
    `converged` BOOLEAN NULL,
    `started_at` DATETIME(0) NULL,
    `completed_at` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `admin_id`(`admin_id` ASC),
    INDEX `preprocessing_run_id`(`preprocessing_run_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `nilai_akademik` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `siswa_periode_id` BIGINT NOT NULL,
    `jenis_nilai` VARCHAR(10) NOT NULL,
    `agama` DECIMAL(5, 2) NULL,
    `pkn` DECIMAL(5, 2) NULL,
    `b_indonesia` DECIMAL(5, 2) NULL,
    `b_inggris` DECIMAL(5, 2) NULL,
    `mtk_wajib` DECIMAL(5, 2) NULL,
    `sejarah` DECIMAL(5, 2) NULL,
    `pjok` DECIMAL(5, 2) NULL,
    `seni_rupa` DECIMAL(5, 2) NULL,
    `b_jepang` DECIMAL(5, 2) NULL,
    `biologi` DECIMAL(5, 2) NULL,
    `fisika` DECIMAL(5, 2) NULL,
    `kimia` DECIMAL(5, 2) NULL,
    `informatika` DECIMAL(5, 2) NULL,
    `mtk_lanjut` DECIMAL(5, 2) NULL,
    `geografi` DECIMAL(5, 2) NULL,
    `sosial` DECIMAL(5, 2) NULL,
    `pkwu` DECIMAL(5, 2) NULL,
    `ekonomi` DECIMAL(5, 2) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `nilai_akademik_index_2`(`siswa_periode_id` ASC, `jenis_nilai` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `non_akademik` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `siswa_periode_id` BIGINT NOT NULL,
    `ekstrakurikuler` VARCHAR(100) NULL,
    `prestasi` VARCHAR(100) NULL,
    `kemampuan` VARCHAR(100) NULL,
    `organisasi` VARCHAR(100) NULL,
    `kursus` VARCHAR(100) NULL,
    `jurusan_1` VARCHAR(150) NULL,
    `jurusan_2` VARCHAR(150) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `non_akademik_index_3`(`siswa_periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `periode` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `tahun_ajaran` VARCHAR(20) NULL,
    `semester` VARCHAR(10) NULL,
    `nama_periode` VARCHAR(50) NULL,
    `status` VARCHAR(20) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `periode_index_0`(`tahun_ajaran` ASC, `semester` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `preprocessing_run` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `periode_id` BIGINT NOT NULL,
    `admin_id` BIGINT NOT NULL,
    `imputation_method` VARCHAR(20) NULL,
    `status` VARCHAR(20) NULL,
    `started_at` DATETIME(0) NULL,
    `completed_at` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `admin_id`(`admin_id` ASC),
    INDEX `periode_id`(`periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `recommendation` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `kmeans_run_id` BIGINT NOT NULL,
    `siswa_periode_id` BIGINT NOT NULL,
    `cluster_code` VARCHAR(5) NULL,
    `recommendation_1` VARCHAR(150) NULL,
    `bobot_1` DECIMAL(5, 2) NULL,
    `recommendation_2` VARCHAR(150) NULL,
    `bobot_2` DECIMAL(5, 2) NULL,
    `created_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `recommendation_index_7`(`kmeans_run_id` ASC, `siswa_periode_id` ASC),
    INDEX `siswa_periode_id`(`siswa_periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reduced_data` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `preprocessing_run_id` BIGINT NOT NULL,
    `siswa_periode_id` BIGINT NOT NULL,
    `agama` DECIMAL(8, 4) NULL,
    `pkn` DECIMAL(8, 4) NULL,
    `b_indonesia` DECIMAL(8, 4) NULL,
    `b_inggris` DECIMAL(8, 4) NULL,
    `mtk_wajib` DECIMAL(8, 4) NULL,
    `sejarah` DECIMAL(8, 4) NULL,
    `pjok` DECIMAL(8, 4) NULL,
    `seni_rupa` DECIMAL(8, 4) NULL,
    `b_jepang` DECIMAL(8, 4) NULL,
    `biologi` DECIMAL(8, 4) NULL,
    `fisika` DECIMAL(8, 4) NULL,
    `kimia` DECIMAL(8, 4) NULL,
    `informatika` DECIMAL(8, 4) NULL,
    `mtk_lanjut` DECIMAL(8, 4) NULL,
    `geografi` DECIMAL(8, 4) NULL,
    `sosial` DECIMAL(8, 4) NULL,
    `pkwu` DECIMAL(8, 4) NULL,
    `ekonomi` DECIMAL(8, 4) NULL,
    `ekstrakurikuler` DECIMAL(8, 4) NULL,
    `prestasi` DECIMAL(8, 4) NULL,
    `kemampuan` DECIMAL(8, 4) NULL,
    `organisasi` DECIMAL(8, 4) NULL,
    `kursus` DECIMAL(8, 4) NULL,
    `jurusan_1` DECIMAL(8, 4) NULL,
    `jurusan_2` DECIMAL(8, 4) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `preprocessing_run_id`(`preprocessing_run_id` ASC),
    INDEX `siswa_periode_id`(`siswa_periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `siswa` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `nis` VARCHAR(20) NULL,
    `nama` VARCHAR(150) NULL,
    `jenis_kelamin` VARCHAR(1) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `nis`(`nis` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `siswa_periode` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `siswa_id` BIGINT NOT NULL,
    `periode_id` BIGINT NOT NULL,
    `kelas` VARCHAR(20) NULL,
    `source_type` VARCHAR(20) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `periode_id`(`periode_id` ASC),
    UNIQUE INDEX `siswa_periode_index_1`(`siswa_id` ASC, `periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transformed_data` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `preprocessing_run_id` BIGINT NOT NULL,
    `siswa_periode_id` BIGINT NOT NULL,
    `agama` DECIMAL(8, 4) NULL,
    `pkn` DECIMAL(8, 4) NULL,
    `b_indonesia` DECIMAL(8, 4) NULL,
    `b_inggris` DECIMAL(8, 4) NULL,
    `mtk_wajib` DECIMAL(8, 4) NULL,
    `sejarah` DECIMAL(8, 4) NULL,
    `pjok` DECIMAL(8, 4) NULL,
    `seni_rupa` DECIMAL(8, 4) NULL,
    `b_jepang` DECIMAL(8, 4) NULL,
    `biologi` DECIMAL(8, 4) NULL,
    `fisika` DECIMAL(8, 4) NULL,
    `kimia` DECIMAL(8, 4) NULL,
    `informatika` DECIMAL(8, 4) NULL,
    `mtk_lanjut` DECIMAL(8, 4) NULL,
    `geografi` DECIMAL(8, 4) NULL,
    `sosial` DECIMAL(8, 4) NULL,
    `pkwu` DECIMAL(8, 4) NULL,
    `ekonomi` DECIMAL(8, 4) NULL,
    `ekstrakurikuler` DECIMAL(8, 4) NULL,
    `prestasi` DECIMAL(8, 4) NULL,
    `kemampuan` DECIMAL(8, 4) NULL,
    `organisasi` DECIMAL(8, 4) NULL,
    `kursus` DECIMAL(8, 4) NULL,
    `jurusan_1` DECIMAL(8, 4) NULL,
    `jurusan_2` DECIMAL(8, 4) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `preprocessing_run_id`(`preprocessing_run_id` ASC),
    INDEX `siswa_periode_id`(`siswa_periode_id` ASC),
    PRIMARY KEY (`id` ASC)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `category_mapping` ADD CONSTRAINT `category_mapping_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `centroid` ADD CONSTRAINT `centroid_ibfk_1` FOREIGN KEY (`kmeans_iteration_id`) REFERENCES `kmeans_iteration`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cleaned_data` ADD CONSTRAINT `cleaned_data_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cleaned_data` ADD CONSTRAINT `cleaned_data_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cluster_assignment` ADD CONSTRAINT `cluster_assignment_ibfk_1` FOREIGN KEY (`kmeans_iteration_id`) REFERENCES `kmeans_iteration`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cluster_assignment` ADD CONSTRAINT `cluster_assignment_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cluster_profile` ADD CONSTRAINT `cluster_profile_ibfk_1` FOREIGN KEY (`kmeans_run_id`) REFERENCES `kmeans_run`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cluster_result` ADD CONSTRAINT `cluster_result_ibfk_1` FOREIGN KEY (`kmeans_run_id`) REFERENCES `kmeans_run`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cluster_result` ADD CONSTRAINT `cluster_result_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `integrated_data` ADD CONSTRAINT `integrated_data_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `integrated_data` ADD CONSTRAINT `integrated_data_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `kmeans_iteration` ADD CONSTRAINT `kmeans_iteration_ibfk_1` FOREIGN KEY (`kmeans_run_id`) REFERENCES `kmeans_run`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `kmeans_run` ADD CONSTRAINT `kmeans_run_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `kmeans_run` ADD CONSTRAINT `kmeans_run_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `nilai_akademik` ADD CONSTRAINT `nilai_akademik_ibfk_1` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `non_akademik` ADD CONSTRAINT `non_akademik_ibfk_1` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `preprocessing_run` ADD CONSTRAINT `preprocessing_run_ibfk_1` FOREIGN KEY (`periode_id`) REFERENCES `periode`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `preprocessing_run` ADD CONSTRAINT `preprocessing_run_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `recommendation` ADD CONSTRAINT `recommendation_ibfk_1` FOREIGN KEY (`kmeans_run_id`) REFERENCES `kmeans_run`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `recommendation` ADD CONSTRAINT `recommendation_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `reduced_data` ADD CONSTRAINT `reduced_data_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `reduced_data` ADD CONSTRAINT `reduced_data_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `siswa_periode` ADD CONSTRAINT `siswa_periode_ibfk_1` FOREIGN KEY (`siswa_id`) REFERENCES `siswa`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `siswa_periode` ADD CONSTRAINT `siswa_periode_ibfk_2` FOREIGN KEY (`periode_id`) REFERENCES `periode`(`id`) ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transformed_data` ADD CONSTRAINT `transformed_data_ibfk_1` FOREIGN KEY (`preprocessing_run_id`) REFERENCES `preprocessing_run`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transformed_data` ADD CONSTRAINT `transformed_data_ibfk_2` FOREIGN KEY (`siswa_periode_id`) REFERENCES `siswa_periode`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;


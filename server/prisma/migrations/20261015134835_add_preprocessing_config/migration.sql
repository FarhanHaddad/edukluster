/*
  Warnings:

  - A unique constraint covering the columns `[preprocessing_run_id,field_name,raw_value]` on the table `category_mapping` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `preprocessing_run` ADD COLUMN `cleaned_at` DATETIME(0) NULL,
    ADD COLUMN `cleaned_duration_ms` INTEGER NULL,
    ADD COLUMN `integrated_at` DATETIME(0) NULL,
    ADD COLUMN `integrated_duration_ms` INTEGER NULL,
    ADD COLUMN `reduced_at` DATETIME(0) NULL,
    ADD COLUMN `reduced_duration_ms` INTEGER NULL,
    ADD COLUMN `reduced_invalidated_at` DATETIME(0) NULL,
    ADD COLUMN `transformed_at` DATETIME(0) NULL,
    ADD COLUMN `transformed_duration_ms` INTEGER NULL,
    ADD COLUMN `transformed_invalidated_at` DATETIME(0) NULL;

-- CreateTable
CREATE TABLE `category_option` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `periode_id` BIGINT NOT NULL,
    `field_name` VARCHAR(30) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `code` INTEGER NOT NULL,

    INDEX `category_option_periode_id_idx`(`periode_id`),
    UNIQUE INDEX `category_option_index_name`(`periode_id`, `field_name`, `name`),
    UNIQUE INDEX `category_option_index_code`(`periode_id`, `field_name`, `code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `category_assignment` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `periode_id` BIGINT NOT NULL,
    `field_name` VARCHAR(30) NOT NULL,
    `standard_value` VARCHAR(191) NOT NULL,
    `option_id` BIGINT NOT NULL,

    INDEX `category_assignment_option_id_idx`(`option_id`),
    UNIQUE INDEX `category_assignment_index_0`(`periode_id`, `field_name`, `standard_value`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `category_mapping_index_run_field_raw` ON `category_mapping`(`preprocessing_run_id`, `field_name`, `raw_value`);

-- AddForeignKey
ALTER TABLE `category_option` ADD CONSTRAINT `category_option_periode_id_fkey` FOREIGN KEY (`periode_id`) REFERENCES `periode`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `category_assignment` ADD CONSTRAINT `category_assignment_periode_id_fkey` FOREIGN KEY (`periode_id`) REFERENCES `periode`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `category_assignment` ADD CONSTRAINT `category_assignment_option_id_fkey` FOREIGN KEY (`option_id`) REFERENCES `category_option`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

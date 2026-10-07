/*
  Warnings:

  - You are about to drop the column `email` on the `admins` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX `email` ON `admins`;

-- AlterTable
ALTER TABLE `admins` DROP COLUMN `email`;

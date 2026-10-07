const { PrismaClient } = require("@prisma/client");
const bcrypt = require("bcryptjs");
const prisma = new PrismaClient();

async function main() {
  const passwordHash = await bcrypt.hash("widuri2026", 10);

  // 1. Seed Admin — kolom mengikuti tabel `admins` di SQL DBDiagram
  await prisma.admin.upsert({
    where: { username: "satnaing" },
    update: {},
    create: {
      username: "satnaing",
      password: passwordHash,
      name: "SatNaing", //⚠️ pakai `name`, BUKAN `nama`
      status: true, // admin aktif (Sprint 2: Manajemen Admin)
    },
  });

  // 2. Seed Periode — kolom mengikuti tabel `periode` di SQL DBDiagram
  await prisma.periode.upsert({
    where: {
      tahunAjaran_semester: {
        tahunAjaran: "2025/2026",
        semester: "GANJIL",
      },
    },
    update: {},
    create: {
      tahunAjaran: "2025/2026",
      semester: "GANJIL",
      namaPeriode: "2025/2026 Ganjil", // ← camelCase, dipetakan ke kolom `nama_periode` via @map
      status: 'AKTIF', // ⚠️ boolean (aktif), bukan varchar 'AKTIF'
    },
  });

  console.log("✅ Seed selesai: admin satnaing + periode 2025/2026 Ganjil");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());

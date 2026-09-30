const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcryptjs');

const prisma = new PrismaClient();

async function main() {
  const passwordHash = await bcrypt.hash('widuri2026', 10);

  await prisma.admin.upsert({
    where: { username: 'satnaing' },
    update: {},
    create: { username: 'satnaing', password: passwordHash, nama: 'Sat Naing', status: true },
  });

  await prisma.periode.upsert({
    where: { tahunAjaran_semester: { tahunAjaran: '2025/2026', semester: 'GANJIL' } },
    update: {},
    create: { tahunAjaran: '2025/2026', semester: 'GANJIL', isAktif: true },
  });

  console.log('✅ Seed selesai: admin satnaing + periode 2025/2026 Ganjil');
}

main()
  .catch((e) => { console.error(e); process.exit(1); })
  .finally(() => prisma.$disconnect());
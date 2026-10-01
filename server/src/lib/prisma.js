const { PrismaClient } = require('@prisma/client');

// Singleton PrismaClient agar tidak membuat koneksi ganda saat hot-reload (nodemon).
const globalForPrisma = globalThis;

const prisma = globalForPrisma.__prisma || new PrismaClient();

if (process.env.NODE_ENV !== 'production') {
  globalForPrisma.__prisma = prisma;
}

module.exports = prisma;

const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const prisma = require('../lib/prisma');
const ApiError = require('../utils/ApiError');
const env = require('../config/env');

// FR-A01: login admin dengan username + password (bcrypt).
async function login({ username, password }) {
  const admin = await prisma.admin.findUnique({ where: { username } });

  // Samakan pesan untuk user tidak ditemukan & password salah (anti user-enumeration).
  if (!admin || !admin.password) {
    throw new ApiError(401, 'Username atau password salah');
  }

  const valid = await bcrypt.compare(password, admin.password);
  if (!valid) {
    throw new ApiError(401, 'Username atau password salah');
  }

  // FR-M02 (Sprint 2): tolak login untuk admin nonaktif — cek SEBELUM jwt.sign.
  if (admin.status === false) {
    throw new ApiError(403, 'Akun Anda nonaktif. Hubungi administrator lain.');
  }

  // RULE WAJIB: BigInt -> Number() sebelum jwt.sign.
  const token = jwt.sign(
    { sub: Number(admin.id), username: admin.username },
    env.JWT_SECRET,
    { expiresIn: env.JWT_EXPIRES_IN }
  );

  return {
    token,
    admin: {
      id: Number(admin.id),
      username: admin.username,
      name: admin.name,
    },
  };
}

// FR-A02: profil admin dari sesi JWT.
async function me(id) {
  const admin = await prisma.admin.findUnique({
    where: { id: BigInt(id) },
    select: { id: true, username: true, name: true },
  });

  if (!admin) {
    throw new ApiError(401, 'Sesi tidak valid');
  }

  return {
    id: Number(admin.id),
    username: admin.username,
    name: admin.name,
  };
}

module.exports = { login, me };

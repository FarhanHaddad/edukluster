const bcrypt = require('bcryptjs');
const prisma = require('../lib/prisma');
const ApiError = require('../utils/ApiError');

// Field aman untuk response admin — password TIDAK PERNAH dikirim keluar (FR-A03).
const SAFE_ADMIN_SELECT = {
  id: true,
  name: true,
  username: true,
  email: true,
  status: true,
  createdAt: true,
};

// RULE WAJIB: BigInt -> Number di semua response.
function toResponseItem(admin) {
  return {
    id: Number(admin.id),
    name: admin.name,
    username: admin.username,
    email: admin.email,
    status: admin.status,
    createdAt: admin.createdAt,
  };
}

// Peta error unique Prisma (P2002) ke pesan 409 sesuai kontrak FE.
function throwUniqueConflict(err) {
  if (err && err.code === 'P2002') {
    const target = (err.meta && err.meta.target) || '';
    // Normalisasi nama field (Prisma bisa mengirim 'email', ['email'], atau indeks 'admins.email_idx').
    const flat = Array.isArray(target) ? target.join(',') : String(target);
    if (flat.includes('email')) {
      throw new ApiError(409, 'Email sudah terdaftar.');
    }
    throw new ApiError(409, 'Username sudah terdaftar.');
  }
  throw err;
}

// GET /api/admins — daftar admin, urutan createdAt asc (FR-A03).
async function listAdmins() {
  const admins = await prisma.admin.findMany({
    orderBy: { createdAt: 'asc' },
    select: SAFE_ADMIN_SELECT,
  });

  const items = admins.map(toResponseItem);
  return { items, total: items.length };
}

// POST /api/admins — buat admin baru; password di-hash bcrypt (FR-A03).
async function createAdmin({ username, password, name, email }) {
  const passwordHash = await bcrypt.hash(password, 10);

  try {
    const admin = await prisma.admin.create({
      data: {
        username,
        password: passwordHash,
        // name absen dari body FE → default = username.
        name: name || username,
        email: email || null,
        status: true,
      },
      select: SAFE_ADMIN_SELECT,
    });
    return toResponseItem(admin);
  } catch (err) {
    throwUniqueConflict(err);
  }
}

// PUT /api/admins/:id — update username; password terisi = hash, kosong = tidak diubah.
async function updateAdmin(id, { username, password }) {
  const target = await prisma.admin.findUnique({ where: { id: BigInt(id) } });
  if (!target) {
    throw new ApiError(404, 'Admin tidak ditemukan.');
  }

  const data = { username };
  if (password) {
    data.password = await bcrypt.hash(password, 10);
  }

  try {
    const admin = await prisma.admin.update({
      where: { id: BigInt(id) },
      data,
      select: SAFE_ADMIN_SELECT,
    });
    return toResponseItem(admin);
  } catch (err) {
    throwUniqueConflict(err);
  }
}

// PATCH /api/admins/:id/status — toggle status BOOLEAN admin + proteksi P-1/P-2 (FR-M02).
async function toggleAdminStatus(id, currentAdminId) {
  const target = await prisma.admin.findUnique({ where: { id: BigInt(id) } });
  if (!target) {
    throw new ApiError(404, 'Admin tidak ditemukan.');
  }

  // Menonaktifkan admin AKTIF → jalankan guard berurutan.
  if (target.status === true) {
    // P-1: admin tidak boleh menonaktifkan akun sendiri.
    if (Number(target.id) === currentAdminId) {
      throw new ApiError(409, 'Anda tidak dapat menonaktifkan akun sendiri.');
    }
    // P-2: tidak boleh menghapus satu-satunya admin aktif.
    const activeCount = await prisma.admin.count({ where: { status: true } });
    if (activeCount <= 1) {
      throw new ApiError(409, 'Tidak dapat menonaktifkan admin aktif terakhir.');
    }
  }

  const admin = await prisma.admin.update({
    where: { id: BigInt(id) },
    data: { status: !target.status },
    select: SAFE_ADMIN_SELECT,
  });
  return toResponseItem(admin);
}

// DELETE /api/admins/:id — hapus admin + proteksi P-1/P-2/P-3 (FR-A03).
async function deleteAdmin(id, currentAdminId) {
  const target = await prisma.admin.findUnique({ where: { id: BigInt(id) } });
  if (!target) {
    throw new ApiError(404, 'Admin tidak ditemukan.');
  }

  // P-1: admin tidak boleh menghapus akun sendiri.
  if (Number(target.id) === currentAdminId) {
    throw new ApiError(409, 'Anda tidak dapat menghapus akun sendiri.');
  }

  // P-2: tidak boleh menghapus admin terakhir yang tersisa di sistem.
  const totalAdmin = await prisma.admin.count();
  if (totalAdmin <= 1) {
    throw new ApiError(409, 'Tidak dapat menghapus admin terakhir.');
  }

  try {
    await prisma.admin.delete({ where: { id: BigInt(id) } });
  } catch (err) {
    // P-3: FK RESTRICT kmeans_run/preprocessing_run → admin punya riwayat eksekusi.
    if (err && err.code === 'P2003') {
      throw new ApiError(409, 'Admin memiliki riwayat eksekusi sehingga tidak dapat dihapus.');
    }
    throw err;
  }

  return toResponseItem(target);
}

module.exports = { listAdmins, createAdmin, updateAdmin, toggleAdminStatus, deleteAdmin };

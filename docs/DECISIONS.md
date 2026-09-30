# DECISIONS LOG (ADR) — EduCluster

- ADR-001: Monorepo (client/ server/ shared/ docs/ + npm workspaces). Alasan: developer solo, Zod single-source FE+BE, satu repo untuk penguji & publik.
- ADR-002: Backend-first, vertical slice per sprint. Alasan: risiko tertinggi = reproduksi angka K-Means skripsi; kontrak angka desain = acceptance test siap pakai.
- ADR-003: Server pakai CommonJS. Alasan: Jest + Supertest zero-config di Sprint 7.
- ADR-004: Database run-based (preprocessing_run / kmeans_run = snapshot eksekusi); ON DELETE RESTRICT untuk hasil historis, CASCADE untuk data olahan. Alasan: audit trail (NFR), invalidasi hilir (FR-D05), blokir hapus siswa ter-cluster (FR-C03).
- ADR-005: Dark mode dikerjakan terakhir (Sprint 7) via class toggle + token DESIGN.md. Alasan: fokus implementasi ke logika & validasi algoritma dulu.
- ADR-006: Pembagian role — Qwen Coder = eksekutor kode via repo GitHub; Mentor chat = arsitek & reviewer; Owner (Farhan) = merge, tag, keputusan final.
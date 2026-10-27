// Davies-Bouldin Index standar (pure function, tanpa Prisma/HTTP) - TIKET BE-KM-1.
// DBI = (1/k) * Σ_i max_{i≠j} (S_i + S_j) / d(i,j)
// S_i = rata-rata jarak Euclidean anggota cluster i ke centroid sendiri.
// Return string Decimal(8,4) HALF_UP (konvensi presisi repo; internal float64).

'use strict';

const { euclid } = require('./kmeans.engine');

// Pembulatan HALF_UP eksplisit pada n desimal (bukan toFixed yang banker-ish utk kasus tertentu).
function roundHalfUp(value, digits) {
  if (!Number.isFinite(value)) return null;
  const factor = 10 ** digits;
  // Geser, tambah epsilon kecil untuk koreksi float, lalu Math.round (half-up utk nilai positif).
  const scaled = value * factor;
  const rounded = Math.round(scaled + Number.EPSILON * Math.abs(scaled));
  return (rounded / factor).toFixed(digits);
}

/**
 * @param {number[][][]} clusters array per-cluster berisi titik-tangga (vektor fitur) anggota.
 * @param {number[][]} centroids centroid tiap cluster (panjang sama dgn clusters).
 * @returns {string|null} DBI sebagai string Decimal(8,4) HALF_UP; null bila tidak terdefinisi
 *          (mis. semua cluster kosong / kurang dari 2 cluster terisi berjarak nol).
 */
function computeDBI(clusters, centroids) {
  const k = centroids.length;
  if (!Array.isArray(clusters) || clusters.length !== k) throw new Error('clusters != centroids');

  // S_i: scatter/rata-rata jarak intra-cluster; hanya cluster terisi yang dihitung.
  const scatter = new Array(k).fill(0);
  for (let i = 0; i < k; i++) {
    const members = clusters[i];
    if (members.length > 0) {
      let sum = 0;
      for (const p of members) sum += euclid(p, centroids[i]);
      scatter[i] = sum / members.length;
    }
  }

  let total = 0;
  let counted = 0;
  for (let i = 0; i < k; i++) {
    if (clusters[i].length === 0) continue; // cluster kosong tak ikut rasio
    let worst = 0;
    let found = false;
    for (let j = 0; j < k; j++) {
      if (j === i || clusters[j].length === 0) continue;
      const dij = euclid(centroids[i], centroids[j]);
      if (dij === 0) continue; // centroid kembar -> rasio tak terdefinisi, lewati
      const ratio = (scatter[i] + scatter[j]) / dij;
      if (!found || ratio > worst) {
        worst = ratio;
        found = true;
      }
    }
    if (found) {
      total += worst;
      counted++;
    }
  }

  if (counted === 0) return null;
  return roundHalfUp(total / counted, 4);
}

module.exports = { computeDBI, roundHalfUp };

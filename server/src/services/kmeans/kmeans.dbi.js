// Davies-Bouldin Index standar (pure function, tanpa Prisma/HTTP) - TIKET BE-KM-1.
// DBI = (1/k) * Σ_i max_{i≠j} (S_i + S_j) / d(i,j)
// S_i = rata-rata jarak Euclidean anggota cluster i ke centroid sendiri.
// Return string Decimal(8,4) HALF_UP (konvensi presisi repo; internal float64).
// Refactor readability BE-KM-1.5: tanpa variabel 1 huruf, rumus identik secara matematis.

'use strict';

const { euclid } = require('./kmeans.engine');

// Pembulatan HALF_UP eksplisit pada decimalPlaces desimal (bukan toFixed yang banker-ish).
function roundHalfUp(value, decimalPlaces) {
  if (!Number.isFinite(value)) return null;
  const factor = 10 ** decimalPlaces;
  // Geser, tambah epsilon kecil untuk koreksi float, lalu Math.round (half-up utk nilai positif).
  const scaled = value * factor;
  const rounded = Math.round(scaled + Number.EPSILON * Math.abs(scaled));
  return (rounded / factor).toFixed(decimalPlaces);
}

/**
 * @param {number[][][]} clusters array per-cluster berisi titik-tangga (vektor fitur) anggota.
 * @param {number[][]} centroids centroid tiap cluster (panjang sama dgn clusters).
 * @returns {string|null} DBI sebagai string Decimal(8,4) HALF_UP; null bila tidak terdefinisi
 *          (mis. semua cluster kosong / kurang dari 2 cluster terisi berjarak nol).
 */
function computeDBI(clusters, centroids) {
  const totalClusters = centroids.length;
  if (!Array.isArray(clusters) || clusters.length !== totalClusters) {
    throw new Error('clusters != centroids');
  }

  // intraClusterDistance[i]: scatter/rata-rata jarak intra-cluster; hanya cluster terisi dihitung.
  const intraClusterDistance = new Array(totalClusters).fill(0);
  for (let clusterIndex = 0; clusterIndex < totalClusters; clusterIndex++) {
    const members = clusters[clusterIndex];
    const memberCount = members.length;
    if (memberCount > 0) {
      let distanceSum = 0;
      for (const memberPoint of members) distanceSum += euclid(memberPoint, centroids[clusterIndex]);
      intraClusterDistance[clusterIndex] = distanceSum / memberCount;
    }
  }

  let ratioTotal = 0;
  let countedClusters = 0;
  for (let firstClusterIndex = 0; firstClusterIndex < totalClusters; firstClusterIndex++) {
    if (clusters[firstClusterIndex].length === 0) continue; // cluster kosong tak ikut rasio
    let worstRatio = 0;
    let foundPair = false;
    for (let secondClusterIndex = 0; secondClusterIndex < totalClusters; secondClusterIndex++) {
      if (secondClusterIndex === firstClusterIndex || clusters[secondClusterIndex].length === 0) {
        continue;
      }
      const interClusterDistance = euclid(centroids[firstClusterIndex], centroids[secondClusterIndex]);
      if (interClusterDistance === 0) continue; // centroid kembar -> rasio tak terdefinisi, lewati
      const closenessRatio =
        (intraClusterDistance[firstClusterIndex] + intraClusterDistance[secondClusterIndex]) /
        interClusterDistance;
      if (!foundPair || closenessRatio > worstRatio) {
        worstRatio = closenessRatio;
        foundPair = true;
      }
    }
    if (foundPair) {
      ratioTotal += worstRatio;
      countedClusters++;
    }
  }

  if (countedClusters === 0) return null;
  return roundHalfUp(ratioTotal / countedClusters, 4);
}

module.exports = { computeDBI, roundHalfUp };

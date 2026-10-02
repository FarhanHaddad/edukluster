// Penyimpanan token sesi admin (FR-A01/A02 sisi FE).
// Kontrak sederhana: token JWT di localStorage.
const TOKEN_KEY = 'edukluster.token';

export function getToken() {
  return localStorage.getItem(TOKEN_KEY);
}

export function setToken(token) {
  localStorage.setItem(TOKEN_KEY, token);
}

export function clearToken() {
  localStorage.removeItem(TOKEN_KEY);
}

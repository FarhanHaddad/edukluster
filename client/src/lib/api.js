import axios from 'axios';
import { getToken, clearToken } from './authStorage';

// Instance axios terpusat. baseURL dari env client (VITE_API_URL, mis. http://localhost:5000/api).
const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL ?? 'http://localhost:5000/api',
});

// Sisipkan token bearer pada setiap request bila ada.
api.interceptors.request.use((config) => {
  const token = getToken();
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Respons 401 -> buang token + redirect ke /login (kecuali saat sudah di halaman login).
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      clearToken();
      if (window.location.pathname !== '/login') {
        window.location.assign('/login');
      }
    }
    return Promise.reject(error);
  }
);

export default api;

import { createContext, useCallback, useContext, useEffect, useState } from 'react';
import api from '../lib/api';
import { getToken, setToken, clearToken } from '../lib/authStorage';

// Auth sederhana (FR-A02): token di localStorage; saat app boot & token ada ->
// panggil /auth/me untuk validasi; gagal -> buang token.
const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [admin, setAdmin] = useState(null);
  // 'loading' = boot check berjalan, 'ready' = selesai.
  const [bootState, setBootState] = useState(getToken() ? 'loading' : 'ready');

  useEffect(() => {
    const token = getToken();
    if (!token) {
      setBootState('ready');
      return undefined;
    }

    let cancelled = false;
    api
      .get('/auth/me')
      .then((res) => {
        if (cancelled) return;
        setAdmin(res.data?.data ?? null);
        setBootState('ready');
      })
      .catch(() => {
        if (cancelled) return;
        // Token tidak valid/kedaluwarsa -> sesi dibuang.
        clearToken();
        setAdmin(null);
        setBootState('ready');
      });

    return () => {
      cancelled = true;
    };
  }, []);

  const login = useCallback(async (credentials) => {
    const res = await api.post('/auth/login', credentials);
    const data = res.data?.data;
    setToken(data.token);
    setAdmin(data.admin);
    return data;
  }, []);

  const logout = useCallback(() => {
    clearToken();
    setAdmin(null);
  }, []);

  return (
    <AuthContext.Provider value={{ admin, bootState, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) {
    throw new Error('useAuth harus dipakai di dalam AuthProvider');
  }
  return ctx;
}

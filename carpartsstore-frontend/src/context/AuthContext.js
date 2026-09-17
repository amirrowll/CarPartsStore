import React, { createContext, useContext, useState, useEffect } from 'react';
import { authService } from '../services/api';
const AuthContext = createContext(undefined);
export const useAuth = () => {
    const context = useContext(AuthContext);
    if (!context) {
        throw new Error('useAuth must be used within AuthProvider');
    }
    return context;
};
export const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null);
    const [token, setToken] = useState(localStorage.getItem('authToken'));
    const [isLoading, setIsLoading] = useState(true);
    useEffect(() => {
        // Check if user is logged in on mount
        const loadUser = async () => {
            const storedToken = localStorage.getItem('authToken');
            if (storedToken) {
                try {
                    // Try to get user profile
                    const user = await authService.getProfile();
                    setUser(user);
                    setToken(storedToken);
                }
                catch (error) {
                    // Token is invalid or expired
                    localStorage.removeItem('authToken');
                    setUser(null);
                    setToken(null);
                }
            }
            setIsLoading(false);
        };
        loadUser();
    }, []);
    const login = async (data) => {
        setIsLoading(true);
        try {
            const authData = await authService.login(data);
            localStorage.setItem('authToken', authData.token);
            setUser(authData.user);
            setToken(authData.token);
        }
        finally {
            setIsLoading(false);
        }
    };
    const register = async (data) => {
        setIsLoading(true);
        try {
            const authData = await authService.register(data);
            localStorage.setItem('authToken', authData.token);
            setUser(authData.user);
            setToken(authData.token);
        }
        finally {
            setIsLoading(false);
        }
    };
    const logout = () => {
        localStorage.removeItem('authToken');
        setUser(null);
        setToken(null);
    };
    const value = {
        user,
        token,
        isLoading,
        login,
        register,
        logout,
        isAuthenticated: !!user && !!token,
        isAdmin: user?.role === 'Admin',
    };
    return (<AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>);
};

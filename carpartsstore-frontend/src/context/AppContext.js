import React, { createContext, useContext, useState, useEffect } from 'react';
import { productApi, categoryApi } from '../services/api';
const AppContext = createContext(undefined);
export const useAppContext = () => {
    const context = useContext(AppContext);
    if (!context) {
        throw new Error('useAppContext must be used within AppProvider');
    }
    return context;
};
export const AppProvider = ({ children }) => {
    const [products, setProducts] = useState([]);
    const [categories, setCategories] = useState([]);
    const [categoryHierarchy, setCategoryHierarchy] = useState([]);
    const [popularTags, setPopularTags] = useState([]);
    const [mostViewedProducts, setMostViewedProducts] = useState([]);
    const [featuredProducts, setFeaturedProducts] = useState([]);
    const [loading, setLoading] = useState(true);
    const fetchProducts = async (params) => {
        try {
            const response = await productApi.getAll(params);
            setProducts(response.products || []);
        }
        catch (error) {
            console.error('Error fetching products:', error);
        }
    };
    const fetchCategories = async () => {
        try {
            const categoriesResponse = await categoryApi.getAll();
            const hierarchyResponse = await categoryApi.getHierarchy();
            setCategories(categoriesResponse || []);
            setCategoryHierarchy(hierarchyResponse || []);
        }
        catch (error) {
            console.error('Error fetching categories:', error);
        }
    };
    const fetchPopularTags = async () => {
        try {
            const response = await productApi.getPopularTags();
            setPopularTags(response || []);
        }
        catch (error) {
            console.error('Error fetching popular tags:', error);
            // Return empty array if endpoint doesn't exist
            setPopularTags([]);
        }
    };
    const fetchMostViewed = async (count = 10) => {
        try {
            const response = await productApi.getMostViewed(count);
            setMostViewedProducts(response || []);
        }
        catch (error) {
            console.error('Error fetching most viewed products:', error);
        }
    };
    const fetchFeaturedProducts = async (count = 8) => {
        try {
            const response = await productApi.getAll({
                isFeatured: true,
                isActive: true,
                pageSize: count
            });
            setFeaturedProducts(response.products || []);
        }
        catch (error) {
            console.error('Error fetching featured products:', error);
        }
    };
    const incrementViewCount = async (productId) => {
        try {
            await productApi.incrementView(productId);
            // Update local state
            setProducts(prev => prev.map(p => p.id === productId ? { ...p, viewCount: (p.viewCount || 0) + 1 } : p));
            setMostViewedProducts(prev => prev.map(p => p.id === productId ? { ...p, viewCount: (p.viewCount || 0) + 1 } : p));
        }
        catch (error) {
            console.error('Error incrementing view count:', error);
        }
    };
    // Initial data fetching
    useEffect(() => {
        const loadInitialData = async () => {
            setLoading(true);
            try {
                await Promise.all([
                    fetchProducts({ pageSize: 20 }),
                    fetchCategories(),
                    fetchFeaturedProducts(),
                    fetchMostViewed()
                ]);
                // Fetch popular tags separately to not break if endpoint doesn't exist
                await fetchPopularTags();
            }
            catch (error) {
                console.error('Error loading initial data:', error);
            }
            finally {
                setLoading(false);
            }
        };
        loadInitialData();
    }, []);
    const value = {
        products,
        categories,
        categoryHierarchy,
        popularTags,
        mostViewedProducts,
        featuredProducts,
        loading,
        fetchProducts,
        fetchCategories,
        fetchPopularTags,
        fetchMostViewed,
        fetchFeaturedProducts,
        incrementViewCount,
    };
    return (<AppContext.Provider value={value}>
      {children}
    </AppContext.Provider>);
};

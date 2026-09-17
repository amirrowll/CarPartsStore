import axios from 'axios';
import type { LoginRequest, RegisterRequest, Product, Category, ProductResponse } from '../types';

export type { Product, Category, ProductResponse };

export interface CategoryHierarchy extends Category {
  children: CategoryHierarchy[];
}

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:5000/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  // Remove default Content-Type to allow multipart/form-data
});

// Add request interceptor to add JWT token
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('authToken');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    // Don't override Content-Type if it's already set (for multipart/form-data)
    if (config.headers['Content-Type'] === undefined) {
      config.headers['Content-Type'] = 'application/json';
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Add response interceptor to handle errors
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Token expired or invalid
      localStorage.removeItem('authToken');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

// Product API
export const productApi = {
  getAll: (params?: any) => api.get('/products', { params }).then(res => res.data),
  getById: (id: number) => api.get(`/products/${id}`).then(res => res.data),
  create: (data: any) => {
    // Check if data is FormData
    if (data instanceof FormData) {
      return api.post('/products', data, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      }).then(res => res.data);
    } else {
      // For JSON data
      return api.post('/products', data).then(res => res.data);
    }
  },
  update: (id: number, data: any) => {
    // Check if data is FormData
    if (data instanceof FormData) {
      return api.put(`/products/${id}`, data, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      }).then(res => res.data);
    } else {
      // For JSON data
      return api.put(`/products/${id}`, data).then(res => res.data);
    }
  },
  delete: (id: number) => api.delete(`/products/${id}`).then(res => res.data),
  getPopularTags: () => api.get('/products/popular-tags').then(res => res.data),
  getMostViewed: (count: number = 10) => api.get(`/products/most-viewed?count=${count}`).then(res => res.data),
  getProductsByBrand: (brand: string, count: number = 20) => api.get(`/products/by-brand/${brand}?count=${count}`).then(res => res.data),
  incrementView: (id: number) => api.post(`/products/${id}/increment-view`).then(res => res.data).catch(() => ({ success: false })), // Temporary fallback
  getSearchSuggestions: (query: string) => api.get(`/products/search/suggestions?query=${query}`).then(res => res.data),
};

// Category API
export const categoryApi = {
  getAll: (includeProducts: boolean = false) => 
    api.get('/categories', { params: { includeProducts } }).then(res => res.data),
  getHierarchy: () => api.get('/categories/hierarchy').then(res => res.data),
  getById: (id: number) => api.get(`/categories/${id}`).then(res => res.data),
  create: (data: any) => api.post('/categories', data).then(res => res.data),
  update: (id: number, data: any) => api.put(`/categories/${id}`, data).then(res => res.data),
  delete: (id: number) => api.delete(`/categories/${id}`).then(res => res.data),
  getProducts: (id: number, params?: any) => 
    api.get(`/categories/${id}/products`, { params }).then(res => res.data),
};

// Admin API (استفاده از StatsController جدید)
export const adminService = {
  getDashboardStats: () => api.get('/stats/dashboard').then(res => res.data),
  getAllUsers: () => api.get('/auth/profile').then(res => res.data), // Note: این فقط پروفایل کاربر جاری را برمیگرداند
  // سایر endpointها به ProductsController منتقل شدهاند
};

// Order API (برای سایت ایستاتیک حذف شد)
export const orderService = {
  // این سرویسها برای سایت ایستاتیک حذف شدهاند
};

// Auth API
export const authService = {
  login: (data: LoginRequest) => api.post('/auth/login', data).then(res => res.data),
  register: (data: RegisterRequest) => api.post('/auth/register', data).then(res => res.data),
  getProfile: () => api.get('/auth/profile').then(res => res.data),
};

// Product Service (already existing)
export const productService = {
  getProducts: (params?: any) => api.get('/products', { params }).then(res => res.data),
  getProductById: (id: number) => api.get(`/products/${id}`).then(res => res.data),
  createProduct: (data: any) => {
    // Check if data is FormData
    if (data instanceof FormData) {
      return api.post('/products', data, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      }).then(res => res.data);
    } else {
      // For JSON data
      return api.post('/products', data).then(res => res.data);
    }
  },
  updateProduct: (id: number, data: any) => {
    // Check if data is FormData
    if (data instanceof FormData) {
      return api.put(`/products/${id}`, data, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      }).then(res => res.data);
    } else {
      // For JSON data
      return api.put(`/products/${id}`, data).then(res => res.data);
    }
  },
  deleteProduct: (id: number) => api.delete(`/products/${id}`).then(res => res.data),
};

// Helper function to complete image URLs
const completeImageUrl = (url: string | undefined): string => {
  if (!url) return '';
  
  // اگر آدرس کامل است (با http شروع شده) تغییر نده
  if (url.startsWith('http')) return url;
  
  // اگر آدرس نسبی است، آن را با base URL کامل کن
  // آدرس‌هایی که با /uploads/ شروع میشوند باید از ریشه سرور کامل شوند
  if (url.startsWith('/uploads/')) {
    return `${API_BASE_URL.replace('/api', '')}${url}`;
  }
  
  // آدرس‌های دیگر را تغییر نده
  return url;
};

// Story API
export const storyApi = {
  // Get active stories for homepage
  getActiveStories: () => api.get('/stories/active').then(res => {
    if (Array.isArray(res.data)) {
      return res.data.map((story: any) => ({
        ...story,
        mediaUrl: completeImageUrl(story.mediaUrl),
        thumbnailUrl: completeImageUrl(story.thumbnailUrl)
      }));
    }
    return res.data;
  }),
  
  // Get all stories (admin only)
  getAllStories: () => api.get('/stories').then(res => {
    if (Array.isArray(res.data)) {
      return res.data.map((story: any) => ({
        ...story,
        mediaUrl: completeImageUrl(story.mediaUrl),
        thumbnailUrl: completeImageUrl(story.thumbnailUrl)
      }));
    }
    return res.data;
  }),
  
  // Get single story
  getStoryById: (id: number) => api.get(`/stories/${id}`).then(res => {
    const story = res.data;
    return {
      ...story,
      mediaUrl: completeImageUrl(story.mediaUrl),
      thumbnailUrl: completeImageUrl(story.thumbnailUrl)
    };
  }),
  
  // Create new story
  createStory: (data: FormData) => {
    return api.post('/stories', data, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    }).then(res => {
      const story = res.data;
      return {
        ...story,
        mediaUrl: completeImageUrl(story.mediaUrl),
        thumbnailUrl: completeImageUrl(story.thumbnailUrl)
      };
    });
  },
  
  // Update story
  updateStory: (id: number, data: any) => api.put(`/stories/${id}`, data).then(res => res.data),
  
  // Delete story
  deleteStory: (id: number) => api.delete(`/stories/${id}`).then(res => res.data),
  
  // Increment view count
  incrementViewCount: (id: number) => api.post(`/stories/${id}/view`).then(res => res.data),
  
  // Toggle story status
  toggleStoryStatus: (id: number) => api.put(`/stories/${id}/toggle-status`).then(res => res.data),
};

// Slider API with URL completion
export const sliderApi = {
  // Get all slides with completed URLs
  getAllSlides: () => api.get('/slides').then(res => {
    if (Array.isArray(res.data)) {
      return res.data.map((slide: any) => ({
        ...slide,
        imageUrl: completeImageUrl(slide.imageUrl)
      }));
    }
    return res.data;
  }),
  
  // Get active slides for homepage with completed URLs
  getActiveSlides: () => api.get('/slides/active').then(res => {
    if (Array.isArray(res.data)) {
      return res.data.map((slide: any) => ({
        ...slide,
        imageUrl: completeImageUrl(slide.imageUrl)
      }));
    }
    return res.data;
  }),
  
  // Get single slide with completed URL
  getSlideById: (id: string) => api.get(`/slides/${id}`).then(res => {
    const slide = res.data;
    return {
      ...slide,
      imageUrl: completeImageUrl(slide.imageUrl)
    };
  }),
  
  // Create new slide
  createSlide: (data: FormData) => {
    return api.post('/slides', data, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    }).then(res => {
      const slide = res.data;
      return {
        ...slide,
        imageUrl: completeImageUrl(slide.imageUrl)
      };
    });
  },
  
  // Update slide
  updateSlide: (id: string, data: any) => api.put(`/slides/${id}`, data).then(res => res.data),
  
  // Delete slide
  deleteSlide: (id: string) => api.delete(`/slides/${id}`).then(res => res.data),
  
  // Update slide order
  updateSlideOrder: (slides: Array<{id: string, order: number}>) => 
    api.put('/slides/order', { slides }).then(res => res.data),
  
  // Toggle slide status (active/inactive)
  toggleSlideStatus: (id: string) => 
    api.put(`/slides/${id}/toggle-status`).then(res => res.data),
};

export default api;
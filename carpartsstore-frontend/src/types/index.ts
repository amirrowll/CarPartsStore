// User Types
export interface User {
  id: number;
  firstName: string;
  lastName: string;
  email: string;
  phoneNumber: string;
  address: string;
  role: string;
}

export interface AuthResponse {
  token: string;
  expiresAt: string;
  user: User;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface RegisterRequest {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  phoneNumber: string;
  address: string;
}

// Product Types
export type ProductBrand = 'چینی' | 'سایپا' | 'ایران خودرو' | 'سایر برندها' | 'Chinese' | 'Saipa' | 'IranKhodro';

export type ProductModel =
  | 'پژو 206'
  | 'پژو پارس'
  | 'سمند'
  | 'دنا'
  | 'تیبا'
  | 'پراید'
  | 'سورن'
  | 'چری'
  | 'هیوندای'
  | 'ام جی'
  | 'کوییک'
  | 'تویوتا'
  | 'Chery'
  | 'Hyundai'
  | 'MG'
  | 'Quick'
  | 'Toyota';

export type ProductStatus = 'Available' | 'OutOfStock' | 'Discontinued';

export interface Product {
  id: number;
  name: string;
  description: string;
  price: number;
  discountPrice?: number;
  stockQuantity: number;
  status: ProductStatus;
  SKU: string;
  brand: ProductBrand;
  model: ProductModel;
  categoryId: number;
  categoryName: string;
  partNumber: string;
  manufacturer: string;
  warranty: string;
  isOriginal: boolean;
  rating: number;
  reviewCount: number;
  imageUrl: string;
  additionalImages: string[];
  createdAt: string;
  // Additional fields from backend
  viewCount?: number;
  favoriteCount?: number;
  isFeatured?: boolean;
  isActive?: boolean;
  sku?: string;
  compatibleCars?: string;
  material?: string;
  updatedAt?: string;
  lastViewedAt?: string;
  // New fields for tags and car brands
  tags?: string[];
  hashtags?: string[];
  carBrand?: string;
}

export interface ProductFilter {
  search?: string;
  brand?: ProductBrand;
  model?: ProductModel;
  categoryId?: number;
  minPrice?: number;
  maxPrice?: number;
  isOriginal?: boolean;
  inStock?: boolean;
  sortBy?: 'price' | 'name' | 'rating' | 'createdAt';
  sortDescending?: boolean;
  page: number;
  pageSize: number;
}

export interface ProductResponse {
  products: Product[];
  totalCount: number;
  page: number;
  pageSize: number;
  totalPages: number;
}

// Search Filters Type
export interface SearchFilters {
  search?: string;
  brand?: string;
  carBrand?: string;
  carModel?: string;
  partNumber?: string;
  compatibleCars?: string;
  material?: string;
  warranty?: string;
  tags?: string[];
  hashtags?: string[];
  isFeatured?: boolean;
  sortBy?: string;
  sortDescending?: boolean;
  page: number;
  pageSize: number;
}

// Category Types
export interface Category {
  id: number;
  name: string;
  description: string;
  parentId?: number;
  imageUrl?: string;
  // Additional fields from backend
  parentCategoryId?: number;
  parentCategoryName?: string;
  displayOrder?: number;
  isActive?: boolean;
  createdAt?: string;
  productCount?: number;
  ProductCount?: number; // For API compatibility
}

// Order Types
export interface OrderItem {
  productId: number;
  quantity: number;
  price: number;
}

export interface Order {
  id: number;
  userId: number;
  totalAmount: number;
  status: 'Pending' | 'Processing' | 'Shipped' | 'Delivered' | 'Cancelled';
  shippingAddress: string;
  paymentMethod: string;
  createdAt: string;
  items: OrderItem[];
}

// Admin Dashboard Types
export interface DashboardStats {
  totalProducts: number;
  totalOrders: number;
  totalRevenue: number;
  totalUsers: number;
  lowStockProducts: number;
  pendingOrders: number;
}

export interface RecentActivity {
  id: number;
  type: 'order' | 'product' | 'user';
  description: string;
  timestamp: string;
  userId: number;
  userName: string;
}

// Slide Types
export interface Slide {
  id: string;
  title: string;
  description: string;
  imageUrl: string;
  order: number;
  isActive: boolean;
  createdAt?: string;
  updatedAt?: string;
}

// Story Types
export interface Story {
  id: number;
  title: string;
  description: string;
  mediaUrl: string;
  mediaType: 'Image' | 'Video';
  thumbnailUrl: string;
  duration: number;
  isActive: boolean;
  createdAt: string;
  expiresAt: string;
  viewCount: number;
  order: number;
  createdByUserName?: string;
  createdByUserAvatar?: string;
}

export interface CreateStoryDto {
  title: string;
  description: string;
  mediaType: string;
  duration: number;
  isActive: boolean;
}

export interface UpdateStoryDto {
  title?: string;
  description?: string;
  duration?: number;
  isActive?: boolean;
}
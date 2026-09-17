import React, { useState, useEffect } from 'react';
import { Upload, X, ChevronLeft, ChevronRight, Image as ImageIcon, Save, Eye, EyeOff, Loader } from 'lucide-react';
import { sliderApi } from '../services/api';

interface Slide {
  id: string;
  imageUrl: string;
  title?: string;
  description?: string;
  order: number;
  isActive: boolean;
  createdAt?: string;
  updatedAt?: string;
}

const AdminHeroSlider: React.FC = () => {
  const [slides, setSlides] = useState<Slide[]>([]);
  const [currentSlide, setCurrentSlide] = useState(0);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [uploadedFiles, setUploadedFiles] = useState<File[]>([]);
  const [newSlideTitle, setNewSlideTitle] = useState('');
  const [newSlideDescription, setNewSlideDescription] = useState('');
  const [slideInterval, setSlideInterval] = useState(5000);
  const [error, setError] = useState<string>('');
  const [successMessage, setSuccessMessage] = useState<string>('');

  // Load slides from API
  useEffect(() => {
    const loadSlides = async () => {
      try {
        setLoading(true);
        const data = await sliderApi.getAllSlides();
        const sortedSlides = data.sort((a: Slide, b: Slide) => a.order - b.order);
        setSlides(sortedSlides);
        setError('');
      } catch (err) {
        console.error('Error loading slides:', err);
        setError('خطا در بارگذاری اسلایدها');
      } finally {
        setLoading(false);
      }
    };
    
    loadSlides();
  }, []);

  // Auto slide functionality
  useEffect(() => {
    const activeSlides = slides.filter(slide => slide.isActive);
    if (activeSlides.length === 0) return;

    let interval: number | undefined;
    
    interval = window.setInterval(() => {
      setCurrentSlide((prev) => {
        const nextIndex = (prev + 1) % activeSlides.length;
        return nextIndex;
      });
    }, slideInterval);
    
    return () => {
      if (interval) clearInterval(interval);
    };
  }, [slides, slideInterval]);

  // Clear success message after 3 seconds
  useEffect(() => {
    if (successMessage) {
      const timer = setTimeout(() => {
        setSuccessMessage('');
      }, 3000);
      return () => clearTimeout(timer);
    }
  }, [successMessage]);

  const handleFileUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
    const files = event.target.files;
    if (files) {
      const fileArray = Array.from(files);
      setUploadedFiles(prev => [...prev, ...fileArray]);
    }
    // Reset input value to allow uploading same file again
    event.target.value = '';
  };

  const removeUploadedFile = (index: number) => {
    setUploadedFiles(prev => prev.filter((_, i) => i !== index));
  };

  const addNewSlide = async () => {
    if (uploadedFiles.length === 0) {
      setError('لطفاً حداقل یک تصویر انتخاب کنید');
      return;
    }

    try {
      setSaving(true);
      setError('');
      
      for (const file of uploadedFiles) {
        const formData = new FormData();
        formData.append('image', file);
        formData.append('title', newSlideTitle || `اسلاید ${slides.length + 1}`);
        formData.append('description', newSlideDescription || 'توضیحات اسلاید');
        formData.append('order', (slides.length + 1).toString());
        formData.append('isActive', 'true');
        
        await sliderApi.createSlide(formData);
      }
      
      // Refresh slides list
      const data = await sliderApi.getAllSlides();
      const sortedSlides = data.sort((a: Slide, b: Slide) => a.order - b.order);
      setSlides(sortedSlides);
      
      // Reset form
      setUploadedFiles([]);
      setNewSlideTitle('');
      setNewSlideDescription('');
      setSuccessMessage('اسلاید جدید با موفقیت اضافه شد');
    } catch (err) {
      console.error('Error adding slide:', err);
      setError('خطا در افزودن اسلاید جدید');
    } finally {
      setSaving(false);
    }
  };

  const removeSlide = async (id: string) => {
    if (!confirm('آیا از حذف این اسلاید اطمینان دارید؟')) return;
    
    try {
      setSaving(true);
      await sliderApi.deleteSlide(id);
      
      // Update local state
      const updatedSlides = slides.filter(slide => slide.id !== id);
      setSlides(updatedSlides);
      
      // Adjust current slide if needed
      const activeSlides = updatedSlides.filter(slide => slide.isActive);
      if (currentSlide >= activeSlides.length) {
        setCurrentSlide(Math.max(0, activeSlides.length - 1));
      }
      
      setSuccessMessage('اسلاید با موفقیت حذف شد');
    } catch (err) {
      console.error('Error removing slide:', err);
      setError('خطا در حذف اسلاید');
    } finally {
      setSaving(false);
    }
  };

  const nextSlide = () => {
    const activeSlides = slides.filter(slide => slide.isActive);
    if (activeSlides.length === 0) return;
    setCurrentSlide((prev) => (prev + 1) % activeSlides.length);
  };

  const prevSlide = () => {
    const activeSlides = slides.filter(slide => slide.isActive);
    if (activeSlides.length === 0) return;
    setCurrentSlide((prev) => (prev - 1 + activeSlides.length) % activeSlides.length);
  };

  const goToSlide = (index: number) => {
    setCurrentSlide(index);
  };

  const toggleSlideStatus = async (id: string, currentStatus: boolean) => {
    try {
      setSaving(true);
      await sliderApi.toggleSlideStatus(id);
      
      // Update local state
      setSlides(prev => 
        prev.map(slide => 
          slide.id === id ? { ...slide, isActive: !currentStatus } : slide
        )
      );
      
      setSuccessMessage('وضعیت اسلاید با موفقیت تغییر کرد');
    } catch (err) {
      console.error('Error toggling slide status:', err);
      setError('خطا در تغییر وضعیت اسلاید');
    } finally {
      setSaving(false);
    }
  };

  const saveSlideOrder = async () => {
    try {
      setSaving(true);
      const orderData = slides.map((slide, index) => ({
        id: slide.id,
        order: index + 1
      }));
      
      await sliderApi.updateSlideOrder(orderData);
      
      // Update local state with new order
      const updatedSlides = [...slides].map((slide, index) => ({
        ...slide,
        order: index + 1
      }));
      setSlides(updatedSlides);
      
      setSuccessMessage('ترتیب اسلایدها با موفقیت ذخیره شد');
    } catch (err) {
      console.error('Error saving slide order:', err);
      setError('خطا در ذخیره ترتیب اسلایدها');
    } finally {
      setSaving(false);
    }
  };

  const activeSlides = slides.filter(slide => slide.isActive);
  
  return (
    <div className="bg-white rounded-2xl shadow-xl p-6 space-y-8">
      {/* Messages */}
      {error && (
        <div className="rounded-xl bg-red-50 border border-red-200 p-4">
          <p className="text-red-700 font-medium">{error}</p>
        </div>
      )}
      
      {successMessage && (
        <div className="rounded-xl bg-emerald-50 border border-emerald-200 p-4">
          <p className="text-emerald-700 font-medium">{successMessage}</p>
        </div>
      )}
      
      {/* Slider Preview Section */}
      <div className="space-y-4">
        <h3 className="text-xl font-bold text-gray-800">پیش نمایش اسلایدر</h3>
        
        <div className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-gray-900 via-blue-900 to-indigo-900 min-h-[400px]">
          {loading ? (
            <div className="h-full flex items-center justify-center">
              <Loader className="h-12 w-12 text-white animate-spin" />
            </div>
          ) : activeSlides.length > 0 ? (
            <>
              {/* Slides */}
              <div className="relative h-full">
                {activeSlides.map((slide, index) => (
                  <div
                    key={slide.id}
                    className={`absolute inset-0 transition-all duration-1000 ease-in-out ${
                      index === currentSlide
                        ? 'opacity-100 transform translate-x-0'
                        : 'opacity-0 transform translate-x-full'
                    }`}
                    style={{
                      transitionProperty: 'opacity, transform',
                      transitionTimingFunction: 'cubic-bezier(0.4, 0, 0.2, 1)',
                    }}
                  >
                    {/* Slide Image */}
                    <div className="absolute inset-0">
                      <img
                        src={slide.imageUrl}
                        alt={slide.title}
                        className="w-full h-full object-cover"
                        onError={(e) => {
                          const target = e.target as HTMLImageElement;
                          target.src = 'https://placehold.co/1600x600/1e3a8a/ffffff?text=Car+Parts'; // تصویر جایگزین
                        }}
                      />
                    </div>
                    
                    {/* Gradient Overlay */}
                    <div className="absolute inset-0 bg-gradient-to-r from-blue-900/50 via-blue-800/30 to-transparent"></div>
                    
                    {/* Content */}
                    <div className="relative h-full flex items-center">
                      <div className="max-w-7xl mx-auto px-8 w-full">
                        <div className="max-w-xl">
                          <h2 className="text-4xl md:text-5xl font-bold mb-6 text-white leading-tight">
                            {slide.title}
                          </h2>
                          <p className="text-xl text-blue-100 mb-8">
                            {slide.description}
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>

              {/* Navigation Controls */}
              <div className="absolute bottom-8 left-1/2 transform -translate-x-1/2 flex items-center gap-4 bg-black/30 backdrop-blur-sm rounded-full px-4 py-2">
                <button
                  onClick={prevSlide}
                  className="p-2 hover:bg-white/10 rounded-full transition-colors"
                >
                  <ChevronRight className="h-5 w-5 text-white" />
                </button>
                
                <div className="flex items-center gap-2">
                  {activeSlides.map((_, index) => (
                    <button
                      key={index}
                      onClick={() => goToSlide(index)}
                      className={`w-2 h-2 rounded-full transition-all ${
                        index === currentSlide
                          ? 'bg-white w-6'
                          : 'bg-white/50 hover:bg-white/70'
                      }`}
                    />
                  ))}
                </div>
                
                <button
                  onClick={nextSlide}
                  className="p-2 hover:bg-white/10 rounded-full transition-colors"
                >
                  <ChevronLeft className="h-5 w-5 text-white" />
                </button>
              </div>
            </>
          ) : (
            <div className="h-full flex items-center justify-center">
              <div className="text-center">
                <ImageIcon className="h-16 w-16 text-gray-400 mx-auto mb-4" />
                <p className="text-gray-400">هیچ اسلاید فعالی وجود ندارد</p>
                <p className="text-sm text-gray-500 mt-2">برای فعال کردن اسلایدها از لیست زیر استفاده کنید</p>
              </div>
            </div>
          )}
        </div>

        {/* Slide Settings */}
        <div className="flex items-center gap-4 bg-gray-50 rounded-xl p-4">
          <div className="flex-1">
            <label className="block text-sm font-medium text-gray-700 mb-1">
              سرعت تغییر اسلاید (میلیثانیه)
            </label>
            <input
              type="range"
              min="1000"
              max="10000"
              step="1000"
              value={slideInterval}
              onChange={(e) => setSlideInterval(parseInt(e.target.value))}
              className="w-full"
            />
            <div className="flex justify-between text-xs text-gray-500 mt-1">
              <span>1s</span>
              <span>3s</span>
              <span>5s</span>
              <span>7s</span>
              <span>10s</span>
            </div>
          </div>
          
          <div className="flex gap-2">
            <button
              onClick={saveSlideOrder}
              disabled={saving}
              className="px-4 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
            >
              {saving ? (
                <Loader className="h-4 w-4 animate-spin" />
              ) : (
                <Save className="h-4 w-4" />
              )}
              ذخیره ترتیب اسلایدها
            </button>
          </div>
        </div>
      </div>

      {/* Slide Management Section */}
      <div className="space-y-6">
        <h3 className="text-xl font-bold text-gray-800">مدیریت اسلایدها</h3>
        
        {/* Upload Section */}
        <div className="border-2 border-dashed border-gray-300 rounded-2xl p-6 hover:border-blue-500 transition-colors">
          <div className="text-center">
            <Upload className="h-12 w-12 text-gray-400 mx-auto mb-4" />
            <p className="text-gray-600 mb-4">تصاویر اسلایدها را اینجا آپلود کنید</p>
            
            <label className="inline-block px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-medium rounded-lg cursor-pointer hover:from-blue-700 hover:to-blue-800 transition-all">
              انتخاب فایلها
              <input
                type="file"
                multiple
                accept="image/*"
                onChange={handleFileUpload}
                className="hidden"
              />
            </label>
            <p className="text-sm text-gray-500 mt-2">فرمتهای مجاز: JPG, PNG, GIF (حداکثر 10MB)</p>
          </div>
        </div>

        {/* Uploaded Files Preview */}
        {uploadedFiles.length > 0 && (
          <div className="bg-gray-50 rounded-xl p-4">
            <div className="flex items-center justify-between mb-4">
              <h4 className="font-medium text-gray-700">فایلهای انتخاب شده</h4>
              <span className="text-sm text-gray-500">{uploadedFiles.length} فایل</span>
            </div>
            
            <div className="grid grid-cols-2 md:grid-cols-3 gap-3 mb-4">
              {uploadedFiles.map((file, index) => (
                <div key={index} className="relative group">
                  <div className="aspect-video rounded-lg overflow-hidden bg-gray-200">
                    <img
                      src={URL.createObjectURL(file)}
                      alt={file.name}
                      className="w-full h-full object-cover"
                    />
                  </div>
                  <button
                    onClick={() => removeUploadedFile(index)}
                    className="absolute top-2 right-2 p-1 bg-red-500 text-white rounded-full opacity-0 group-hover:opacity-100 transition-opacity"
                  >
                    <X className="h-4 w-4" />
                  </button>
                  <p className="text-xs text-gray-600 truncate mt-1">{file.name}</p>
                  <p className="text-xs text-gray-400">
                    {(file.size / (1024 * 1024)).toFixed(2)} MB
                  </p>
                </div>
              ))}
            </div>

            {/* Slide Details Form */}
            <div className="space-y-4 mb-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  عنوان اسلاید
                </label>
                <input
                  type="text"
                  value={newSlideTitle}
                  onChange={(e) => setNewSlideTitle(e.target.value)}
                  placeholder="مثال: قطعات خودرو با کیفیت"
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                />
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  توضیحات اسلاید
                </label>
                <textarea
                  value={newSlideDescription}
                  onChange={(e) => setNewSlideDescription(e.target.value)}
                  placeholder="مثال: بزرگترین مجموعه قطعات یدکی خودرو با گارانتی کیفیت و قیمت مناسب"
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  rows={2}
                />
              </div>
            </div>

            <button
              onClick={addNewSlide}
              disabled={saving || uploadedFiles.length === 0}
              className="w-full px-6 py-3 bg-gradient-to-r from-emerald-600 to-emerald-700 text-white font-medium rounded-lg hover:from-emerald-700 hover:to-emerald-800 transition-all disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
            >
              {saving ? (
                <Loader className="h-5 w-5 animate-spin" />
              ) : (
                <Upload className="h-5 w-5" />
              )}
              {saving ? 'در حال افزودن...' : 'اضافه کردن اسلاید جدید'}
            </button>
          </div>
        )}

        {/* Existing Slides List */}
        <div className="space-y-3">
          <h4 className="font-medium text-gray-700">اسلایدهای موجود ({slides.length})</h4>
          
          {loading ? (
            <div className="text-center py-8 text-gray-500">
              <Loader className="h-8 w-8 animate-spin mx-auto mb-2" />
              در حال بارگذاری اسلایدها...
            </div>
          ) : slides.length > 0 ? (
            slides.map((slide) => (
              <div
                key={slide.id}
                className={`flex items-center gap-4 p-4 rounded-xl border transition-all ${
                  slide.isActive ? 'border-gray-200 hover:bg-gray-50' : 'border-gray-100 bg-gray-50 opacity-60'
                }`}
              >
                <div className="flex-shrink-0">
                  <div className="relative w-20 h-12 rounded-lg overflow-hidden bg-gray-200">
                    <img
                      src={slide.imageUrl}
                      alt={slide.title}
                      className="w-full h-full object-cover"
                      onError={(e) => {
                        const target = e.target as HTMLImageElement;
                        target.src = 'https://placehold.co/100x50/1e3a8a/ffffff?text=Car'; // تصویر جایگزین کوچک
                      }}
                    />
                    {!slide.isActive && (
                      <div className="absolute inset-0 bg-black/50 flex items-center justify-center">
                        <EyeOff className="h-4 w-4 text-white" />
                      </div>
                    )}
                  </div>
                </div>
                
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 mb-1">
                    <span className="text-sm font-medium text-gray-900 truncate">
                      {slide.title}
                    </span>
                    {slide.isActive ? (
                      <span className="text-xs bg-emerald-100 text-emerald-700 px-2 py-0.5 rounded-full">
                        فعال
                      </span>
                    ) : (
                      <span className="text-xs bg-gray-100 text-gray-600 px-2 py-0.5 rounded-full">
                        غیرفعال
                      </span>
                    )}
                  </div>
                  <p className="text-xs text-gray-600 truncate">{slide.description}</p>
                  <p className="text-xs text-gray-400 mt-1">
                    ترتیب: {slide.order}
                  </p>
                </div>
                
                <div className="flex items-center gap-2">
                  <button
                    onClick={() => toggleSlideStatus(slide.id, slide.isActive)}
                    disabled={saving}
                    className={`p-2 rounded-lg ${
                      slide.isActive
                        ? 'text-emerald-600 hover:bg-emerald-50'
                        : 'text-gray-600 hover:bg-gray-100'
                    }`}
                  >
                    {slide.isActive ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                  </button>
                  <button
                    onClick={() => removeSlide(slide.id)}
                    disabled={saving}
                    className="p-2 text-red-500 hover:bg-red-50 rounded-lg disabled:opacity-50"
                  >
                    <X className="h-4 w-4" />
                  </button>
                </div>
              </div>
            ))
          ) : (
            <div className="text-center py-8 text-gray-500 rounded-xl border border-dashed border-gray-300">
              هنوز اسلایدی وجود ندارد
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default AdminHeroSlider;
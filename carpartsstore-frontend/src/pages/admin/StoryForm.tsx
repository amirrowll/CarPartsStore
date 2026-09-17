import React, { useState, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  ArrowBack,
  CameraAlt,
  Videocam,
  Upload,
  Delete,
  PlayCircle,
  Image,
  Timer,
  Title,
  Description,
  CheckCircle
} from '@mui/icons-material';
import { storyApi } from '../../services/api';

const StoryForm: React.FC = () => {
  const navigate = useNavigate();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const videoRef = useRef<HTMLVideoElement>(null);

  const [formData, setFormData] = useState({
    title: '',
    description: '',
    mediaType: 'Image',
    duration: 5,
    isActive: true
  });

  const [mediaFile, setMediaFile] = useState<File | null>(null);
  const [mediaPreview, setMediaPreview] = useState<string>('');
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    const { name, value, type } = e.target;
    
    if (type === 'checkbox') {
      const checked = (e.target as HTMLInputElement).checked;
      setFormData(prev => ({ ...prev, [name]: checked }));
    } else if (type === 'number') {
      setFormData(prev => ({ ...prev, [name]: parseInt(value) || 0 }));
    } else {
      setFormData(prev => ({ ...prev, [name]: value }));
    }
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setMediaFile(file);
    setError('');

    // Create preview
    const reader = new FileReader();
    reader.onloadend = () => {
      setMediaPreview(reader.result as string);
    };
    reader.readAsDataURL(file);

    // Auto-detect media type
    const isVideo = file.type.startsWith('video/');
    setFormData(prev => ({ 
      ...prev, 
      mediaType: isVideo ? 'Video' : 'Image' 
    }));
  };

  const handleRemoveMedia = () => {
    setMediaFile(null);
    setMediaPreview('');
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!mediaFile) {
      setError('لطفا یک فایل رسانهای انتخاب کنید');
      return;
    }

    if (!formData.title.trim()) {
      setError('عنوان استوری الزامی است');
      return;
    }

    try {
      setUploading(true);
      setError('');
      setSuccess('');

      const formDataToSend = new FormData();
      formDataToSend.append('title', formData.title);
      formDataToSend.append('description', formData.description);
      formDataToSend.append('mediaType', formData.mediaType);
      formDataToSend.append('duration', formData.duration.toString());
      formDataToSend.append('isActive', formData.isActive.toString());
      formDataToSend.append('mediaFile', mediaFile);

      await storyApi.createStory(formDataToSend);
      
      setSuccess('استوری با موفقیت ایجاد شد!');
      setTimeout(() => {
        navigate('/admin/stories');
      }, 2000);

    } catch (err: any) {
      setError(err.response?.data?.message || 'خطا در ایجاد استوری');
      console.error('Create story error:', err);
    } finally {
      setUploading(false);
    }
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    
    const file = e.dataTransfer.files[0];
    if (file && (file.type.startsWith('image/') || file.type.startsWith('video/'))) {
      const event = {
        target: {
          files: [file]
        }
      } as React.ChangeEvent<HTMLInputElement>;
      handleFileChange(event);
    } else {
      setError('لطفا فقط فایل‌های عکس یا ویدیو آپلود کنید');
    }
  };

  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="rounded-2xl bg-gradient-to-br from-gray-900 to-gray-800 p-8 shadow-2xl text-white">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div className="flex items-center gap-4">
            <button
              onClick={() => navigate('/admin/stories')}
              className="p-2 rounded-full hover:bg-white/20 transition-colors"
            >
              <ArrowBack />
            </button>
            <div>
              <h2 className="text-3xl font-bold mb-2">ایجاد استوری جدید</h2>
              <p className="text-gray-300">استوری‌های جذاب اینستاگرامی برای کاربران ایجاد کنید</p>
            </div>
          </div>
          <div className="rounded-full bg-white/10 backdrop-blur-sm px-5 py-3 text-sm font-semibold">
            {formData.mediaType === 'Image' ? 'عکس' : 'ویدیو'}
          </div>
        </div>
      </div>

      <div className="grid gap-8 lg:grid-cols-2">
        {/* Left column - Form */}
        <div className="space-y-6">
          <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
            <h3 className="text-xl font-bold text-gray-800 mb-6 flex items-center gap-2">
              <Title />
              <span>اطلاعات استوری</span>
            </h3>

            <form onSubmit={handleSubmit} className="space-y-6">
              {/* Title */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  عنوان استوری *
                </label>
                <input
                  type="text"
                  name="title"
                  value={formData.title}
                  onChange={handleInputChange}
                  placeholder="مثال: تخفیف ویژه بهار"
                  className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none transition-all"
                  required
                />
              </div>

              {/* Description */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  توضیحات
                </label>
                <textarea
                  name="description"
                  value={formData.description}
                  onChange={handleInputChange}
                  placeholder="توضیحات کامل درباره استوری..."
                  rows={4}
                  className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none transition-all resize-none"
                />
              </div>

              {/* Media Type */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  نوع رسانه
                </label>
                <div className="flex gap-4">
                  <button
                    type="button"
                    onClick={() => setFormData(prev => ({ ...prev, mediaType: 'Image' }))}
                    className={`flex-1 flex items-center justify-center gap-2 px-4 py-3 rounded-xl border transition-all ${
                      formData.mediaType === 'Image'
                        ? 'border-blue-500 bg-blue-50 text-blue-600'
                        : 'border-gray-300 hover:border-gray-400'
                    }`}
                  >
                    <Image />
                    <span>عکس</span>
                  </button>
                  <button
                    type="button"
                    onClick={() => setFormData(prev => ({ ...prev, mediaType: 'Video' }))}
                    className={`flex-1 flex items-center justify-center gap-2 px-4 py-3 rounded-xl border transition-all ${
                      formData.mediaType === 'Video'
                        ? 'border-blue-500 bg-blue-50 text-blue-600'
                        : 'border-gray-300 hover:border-gray-400'
                    }`}
                  >
                    <Videocam />
                    <span>ویدیو</span>
                  </button>
                </div>
              </div>

              {/* Duration */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2 flex items-center gap-2">
                  <Timer />
                  <span>مدت زمان نمایش (ثانیه)</span>
                </label>
                <div className="flex items-center gap-4">
                  <input
                    type="range"
                    name="duration"
                    min="1"
                    max="30"
                    value={formData.duration}
                    onChange={handleInputChange}
                    className="flex-1"
                  />
                  <div className="w-20 px-4 py-2 bg-gray-100 rounded-xl text-center font-medium">
                    {formData.duration} ثانیه
                  </div>
                </div>
                <p className="text-sm text-gray-500 mt-2">
                  مدت زمان نمایش هر استوری برای کاربران
                </p>
              </div>

              {/* Active Status */}
              <div className="flex items-center justify-between p-4 bg-gray-50 rounded-xl">
                <div className="flex items-center gap-3">
                  <div className="p-2 bg-emerald-100 rounded-lg">
                    <CheckCircle className="text-emerald-600" />
                  </div>
                  <div>
                    <p className="font-medium text-gray-800">وضعیت فعال</p>
                    <p className="text-sm text-gray-500">استوری بلافاصله برای کاربران نمایش داده شود</p>
                  </div>
                </div>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input
                    type="checkbox"
                    name="isActive"
                    checked={formData.isActive}
                    onChange={handleInputChange}
                    className="sr-only peer"
                  />
                  <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-emerald-600"></div>
                </label>
              </div>

              {/* Error and Success Messages */}
              {error && (
                <div className="p-4 bg-red-50 border border-red-200 rounded-xl">
                  <p className="text-red-700 font-medium">{error}</p>
                </div>
              )}

              {success && (
                <div className="p-4 bg-emerald-50 border border-emerald-200 rounded-xl">
                  <p className="text-emerald-700 font-medium">{success}</p>
                </div>
              )}

              {/* Submit Button */}
              <button
                type="submit"
                disabled={uploading || !mediaFile}
                className="w-full bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-semibold py-4 rounded-xl transition-all hover:scale-[1.02] disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:scale-100"
              >
                {uploading ? (
                  <div className="flex items-center justify-center gap-2">
                    <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white"></div>
                    <span>در حال آپلود...</span>
                  </div>
                ) : (
                  'ایجاد استوری'
                )}
              </button>
            </form>
          </div>
        </div>

        {/* Right column - Media Upload and Preview */}
        <div className="space-y-6">
          {/* Media Upload */}
          <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
            <h3 className="text-xl font-bold text-gray-800 mb-6 flex items-center gap-2">
              <Upload />
              <span>آپلود رسانه</span>
            </h3>

            <input
              ref={fileInputRef}
              type="file"
              accept="image/*,video/*"
              onChange={handleFileChange}
              className="hidden"
            />

            {!mediaPreview ? (
              <div
                onDragOver={handleDragOver}
                onDrop={handleDrop}
                onClick={() => fileInputRef.current?.click()}
                className="border-2 border-dashed border-gray-300 rounded-2xl p-12 text-center cursor-pointer hover:border-blue-500 hover:bg-blue-50 transition-all"
              >
                <div className="inline-flex items-center justify-center w-20 h-20 rounded-full bg-gradient-to-r from-gray-100 to-gray-200 mb-6">
                  {formData.mediaType === 'Image' ? (
                    <CameraAlt className="text-gray-400 text-3xl" />
                  ) : (
                    <Videocam className="text-gray-400 text-3xl" />
                  )}
                </div>
                <h4 className="text-lg font-medium text-gray-800 mb-2">
                  فایل {formData.mediaType === 'Image' ? 'عکس' : 'ویدیو'} را اینجا رها کنید
                </h4>
                <p className="text-gray-600 mb-4">
                  یا برای انتخاب فایل کلیک کنید
                </p>
                <div className="inline-flex items-center gap-2 bg-gray-100 text-gray-700 px-6 py-3 rounded-xl">
                  <Upload />
                  <span>انتخاب فایل</span>
                </div>
                <p className="text-sm text-gray-500 mt-4">
                  فرمت‌های مجاز: {formData.mediaType === 'Image' ? 'JPG, PNG, GIF' : 'MP4, MOV, AVI'}
                  <br />
                  حداکثر حجم: 50 مگابایت
                </p>
              </div>
            ) : (
              <div className="space-y-4">
                {/* Media Preview */}
                <div className="relative rounded-2xl overflow-hidden bg-black">
                  {formData.mediaType === 'Image' ? (
                    <img
                      src={mediaPreview}
                      alt="Preview"
                      className="w-full h-auto max-h-[400px] object-contain"
                    />
                  ) : (
                    <div className="relative">
                      <video
                        ref={videoRef}
                        src={mediaPreview}
                        className="w-full h-auto max-h-[400px]"
                        controls
                      />
                      <div className="absolute top-4 left-4 bg-black/70 text-white px-3 py-1 rounded-full text-sm">
                        <PlayCircle className="inline ml-1" />
                        پیش‌نمایش ویدیو
                      </div>
                    </div>
                  )}

                  {/* Remove button */}
                  <button
                    onClick={handleRemoveMedia}
                    className="absolute top-4 right-4 bg-red-600 text-white p-2 rounded-full hover:bg-red-700 transition-colors"
                  >
                    <Delete />
                  </button>
                </div>

                {/* File info */}
                <div className="p-4 bg-gray-50 rounded-xl">
                  <div className="flex items-center justify-between mb-2">
                    <div className="flex items-center gap-2">
                      {formData.mediaType === 'Image' ? (
                        <Image className="text-gray-500" />
                      ) : (
                        <Videocam className="text-gray-500" />
                      )}
                      <span className="font-medium text-gray-800">
                        {mediaFile?.name}
                      </span>
                    </div>
                    <span className="text-sm text-gray-500">
                      {(mediaFile?.size || 0) / 1024 / 1024 > 1
                        ? `${((mediaFile?.size || 0) / 1024 / 1024).toFixed(2)} MB`
                        : `${((mediaFile?.size || 0) / 1024).toFixed(2)} KB`}
                    </span>
                  </div>
                  <p className="text-sm text-gray-600">
                    نوع: {mediaFile?.type || 'نامشخص'}
                  </p>
                </div>

                {/* Change file button */}
                <button
                  onClick={() => fileInputRef.current?.click()}
                  className="w-full flex items-center justify-center gap-2 border-2 border-dashed border-gray-300 text-gray-700 hover:border-blue-500 hover:text-blue-600 px-6 py-4 rounded-xl transition-all"
                >
                  <Upload />
                  <span>تغییر فایل</span>
                </button>
              </div>
            )}
          </div>

          {/* Preview */}
          <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
            <h3 className="text-xl font-bold text-gray-800 mb-6">پیش‌نمایش استوری</h3>
            
            <div className="space-y-4">
              {/* Story circle preview */}
              <div className="flex justify-center">
                <div className="relative p-1 rounded-full bg-gradient-to-r from-blue-500 to-purple-600">
                  <div className="w-20 h-20 rounded-full bg-white p-0.5 overflow-hidden">
                    {mediaPreview ? (
                      <img
                        src={mediaPreview}
                        alt="Preview"
                        className="w-full h-full rounded-full object-cover"
                      />
                    ) : (
                      <div className="w-full h-full rounded-full bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center">
                        {formData.mediaType === 'Image' ? (
                          <Image className="text-gray-400" />
                        ) : (
                          <Videocam className="text-gray-400" />
                        )}
                      </div>
                    )}
                  </div>
                </div>
              </div>

              {/* Story info preview */}
              <div className="text-center">
                <h4 className="font-bold text-gray-800 text-lg mb-1">
                  {formData.title || 'عنوان استوری'}
                </h4>
                <p className="text-gray-600 text-sm mb-4">
                  {formData.description || 'توضیحات استوری اینجا نمایش داده می‌شود...'}
                </p>
                
                <div className="inline-flex items-center gap-4 text-sm text-gray-500">
                  <div className="flex items-center gap-1">
                    {formData.mediaType === 'Image' ? (
                      <Image className="text-sm" />
                    ) : (
                      <Videocam className="text-sm" />
                    )}
                    <span>{formData.mediaType === 'Image' ? 'عکس' : 'ویدیو'}</span>
                  </div>
                  <div className="flex items-center gap-1">
                    <Timer className="text-sm" />
                    <span>{formData.duration} ثانیه</span>
                  </div>
                  <div className={`px-2 py-1 rounded-full text-xs ${
                    formData.isActive 
                      ? 'bg-emerald-100 text-emerald-800' 
                      : 'bg-red-100 text-red-800'
                  }`}>
                    {formData.isActive ? 'فعال' : 'غیرفعال'}
                  </div>
                </div>
              </div>

              {/* Preview note */}
              <div className="p-4 bg-blue-50 rounded-xl">
                <p className="text-sm text-blue-700">
                  این یک پیش‌نمایش از ظاهر استوری برای کاربران است. استوری‌ها به صورت دایره‌ای نمایش داده می‌شوند و کاربران با کلیک روی آنها می‌توانند محتوا را مشاهده کنند.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default StoryForm;
import React, { useState, useEffect } from 'react';
import {
  Add,
  Edit,
  Delete,
  Visibility,
  VisibilityOff,
  PlayCircle,
  Image,
  MoreVert,
  FilterList,
  Search,
  Sort,
  Refresh
} from '@mui/icons-material';
import { Story } from '../../types';
import { storyApi } from '../../services/api';
import StoryCircle from '../../components/StoryCircle';
import StoryViewer from '../../components/StoryViewer';

const AdminStories: React.FC = () => {
  const [stories, setStories] = useState<Story[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [searchTerm, setSearchTerm] = useState('');
  const [filterType, setFilterType] = useState<'all' | 'active' | 'expired'>('all');
  const [sortBy, setSortBy] = useState<'newest' | 'oldest' | 'views'>('newest');
  const [selectedStory, setSelectedStory] = useState<Story | null>(null);
  const [showViewer, setShowViewer] = useState(false);
  const [showDeleteConfirm, setShowDeleteConfirm] = useState<number | null>(null);

  useEffect(() => {
    fetchStories();
  }, []);

  const fetchStories = async () => {
    try {
      setLoading(true);
      const allStories = await storyApi.getAllStories();
      setStories(allStories);
    } catch (err: any) {
      setError('خطا در دریافت استوریها');
      console.error('Stories fetch error:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleDeleteStory = async (id: number) => {
    try {
      await storyApi.deleteStory(id);
      setStories(stories.filter(story => story.id !== id));
      setShowDeleteConfirm(null);
    } catch (err: any) {
      setError('خطا در حذف استوری');
      console.error('Delete story error:', err);
    }
  };

  const handleToggleStatus = async (id: number) => {
    try {
      await storyApi.toggleStoryStatus(id);
      setStories(stories.map(story => 
        story.id === id ? { ...story, isActive: !story.isActive } : story
      ));
    } catch (err: any) {
      setError('خطا در تغییر وضعیت استوری');
      console.error('Toggle status error:', err);
    }
  };

  const handleViewStory = (story: Story) => {
    setSelectedStory(story);
    setShowViewer(true);
  };

  const filteredStories = stories.filter(story => {
    // Search filter
    if (searchTerm && !story.title.toLowerCase().includes(searchTerm.toLowerCase()) && 
        !story.description.toLowerCase().includes(searchTerm.toLowerCase())) {
      return false;
    }

    // Type filter
    if (filterType === 'active' && !story.isActive) return false;
    if (filterType === 'expired' && new Date(story.expiresAt) > new Date()) return false;

    return true;
  }).sort((a, b) => {
    // Sort
    switch (sortBy) {
      case 'newest':
        return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
      case 'oldest':
        return new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime();
      case 'views':
        return b.viewCount - a.viewCount;
      default:
        return 0;
    }
  });

  const stats = {
    total: stories.length,
    active: stories.filter(s => s.isActive).length,
    expired: stories.filter(s => new Date(s.expiresAt) <= new Date()).length,
    videos: stories.filter(s => s.mediaType === 'Video').length,
    images: stories.filter(s => s.mediaType === 'Image').length,
    totalViews: stories.reduce((sum, story) => sum + story.viewCount, 0)
  };

  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="rounded-2xl bg-gradient-to-br from-gray-900 to-gray-800 p-8 shadow-2xl text-white">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h2 className="text-3xl font-bold mb-2">مدیریت استوریها</h2>
            <p className="text-gray-300">ایجاد و مدیریت استوریهای اینستاگرامی برای کاربران</p>
          </div>
          <div className="flex items-center gap-3">
            <button
              onClick={fetchStories}
              className="rounded-full bg-white/10 backdrop-blur-sm px-5 py-3 text-sm font-semibold hover:bg-white/20 transition-colors"
            >
              <Refresh className="ml-2" />
              بروزرسانی
            </button>
            <a
              href="/admin/stories/create"
              className="rounded-full bg-gradient-to-r from-blue-600 to-blue-700 px-6 py-3 font-semibold hover:from-blue-700 hover:to-blue-800 transition-all hover:scale-105 flex items-center gap-2"
            >
              <Add />
              <span>ایجاد استوری جدید</span>
            </a>
          </div>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid gap-4 md:grid-cols-3 lg:grid-cols-6">
        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-blue-50 to-white p-6 shadow-lg">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-blue-100 rounded-xl">
              <PlayCircle className="h-6 w-6 text-blue-600" />
            </div>
            <p className="text-sm font-medium text-gray-700">کل استوریها</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {stats.total.toLocaleString('fa-IR')}
          </p>
        </div>

        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-emerald-50 to-white p-6 shadow-lg">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-emerald-100 rounded-xl">
              <Visibility className="h-6 w-6 text-emerald-600" />
            </div>
            <p className="text-sm font-medium text-gray-700">فعال</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {stats.active.toLocaleString('fa-IR')}
          </p>
        </div>

        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-amber-50 to-white p-6 shadow-lg">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-amber-100 rounded-xl">
              <VisibilityOff className="h-6 w-6 text-amber-600" />
            </div>
            <p className="text-sm font-medium text-gray-700">منقضی شده</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {stats.expired.toLocaleString('fa-IR')}
          </p>
        </div>

        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-purple-50 to-white p-6 shadow-lg">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-purple-100 rounded-xl">
              <PlayCircle className="h-6 w-6 text-purple-600" />
            </div>
            <p className="text-sm font-medium text-gray-700">ویدیوها</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {stats.videos.toLocaleString('fa-IR')}
          </p>
        </div>

        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-pink-50 to-white p-6 shadow-lg">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-pink-100 rounded-xl">
              <Image className="h-6 w-6 text-pink-600" />
            </div>
            <p className="text-sm font-medium text-gray-700">عکسها</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {stats.images.toLocaleString('fa-IR')}
          </p>
        </div>

        <div className="rounded-2xl border border-gray-200 bg-gradient-to-br from-indigo-50 to-white p-6 shadow-lg">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-3 bg-indigo-100 rounded-xl">
              <Visibility className="h-6 w-6 text-indigo-600" />
            </div>
            <p className="text-sm font-medium text-gray-700">کل بازدیدها</p>
          </div>
          <p className="text-3xl font-bold text-gray-900 mb-2">
            {stats.totalViews.toLocaleString('fa-IR')}
          </p>
        </div>
      </div>

      {/* Filters and Search */}
      <div className="rounded-2xl border border-gray-200 bg-white p-6 shadow-lg">
        <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
          <div className="flex-1">
            <div className="relative">
              <Search className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400" />
              <input
                type="text"
                placeholder="جستجو در استوریها..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="w-full pr-10 pl-4 py-3 border border-gray-300 rounded-xl focus:border-blue-500 focus:ring-2 focus:ring-blue-200 outline-none transition-all"
              />
            </div>
          </div>

          <div className="flex items-center gap-4">
            <div className="flex items-center gap-2">
              <FilterList className="text-gray-500" />
              <select
                value={filterType}
                onChange={(e) => setFilterType(e.target.value as any)}
                className="border border-gray-300 rounded-xl px-4 py-2 focus:border-blue-500 outline-none"
              >
                <option value="all">همه</option>
                <option value="active">فعال</option>
                <option value="expired">منقضی شده</option>
              </select>
            </div>

            <div className="flex items-center gap-2">
              <Sort className="text-gray-500" />
              <select
                value={sortBy}
                onChange={(e) => setSortBy(e.target.value as any)}
                className="border border-gray-300 rounded-xl px-4 py-2 focus:border-blue-500 outline-none"
              >
                <option value="newest">جدیدترین</option>
                <option value="oldest">قدیمیترین</option>
                <option value="views">بیشترین بازدید</option>
              </select>
            </div>
          </div>
        </div>
      </div>

      {/* Stories Grid */}
      {loading ? (
        <div className="rounded-2xl border border-gray-200 bg-white p-12 shadow-lg">
          <div className="flex justify-center items-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
          </div>
        </div>
      ) : error ? (
        <div className="rounded-2xl bg-red-50 border border-red-200 p-8">
          <p className="text-red-700 font-medium text-center">{error}</p>
        </div>
      ) : filteredStories.length === 0 ? (
        <div className="rounded-2xl border border-gray-200 bg-white p-12 shadow-lg text-center">
          <div className="inline-flex items-center justify-center w-20 h-20 rounded-full bg-gradient-to-r from-gray-100 to-gray-200 mb-6">
            <PlayCircle className="text-gray-400 text-3xl" />
          </div>
          <h3 className="text-xl font-bold text-gray-800 mb-2">هیچ استوری یافت نشد</h3>
          <p className="text-gray-600 mb-6">با استفاده از دکمه زیر اولین استوری را ایجاد کنید</p>
          <a
            href="/admin/stories/create"
            className="inline-flex items-center gap-2 bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white px-6 py-3 rounded-xl font-medium transition-all hover:scale-105"
          >
            <Add />
            <span>ایجاد اولین استوری</span>
          </a>
        </div>
      ) : (
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {filteredStories.map((story) => (
            <div
              key={story.id}
              className="rounded-2xl border border-gray-200 bg-white shadow-lg overflow-hidden hover:shadow-xl transition-all duration-300"
            >
              {/* Story preview */}
              <div className="relative">
                <div className="aspect-video bg-gray-100 overflow-hidden">
                  {story.mediaType === 'Image' ? (
                    <img
                      src={story.thumbnailUrl}
                      alt={story.title}
                      className="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                    />
                  ) : (
                    <div className="relative w-full h-full">
                      <img
                        src={story.thumbnailUrl}
                        alt={story.title}
                        className="w-full h-full object-cover"
                      />
                      <div className="absolute inset-0 bg-black/40 flex items-center justify-center">
                        <PlayCircle className="text-white text-4xl" />
                      </div>
                    </div>
                  )}
                </div>

                {/* Status badge */}
                <div className={`absolute top-3 left-3 px-3 py-1 rounded-full text-xs font-semibold ${
                  story.isActive 
                    ? 'bg-emerald-100 text-emerald-800' 
                    : 'bg-red-100 text-red-800'
                }`}>
                  {story.isActive ? 'فعال' : 'غیرفعال'}
                </div>

                {/* Expiry badge */}
                {new Date(story.expiresAt) <= new Date() && (
                  <div className="absolute top-3 right-3 px-3 py-1 bg-amber-100 text-amber-800 rounded-full text-xs font-semibold">
                    منقضی شده
                  </div>
                )}
              </div>

              {/* Story info */}
              <div className="p-6">
                <div className="flex items-start justify-between mb-4">
                  <div>
                    <h3 className="font-bold text-gray-800 text-lg mb-1 line-clamp-1">
                      {story.title}
                    </h3>
                    <p className="text-gray-600 text-sm line-clamp-2">
                      {story.description}
                    </p>
                  </div>
                  <button className="text-gray-400 hover:text-gray-600">
                    <MoreVert />
                  </button>
                </div>

                <div className="grid grid-cols-2 gap-3 mb-4">
                  <div className="text-center">
                    <p className="text-xs text-gray-500">نوع</p>
                    <p className="font-medium text-gray-800">
                      {story.mediaType === 'Image' ? 'عکس' : 'ویدیو'}
                    </p>
                  </div>
                  <div className="text-center">
                    <p className="text-xs text-gray-500">مدت زمان</p>
                    <p className="font-medium text-gray-800">{story.duration} ثانیه</p>
                  </div>
                  <div className="text-center">
                    <p className="text-xs text-gray-500">بازدید</p>
                    <p className="font-medium text-gray-800">
                      {story.viewCount.toLocaleString('fa-IR')}
                    </p>
                  </div>
                  <div className="text-center">
                    <p className="text-xs text-gray-500">انقضا</p>
                    <p className="font-medium text-gray-800">
                      {new Date(story.expiresAt).toLocaleTimeString('fa-IR', { 
                        hour: '2-digit', 
                        minute: '2-digit' 
                      })}
                    </p>
                  </div>
                </div>

                {/* Actions */}
                <div className="flex items-center gap-2">
                  <button
                    onClick={() => handleViewStory(story)}
                    className="flex-1 flex items-center justify-center gap-2 bg-blue-50 text-blue-600 hover:bg-blue-100 px-4 py-2 rounded-xl transition-colors"
                  >
                    <Visibility />
                    <span>مشاهده</span>
                  </button>

                  <button
                    onClick={() => handleToggleStatus(story.id)}
                    className="flex-1 flex items-center justify-center gap-2 bg-emerald-50 text-emerald-600 hover:bg-emerald-100 px-4 py-2 rounded-xl transition-colors"
                  >
                    {story.isActive ? <VisibilityOff /> : <Visibility />}
                    <span>{story.isActive ? 'غیرفعال' : 'فعال'}</span>
                  </button>

                  <button
                    onClick={() => setShowDeleteConfirm(story.id)}
                    className="flex-1 flex items-center justify-center gap-2 bg-red-50 text-red-600 hover:bg-red-100 px-4 py-2 rounded-xl transition-colors"
                  >
                    <Delete />
                    <span>حذف</span>
                  </button>
                </div>

                {/* Edit button */}
                <a
                  href={`/admin/stories/edit/${story.id}`}
                  className="mt-3 w-full flex items-center justify-center gap-2 bg-gray-100 text-gray-700 hover:bg-gray-200 px-4 py-2 rounded-xl transition-colors"
                >
                  <Edit />
                  <span>ویرایش</span>
                </a>
              </div>

              {/* Delete confirmation */}
              {showDeleteConfirm === story.id && (
                <div className="absolute inset-0 bg-black/50 flex items-center justify-center p-6 rounded-2xl">
                  <div className="bg-white p-6 rounded-xl max-w-sm w-full">
                    <h4 className="font-bold text-gray-800 mb-2">حذف استوری</h4>
                    <p className="text-gray-600 mb-4">
                      آیا مطمئن هستید که می‌خواهید این استوری را حذف کنید؟
                    </p>
                    <div className="flex gap-3">
                      <button
                        onClick={() => handleDeleteStory(story.id)}
                        className="flex-1 bg-red-600 text-white px-4 py-2 rounded-xl hover:bg-red-700 transition-colors"
                      >
                        بله، حذف شود
                      </button>
                      <button
                        onClick={() => setShowDeleteConfirm(null)}
                        className="flex-1 bg-gray-200 text-gray-800 px-4 py-2 rounded-xl hover:bg-gray-300 transition-colors"
                      >
                        انصراف
                      </button>
                    </div>
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>
      )}

      {/* Story Viewer Modal */}
      {showViewer && selectedStory && (
        <StoryViewer
          stories={[selectedStory]}
          initialIndex={0}
          onClose={() => setShowViewer(false)}
        />
      )}
    </div>
  );
};

export default AdminStories;
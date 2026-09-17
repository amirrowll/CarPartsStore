import React, { useState, useEffect } from 'react';
import { Add, CameraAlt, Videocam } from '@mui/icons-material';
import { Story } from '../types';
import { storyApi } from '../services/api';
import StoryCircle from './StoryCircle';
import StoryViewer from './StoryViewer';

interface StoriesSectionProps {
  position?: 'top' | 'bottom';
  maxStories?: number;
  showAddButton?: boolean;
  onAddStory?: () => void;
}

const StoriesSection: React.FC<StoriesSectionProps> = ({ 
  position = 'top', 
  maxStories = 8,
  showAddButton = false,
  onAddStory 
}) => {
  const [stories, setStories] = useState<Story[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [selectedStoryIndex, setSelectedStoryIndex] = useState<number | null>(null);
  const [showViewer, setShowViewer] = useState(false);

  useEffect(() => {
    fetchStories();
  }, []);

  const fetchStories = async () => {
    try {
      setLoading(true);
      const activeStories = await storyApi.getActiveStories();
      setStories(activeStories.slice(0, maxStories));
    } catch (err: any) {
      setError('خطا در دریافت استوریها');
      console.error('Stories fetch error:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleStoryClick = (story: Story) => {
    const index = stories.findIndex(s => s.id === story.id);
    if (index !== -1) {
      setSelectedStoryIndex(index);
      setShowViewer(true);
    }
  };

  const handleCloseViewer = () => {
    setShowViewer(false);
    setSelectedStoryIndex(null);
    fetchStories();
  };

  const handleAddStory = () => {
    if (onAddStory) {
      onAddStory();
    }
  };

  // If no stories and not loading, don't render anything
  if (!loading && stories.length === 0 && !showAddButton) {
    return null;
  }

  const isUserView = !showAddButton;

  return (
    <div className={`w-full ${position === 'top' ? 'pt-4 mb-4' : 'mt-4'}`}>
      <div className="container mx-auto px-4">
        {/* Simple design for users, full design for admin */}
        {isUserView ? (
          // User view - minimal
          <div className="bg-transparent">
            {loading ? (
              <div className="flex justify-center items-center py-4">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
              </div>
            ) : error ? (
              <div className="text-center py-4 text-red-600 text-sm">
                {error}
              </div>
            ) : stories.length > 0 ? (
              <div className="flex gap-4 overflow-x-auto pb-2 px-1 scrollbar-hide">
                {stories.map((story) => (
                  <StoryCircle
                    key={story.id}
                    story={story}
                    onClick={handleStoryClick}
                    size="md"
                  />
                ))}
              </div>
            ) : null}
          </div>
        ) : (
          // Admin view - full design
          <div className="bg-gradient-to-r from-gray-50 to-white rounded-2xl border border-gray-200 shadow-lg p-6">
            {/* Header */}
            <div className="flex items-center justify-between mb-6">
              <div className="flex items-center gap-3">
                <div className="p-2 bg-gradient-to-r from-blue-500 to-purple-600 rounded-xl">
                  <CameraAlt className="text-white" />
                </div>
                <div>
                  <h3 className="text-xl font-bold text-gray-800">استوریهای امروز</h3>
                  <p className="text-sm text-gray-600">آخرین بهروزرسانیها و اخبار</p>
                </div>
              </div>

              <button
                onClick={handleAddStory}
                className="flex items-center gap-2 bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white px-4 py-2 rounded-xl font-medium transition-all hover:scale-105"
              >
                <Add />
                <span>افزودن استوری</span>
              </button>
            </div>

            {/* Stories grid */}
            {loading ? (
              <div className="flex justify-center items-center py-12">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
              </div>
            ) : error ? (
              <div className="text-center py-8 text-red-600 bg-red-50 rounded-xl">
                {error}
              </div>
            ) : stories.length === 0 ? (
              <div className="text-center py-12">
                <div className="inline-flex items-center justify-center w-20 h-20 rounded-full bg-gradient-to-r from-gray-100 to-gray-200 mb-4">
                  <Videocam className="text-gray-400 text-3xl" />
                </div>
                <h4 className="text-lg font-medium text-gray-700 mb-2">هنوز استوریای وجود ندارد</h4>
                <p className="text-gray-500 mb-6">اولین استوری را ایجاد کنید</p>
                <button
                  onClick={handleAddStory}
                  className="inline-flex items-center gap-2 bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white px-6 py-3 rounded-xl font-medium transition-all hover:scale-105"
                >
                  <Add />
                  <span>ایجاد اولین استوری</span>
                </button>
              </div>
            ) : (
              <div className="flex gap-6 overflow-x-auto pb-4 px-2 scrollbar-hide">
                {stories.map((story) => (
                  <StoryCircle
                    key={story.id}
                    story={story}
                    onClick={handleStoryClick}
                    size="md"
                  />
                ))}
                
                {/* Add story button at the end */}
                <div className="flex flex-col items-center">
                  <button
                    onClick={handleAddStory}
                    className="w-20 h-20 rounded-full border-2 border-dashed border-gray-300 hover:border-blue-500 hover:bg-blue-50 flex items-center justify-center transition-all group"
                  >
                    <Add className="text-gray-400 group-hover:text-blue-600 text-2xl" />
                  </button>
                  <p className="mt-2 text-xs text-gray-600">افزودن استوری</p>
                </div>
              </div>
            )}

            {/* Stats */}
            {stories.length > 0 && (
              <div className="mt-6 pt-6 border-t border-gray-200">
                <div className="flex items-center justify-between text-sm text-gray-600">
                  <div className="flex items-center gap-4">
                    <div className="flex items-center gap-1">
                      <CameraAlt className="text-gray-400 text-sm" />
                      <span>{stories.length} استوری فعال</span>
                    </div>
                    <div className="flex items-center gap-1">
                      <Videocam className="text-gray-400 text-sm" />
                      <span>
                        {stories.filter(s => s.mediaType === 'Video').length} ویدیو
                      </span>
                    </div>
                  </div>
                  <div className="text-gray-500">
                    آخرین بهروزرسانی: {stories.length > 0 && 
                      new Date(stories[0].createdAt).toLocaleTimeString('fa-IR', { 
                        hour: '2-digit', 
                        minute: '2-digit' 
                      })
                    }
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        {/* Story Viewer Modal */}
        {showViewer && selectedStoryIndex !== null && (
          <StoryViewer
            stories={stories}
            initialIndex={selectedStoryIndex}
            onClose={handleCloseViewer}
          />
        )}
      </div>
    </div>
  );
};

export default StoriesSection;
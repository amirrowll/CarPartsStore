import React, { useState, useEffect, useRef } from 'react';
import { Close, NavigateBefore, NavigateNext, PlayArrow, Pause, VolumeOff, VolumeUp } from '@mui/icons-material';
import { Story } from '../types';
import { storyApi } from '../services/api';

interface StoryViewerProps {
  stories: Story[];
  initialIndex: number;
  onClose: () => void;
}

const StoryViewer: React.FC<StoryViewerProps> = ({ stories, initialIndex, onClose }) => {
  const [currentIndex, setCurrentIndex] = useState(initialIndex);
  const [progress, setProgress] = useState(0);
  const [isPlaying, setIsPlaying] = useState(true);
  const [isMuted, setIsMuted] = useState(false);
  const [hasViewed, setHasViewed] = useState(false);
  const videoRef = useRef<HTMLVideoElement>(null);
  const progressInterval = useRef<NodeJS.Timeout>();

  const currentStory = stories[currentIndex];

  useEffect(() => {
    if (currentStory && !hasViewed) {
      storyApi.incrementViewCount(currentStory.id);
      setHasViewed(true);
    }
  }, [currentStory, hasViewed]);

  useEffect(() => {
    if (!currentStory) return;

    setProgress(0);
    setHasViewed(false);
    setIsPlaying(true);

    if (currentStory.mediaType === 'Video' && videoRef.current) {
      videoRef.current.currentTime = 0;
      videoRef.current.play().catch(console.error);
    }

    const duration = currentStory.duration * 1000;
    const interval = 50; // Update every 50ms for smooth progress

    progressInterval.current = setInterval(() => {
      setProgress(prev => {
        const increment = (interval / duration) * 100;
        const newProgress = prev + increment;
        
        if (newProgress >= 100) {
          clearInterval(progressInterval.current);
          goToNext();
          return 0;
        }
        
        return newProgress;
      });
    }, interval);

    return () => {
      if (progressInterval.current) {
        clearInterval(progressInterval.current);
      }
    };
  }, [currentIndex, currentStory]);

  const goToNext = () => {
    if (currentIndex < stories.length - 1) {
      setCurrentIndex(prev => prev + 1);
    } else {
      onClose();
    }
  };

  const goToPrev = () => {
    if (currentIndex > 0) {
      setCurrentIndex(prev => prev - 1);
    }
  };

  const togglePlayPause = () => {
    if (currentStory.mediaType === 'Video' && videoRef.current) {
      if (isPlaying) {
        videoRef.current.pause();
      } else {
        videoRef.current.play().catch(console.error);
      }
    }
    setIsPlaying(!isPlaying);
  };

  const toggleMute = () => {
    if (videoRef.current) {
      videoRef.current.muted = !isMuted;
      setIsMuted(!isMuted);
    }
  };

  const handleVideoEnd = () => {
    goToNext();
  };

  const handleVideoPlay = () => {
    setIsPlaying(true);
  };

  const handleVideoPause = () => {
    setIsPlaying(false);
  };

  const handleKeyDown = (e: KeyboardEvent) => {
    if (e.key === 'Escape') {
      onClose();
    } else if (e.key === 'ArrowRight') {
      goToNext();
    } else if (e.key === 'ArrowLeft') {
      goToPrev();
    } else if (e.key === ' ') {
      togglePlayPause();
    }
  };

  useEffect(() => {
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [currentIndex]);

  if (!currentStory) {
    return null;
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/90 backdrop-blur-sm">
      {/* Progress bars */}
      <div className="absolute top-4 left-4 right-4 flex gap-1 z-10">
        {stories.map((_, index) => (
          <div key={index} className="flex-1 h-1 bg-gray-700 rounded-full overflow-hidden">
            <div 
              className="h-full bg-white transition-all duration-300"
              style={{ 
                width: index === currentIndex ? `${progress}%` : 
                       index < currentIndex ? '100%' : '0%' 
              }}
            />
          </div>
        ))}
      </div>

      {/* Close button */}
      <button
        onClick={onClose}
        className="absolute top-4 right-4 z-10 text-white hover:bg-white/20 p-2 rounded-full transition-colors"
      >
        <Close />
      </button>

      {/* Navigation buttons - Fixed for RTL */}
      <button
        onClick={goToPrev}
        disabled={currentIndex === 0}
        className="absolute right-4 top-1/2 transform -translate-y-1/2 z-10 text-white hover:bg-white/20 p-3 rounded-full transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
      >
        <NavigateNext className="text-2xl" />
      </button>

      <button
        onClick={goToNext}
        disabled={currentIndex === stories.length - 1}
        className="absolute left-4 top-1/2 transform -translate-y-1/2 z-10 text-white hover:bg-white/20 p-3 rounded-full transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
      >
        <NavigateBefore className="text-2xl" />
      </button>

      {/* Story content */}
      <div className="relative w-full max-w-2xl h-[80vh] mx-4">
        {/* Media container */}
        <div className="relative w-full h-full rounded-2xl overflow-hidden bg-black">
          {currentStory.mediaType === 'Image' ? (
            <img
              src={currentStory.mediaUrl}
              alt={currentStory.title}
              className="w-full h-full object-contain"
            />
          ) : (
            <video
              ref={videoRef}
              src={currentStory.mediaUrl}
              className="w-full h-full object-contain"
              onEnded={handleVideoEnd}
              onPlay={handleVideoPlay}
              onPause={handleVideoPause}
              muted={isMuted}
              playsInline
              autoPlay
            />
          )}

          {/* Gradient overlay for text */}
          <div className="absolute bottom-0 left-0 right-0 h-1/3 bg-gradient-to-t from-black/80 via-black/40 to-transparent" />
        </div>

        {/* Story info */}
        <div className="absolute bottom-0 left-0 right-0 p-6 text-white z-10">
          <div className="flex items-center gap-3 mb-3">
            {currentStory.createdByUserAvatar ? (
              <img
                src={currentStory.createdByUserAvatar}
                alt={currentStory.createdByUserName}
                className="w-10 h-10 rounded-full border-2 border-white"
              />
            ) : (
              <div className="w-10 h-10 rounded-full bg-gradient-to-r from-blue-500 to-purple-600 flex items-center justify-center text-white font-bold">
                {currentStory.createdByUserName?.[0] || 'A'}
              </div>
            )}
            <div>
              <h3 className="font-bold text-lg">{currentStory.createdByUserName || 'Admin'}</h3>
              <p className="text-sm text-gray-300">
                {new Date(currentStory.createdAt).toLocaleTimeString('fa-IR', { 
                  hour: '2-digit', 
                  minute: '2-digit' 
                })}
              </p>
            </div>
          </div>

          <h2 className="text-2xl font-bold mb-2">{currentStory.title}</h2>
          <p className="text-gray-200 mb-4">{currentStory.description}</p>

          {/* Controls */}
          <div className="flex items-center gap-4">
            {currentStory.mediaType === 'Video' && (
              <>
                <button
                  onClick={togglePlayPause}
                  className="flex items-center gap-2 bg-white/20 hover:bg-white/30 px-4 py-2 rounded-full transition-colors"
                >
                  {isPlaying ? <Pause /> : <PlayArrow />}
                  <span>{isPlaying ? 'توقف' : 'پخش'}</span>
                </button>

                <button
                  onClick={toggleMute}
                  className="flex items-center gap-2 bg-white/20 hover:bg-white/30 px-4 py-2 rounded-full transition-colors"
                >
                  {isMuted ? <VolumeOff /> : <VolumeUp />}
                  <span>{isMuted ? 'صدا روشن' : 'صدا خاموش'}</span>
                </button>
              </>
            )}

            <div className="flex-1" />

            <div className="text-sm text-gray-300">
              {currentStory.viewCount.toLocaleString('fa-IR')} بازدید
            </div>
          </div>
        </div>

        {/* Click areas for navigation - Fixed for RTL */}
        <div 
          className="absolute left-0 top-0 bottom-0 w-1/3 cursor-pointer"
          onClick={goToPrev}
        />
        <div 
          className="absolute right-0 top-0 bottom-0 w-1/3 cursor-pointer"
          onClick={goToNext}
        />
      </div>

      {/* Story counter */}
      <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 text-white text-sm bg-black/50 px-4 py-2 rounded-full">
        {currentIndex + 1} / {stories.length}
      </div>
    </div>
  );
};

export default StoryViewer;
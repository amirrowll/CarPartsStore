import React, { useState } from 'react';
const StoryCircle = ({ story, onClick, size = 'md' }) => {
    const [isHovered, setIsHovered] = useState(false);
    const sizeClasses = {
        sm: 'w-16 h-16',
        md: 'w-20 h-20',
        lg: 'w-24 h-24'
    };
    const borderSizeClasses = {
        sm: 'p-0.5',
        md: 'p-1',
        lg: 'p-1.5'
    };
    const iconSizeClasses = {
        sm: 'text-sm',
        md: 'text-base',
        lg: 'text-lg'
    };
    const handleClick = () => {
        onClick(story);
    };
    return (<div className="flex flex-col items-center cursor-pointer group" onClick={handleClick} onMouseEnter={() => setIsHovered(true)} onMouseLeave={() => setIsHovered(false)}>
      <div className={`relative ${borderSizeClasses[size]} rounded-full bg-gradient-to-r from-blue-500 to-purple-600 group-hover:from-blue-600 group-hover:to-purple-700 transition-all duration-300 ${isHovered ? 'scale-110' : 'scale-100'}`}>
        <div className={`${sizeClasses[size]} rounded-full bg-white p-0.5 overflow-hidden`}>
          {/* نمایش لوگوی سایت در همه استوری‌ها */}
          <div className="w-full h-full rounded-full flex items-center justify-center">
            <img src="/PinpartStore.JPEG" alt="Pinpart Store Logo" className="w-full h-full rounded-full object-cover" onError={(e) => {
            const target = e.target;
            target.src = 'https://via.placeholder.com/100/3B82F6/FFFFFF?text=PinPart';
        }}/>
          </div>
          

        </div>

      </div>
      
      {/* Title */}
      <div className="mt-2 text-center max-w-[80px]">
        <p className="text-xs font-medium text-gray-800 truncate group-hover:text-blue-600 transition-colors">
          {story.title}
        </p>
      </div>
    </div>);
};
export default StoryCircle;

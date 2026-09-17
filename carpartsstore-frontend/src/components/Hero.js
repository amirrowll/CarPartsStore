import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Search, Loader } from 'lucide-react';
import { sliderApi } from '../services/api';
import './Slider.css';
const Hero = () => {
    const navigate = useNavigate();
    const [slides, setSlides] = useState([]);
    const [currentSlide, setCurrentSlide] = useState(0);
    const [isPlaying, setIsPlaying] = useState(true);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState('');
    const [searchQuery, setSearchQuery] = useState('');
    // Load slides from API
    useEffect(() => {
        const loadSlides = async () => {
            try {
                setLoading(true);
                const data = await sliderApi.getActiveSlides();
                const sortedSlides = data.sort((a, b) => a.order - b.order);
                setSlides(sortedSlides);
                setError('');
            }
            catch (err) {
                console.error('Error loading slides:', err);
                setError('خطا در بارگذاری اسلایدها');
            }
            finally {
                setLoading(false);
            }
        };
        loadSlides();
    }, []);
    // Auto slide functionality
    useEffect(() => {
        let interval;
        if (isPlaying && slides.length > 1) {
            interval = window.setInterval(() => {
                setCurrentSlide((prev) => (prev + 1) % slides.length);
            }, 5000); // 5 seconds
        }
        return () => {
            if (interval)
                clearInterval(interval);
        };
    }, [isPlaying, slides.length]);
    const nextSlide = () => {
        setCurrentSlide((prev) => (prev + 1) % slides.length);
    };
    const prevSlide = () => {
        setCurrentSlide((prev) => (prev - 1 + slides.length) % slides.length);
    };
    const goToSlide = (index) => {
        setCurrentSlide(index);
    };
    const handleSearch = (e) => {
        e.preventDefault();
        if (searchQuery.trim()) {
            navigate('/advanced-search', {
                state: { initialFilters: { search: searchQuery.trim() } }
            });
        }
    };
    const handleTagClick = (tag) => {
        navigate('/advanced-search', {
            state: { initialFilters: { search: tag } }
        });
    };
    return (<section className="relative text-white overflow-hidden">
      {/* Slides Container */}
      <div className="absolute inset-0">
        {loading ? (<div className="absolute inset-0 flex items-center justify-center bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-900">
            <Loader className="h-12 w-12 text-white animate-spin"/>
          </div>) : error ? (<div className="absolute inset-0 bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-900">
            <div className="h-full flex items-center justify-center text-center">
              <div>
                <p className="text-white text-xl mb-2">خطا در بارگذاری اسلایدها</p>
                <p className="text-blue-200">استفاده از نسخه پیشفرض</p>
              </div>
            </div>
          </div>) : slides.length > 0 ? (slides.map((slide, index) => (<div key={slide.id} className={`absolute inset-0 transition-all duration-1000 ease-in-out ${index === currentSlide
                ? 'opacity-100 transform translate-x-0'
                : 'opacity-0 transform translate-x-full'}`} style={{
                transitionProperty: 'opacity, transform',
                transitionTimingFunction: 'cubic-bezier(0.4, 0, 0.2, 1)',
            }}>
              {/* Slide Image */}
              <div className="absolute inset-0">
                <img src={slide.imageUrl} alt={slide.title} className="w-full h-full object-cover" onError={(e) => {
                const target = e.target;
                target.src = '/placeholder-car.jpg';
            }}/>
              </div>
              
              {/* Gradient Overlay */}
              <div className="absolute inset-0 bg-gradient-to-br from-blue-900/60 via-blue-800/40 to-indigo-900/50"></div>
              <div className="absolute inset-0 bg-black opacity-10"></div>
            </div>))) : (<div className="absolute inset-0 bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-900">
            <div className="h-full flex items-center justify-center text-center">
              <div>
                <h1 className="text-4xl md:text-6xl font-bold mb-6 text-white">
                  قطعات <span className="text-blue-300">خودرو</span> با کیفیت
                </h1>
                <p className="text-xl md:text-2xl text-blue-100 mb-10 max-w-3xl mx-auto">
                  بزرگترین مجموعه قطعات یدکی خودرو با گارانتی کیفیت و قیمت مناسب
                </p>
              </div>
            </div>
          </div>)}
      </div>
      
      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 md:py-32">
        <div className="text-center">
          {loading || error || slides.length === 0 ? (<>
              <h1 className="text-4xl md:text-6xl font-bold mb-6 tracking-tight">
                قطعات <span className="text-blue-300">خودرو</span> با کیفیت
              </h1>
              <p className="text-xl text-center md:text-2xl text-blue-100 mb-10 max-w-3xl mx-auto">
                بزرگترین مجموعه قطعات یدکی خودرو با گارانتی کیفیت و قیمت مناسب
              </p>
            </>) : (<>
              <h1 className="text-4xl md:text-6xl font-bold mb-6 tracking-tight">
                {slides[currentSlide].title}
              </h1>
              <p className="text-xl text-center md:text-2xl text-blue-100 mb-10 max-w-3xl mx-auto">
                {slides[currentSlide].description}
              </p>
            </>)}
          
          <div className="max-w-2xl mx-auto">
            <form onSubmit={handleSearch}>
              <div className="relative">
                <input type="text" value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} placeholder="جستجوی قطعه مورد نظر..." className="w-full pl-4 pr-12 py-4 bg-white/10 backdrop-blur-sm border border-white/20 rounded-2xl text-lg text-white placeholder-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent text-right"/>
                <button type="submit" className="absolute inset-y-0 left-0 pl-4 flex items-center text-blue-300 hover:text-white transition-colors">
                  <Search className="h-5 w-5"/>
                </button>
              </div>
            </form>
            
            {/* Catalog Download Link */}
            <div className="mt-6 text-center">
              <button onClick={async () => {
            try {
                const response = await fetch('/pinpart-catalog.pdf');
                const blob = await response.blob();
                const url = window.URL.createObjectURL(blob);
                const link = document.createElement('a');
                link.href = url;
                link.download = 'کاتالوگ-پین-پارت.pdf';
                document.body.appendChild(link);
                link.click();
                window.URL.revokeObjectURL(url);
                document.body.removeChild(link);
            }
            catch (error) {
                console.error('Error downloading PDF:', error);
                // Fallback to direct download
                const link = document.createElement('a');
                link.href = '/pinpart-catalog.pdf';
                link.download = 'کاتالوگ-پین-پارت.pdf';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }
        }} className="inline-flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-medium rounded-xl hover:from-blue-700 hover:to-cyan-600 transition-all shadow-lg hover:shadow-xl">
                <span className="text-lg"> دانلود کاتالوگ پین پارت </span>
              </button>
              <p className="text-blue-100 text-center text-sm mt-2">
                دانلود فایل PDF کامل کاتالوگ محصولات ما
              </p>
            </div>
          </div>
        </div>

      </div>
      
      {/* Decorative elements */}
      <div className="absolute bottom-0 left-0 right-0 h-20 bg-gradient-to-t from-white to-transparent"></div>
    </section>);
};
export default Hero;

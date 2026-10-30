import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';

/**
 * Resets window scroll position to (0, 0) upon any page navigation
 */
const ScrollToTop = () => {
  const { pathname, search } = useLocation();

  useEffect(() => {
    window.scrollTo({
      top: 0,
      left: 0,
      behavior: 'instant'
    });
  }, [pathname, search]);

  return null;
};

export default ScrollToTop;

declare module 'lucide-react' {
  import { FC, SVGProps } from 'react';
  
  export interface IconProps extends SVGProps<SVGSVGElement> {
    size?: number | string;
    strokeWidth?: number | string;
  }
  
  export type Icon = FC<IconProps>;
  
  // Export all icons used in the project
  export const Search: Icon;
  export const Menu: Icon;
  export const X: Icon;
  export const Car: Icon;
  export const Grid: Icon;
  export const Settings: Icon;
  export const Wrench: Icon;
  export const Battery: Icon;
  export const Gauge: Icon;
  export const Cog: Icon;
  export const Star: Icon;
  export const Eye: Icon;
  export const Phone: Icon;
  export const Mail: Icon;
  export const MapPin: Icon;
  export const Shield: Icon;
  export const Truck: Icon;
  export const Clock: Icon;
  export const CreditCard: Icon;
  export const CheckCircle: Icon;
  export const Headphones: Icon;
  export const Quote: Icon;
  export const Lock: Icon;
  export const MailIcon: Icon;
  export const Plus: Icon;
  export const Package: Icon;
  export const Layers: Icon;
  export const EyeIcon: Icon;
  export const Edit: Icon;
  export const Trash2: Icon;
  export const StarIcon: Icon;
  export const Tag: Icon;
  export const Filter: Icon;
  export const ChevronLeft: Icon;
  export const ChevronRight: Icon;
  export const Image: Icon;
  export const Save: Icon;
  export const EyeOff: Icon;
  export const Loader: Icon;
  export const Upload: Icon;
  export const Pause: Icon;
  export const Play: Icon;
  export const Home: Icon;
  export const Users: Icon;
  export const Folder: Icon;
  export const TrendingUp: Icon;
  export const Building: Icon;
  export const Check: Icon;
  export const LogOut: Icon;
  export const ArrowLeft: Icon;
  export const MessageCircle: Icon;
  export const Send: Icon;
  export const ArrowRight: Icon;
  export const AlertCircle: Icon;
  export const Hash: Icon;
}
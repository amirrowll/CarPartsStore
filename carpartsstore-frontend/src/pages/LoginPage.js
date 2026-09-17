import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
const LoginPage = () => {
    const navigate = useNavigate();
    // Redirect to 404 page immediately
    useEffect(() => {
        navigate('/404');
    }, [navigate]);
    return null;
};
export default LoginPage;

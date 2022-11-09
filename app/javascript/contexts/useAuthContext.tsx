import AuthContext from './AuthContext'
import { useContext } from 'react';

const useAuthContext = () => {
  return useContext(AuthContext);
}

export default useAuthContext;

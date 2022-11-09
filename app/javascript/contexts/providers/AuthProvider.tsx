import React, { useState, useEffect } from 'react';
import AuthContext from '../AuthContext';
import AuthService from '../../services/AuthService';

const AuthProvider = (props) => {
  const [user, setUser] = useState({});

  useEffect(() => {
    const getUser = async () => {
      const token = localStorage.getItem('token');
      const validatedToken = await AuthService.validateToken(token);

      return validatedToken ? await AuthService.getUser() : {};
    }

    getUser().then(fetchedUser => setUser(fetchedUser));
  }, []);

  return (
    <AuthContext.Provider value={ user }>
      {props.children}
    </AuthContext.Provider>
  );
};

export default AuthProvider;

import axios from '../packs/axios';
import jwt_decode from 'jwt-decode';
import { JwtPayload } from '../types/auth'
import { LOGIN_PATH } from '../constants/paths';

class AuthService {
  async signUp(input) {
    return await axios.post('/api/v1/users/sign_up', input).then((res) => {
      if(res.status === 200) return res;
    }).catch((e) => {
      return e;
    })
  };

  async signIn(input) {
    return await axios.post('/api/v1/login', input).then((res) => {
      if(res.status === 200) {
        localStorage.setItem('token', res.data.token);
        return res;
      }
    }).catch((e) => {
      return e
    })
  };

  async getUser () {
    return await axios.get('/api/v1/users/me').then((res) => {
      if(res.status === 200) return res.data;
    }).catch((e) => {
      if(e.response.status === 401) {
        localStorage.removeItem('token');
        window.location.href = LOGIN_PATH;
      }

      console.log(e);
    })
  }

  validateToken(token) {
    if(token && this.verifyToken(token)) return token;

    localStorage.removeItem('token');
  };

  verifyToken(token) {
    const decodedToken = jwt_decode(token) as JwtPayload;
    if(!decodedToken.exp) return false;

    return new Date(decodedToken.exp * 1000) > new Date();
  }
}

export default new AuthService();

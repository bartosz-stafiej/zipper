import axios from 'axios';

const httpClient = axios.create();

const token = localStorage.getItem('token');
if(token) httpClient.defaults.headers.common['Authorization'] = `Bearer ${token}`;

httpClient.defaults.headers.common['Content-Type'] = 'application/json';

export default httpClient;

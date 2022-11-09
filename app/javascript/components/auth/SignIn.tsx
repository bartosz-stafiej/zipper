import React, { useState } from 'react';
import {Link, useNavigate} from 'react-router-dom';
import { ATTACHMENTS_LIST_PATH, SIGN_UP_PATH } from '../../constants/paths';
import { SignInInput } from '../../types/auth'
import AuthService from '../../services/AuthService';
import useAuthContext from '../../contexts/useAuthContext';
import _ from 'lodash';

const SignIn = ({ setFlash }) => {
  const [input, setInput] = useState({} as SignInInput);
  const [isErrored, setIsErrored] = useState(false)
  const navigate = useNavigate();

  const user = useAuthContext();

  const signIn = async (e) => {
    e.preventDefault();

    await AuthService.signIn(input).then((res) => {
      if (res.status !== 200) return setIsErrored(true);

        setFlash('Logowanie pomyslne')
        navigate(ATTACHMENTS_LIST_PATH);
        window.location.reload();
    });
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setInput({...input, [e.target.id]: e.target.value })
  };

  if(!_.isEmpty(user)) navigate(ATTACHMENTS_LIST_PATH);

  return (
    <div className="h-screen w-full flex justify-center">
      <div className="w-1/4 h-1/2 border-2 border-blue-500 rounded-md m-5 p-3">
        <form method="post">
          <div className="text-center text-2xl w-full my-3">Zaloguj sie</div>
          {
            isErrored &&
            <div className="text-red-500 text-md">
              Nieprawidlowy email lub haslo, spróbuj ponownie.
            </div>
          }
          <div className="my-3">
            <label className="text-sm">Email</label>
            <input
              type="text"
              id="email"
              className="border border-blue-500 rounded-md w-full p-1"
              onChange={handleInputChange}
            />
          </div>
          <div className="my-3">
            <label className="text-sm">Hasło</label>
            <input
              type="password"
              id="password"
              className="border border-blue-500 rounded-md w-full p-1"
              onChange={handleInputChange}
            />
            <Link to={SIGN_UP_PATH} className="text-xs">Zarejestruj sie</Link>
          </div>
          <div className="flex justify-end">
            <button
              type="submit"
              className="bg-blue-500 text-white p-1 my-3 rounded-md"
              onClick={signIn}
              id="login"
            >
              Zaloguj sie
            </button>
          </div>
        </form>
      </div>
    </div>
  )
};

export default SignIn;

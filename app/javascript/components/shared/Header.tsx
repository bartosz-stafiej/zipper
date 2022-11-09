import React from 'react';
import { Link } from 'react-router-dom';
import { NEW_ATTACHMENTS_PATH, ATTACHMENTS_LIST_PATH, SIGN_UP_PATH, LOGIN_PATH } from '../../constants/paths';
import useAuthContext from '../../contexts/useAuthContext';
import _ from 'lodash';

const Header = () => {
  const user = useAuthContext();

  const headerButtons = () => {
    if (_.isEmpty(user)) {
      return(
        <>
          <li>
            <Link to={LOGIN_PATH} className="text-lg p-2">Zaloguj sie</Link>
          </li>
          <li>
            <Link to={SIGN_UP_PATH} className="text-lg p-2">Zarejestruj sie</Link>
          </li>
        </>
      )
    } else {
      return (
        <>
          <li>
            <Link to={NEW_ATTACHMENTS_PATH} className="text-lg p-2">Dodaj Plik</Link>
          </li>
          <li>
            <Link to={ATTACHMENTS_LIST_PATH} className="text-lg p-2">Lista Plikow</Link>
          </li>
          <li
            onClick={() => {
              localStorage.removeItem('token');
              window.location.reload();
            }}
            className="cursor-pointer hover:text-blue-500"
            id="logout"
          >
            <div className="text-lg p-2">Wyloguj sie</div>
          </li>
        </>
      )
    }
  }

  return (
    <header>
      <div className="flex justify-between items-center px-4 py-2">
        <Link to="/" className="text-2xl p-2">
          Zipper
        </Link>
        <ul className="flex items-center">
          {headerButtons()}
        </ul>
      </div>
      <hr />
    </header>
  )
};

export default Header;

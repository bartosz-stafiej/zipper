import React, { useState } from 'react';
import { Route, Routes, Navigate } from 'react-router-dom';
import Attachments from './attachments/AttachmentsList';
import NewAttachment from './attachments/NewAttachment'
import SignIn from './auth/SignIn';
import SignUp from './auth/SignUp';
import Header from './shared/Header';
import Flash from './shared/Flash';
import { ATTACHMENTS_LIST_PATH, LOGIN_PATH, NEW_ATTACHMENTS_PATH, SIGN_UP_PATH } from '../constants/paths';
import useAuthContext from '../contexts/useAuthContext';
import _ from 'lodash';

const App = () => {
  const [flash, setFlash] = useState('');
  const user = useAuthContext();
  const rootPath = () => _.isEmpty(user) ? LOGIN_PATH : ATTACHMENTS_LIST_PATH;

  return (
    <>
      <Header />
      {
        flash !== '' && <Flash message={flash} setMessage={setFlash} />
      }
      <Routes>
        <Route
          path="/"
          element={<Navigate to={rootPath()} />}
        />
        <Route path={ATTACHMENTS_LIST_PATH} element={<Attachments />} />
        <Route path={LOGIN_PATH} element={<SignIn setFlash={setFlash} />} />
        <Route path={NEW_ATTACHMENTS_PATH} element={<NewAttachment setFlash={setFlash} />} />
        <Route path={SIGN_UP_PATH} element={<SignUp setFlash={setFlash} />} />
      </Routes>
    </>
  )
};

export default App;

import React from 'react';
import { Route, Routes } from 'react-router-dom';
import Attachments from './attachments/AttachmentsList'

const App = () => {
  return (
    <Routes>
      <Route path="/attachments" element={<Attachments />} />
    </Routes>
  )
}

export default App;

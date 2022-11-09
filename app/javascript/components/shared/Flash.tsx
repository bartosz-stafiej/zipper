import React from 'react';

const Flash = ({ message, setMessage }) => {
  return (
    <div className={`w-full bg-green-500 text-white flex`}>
      <div className="flex justify-content-center items-center h-10 w-full">
        {message}
      </div>
      <div
        className="w-min text-xs cursor-pointer"
        onClick={() => setMessage('')}
      >
        Zamknij
      </div>
    </div>
  )
};

export default Flash;

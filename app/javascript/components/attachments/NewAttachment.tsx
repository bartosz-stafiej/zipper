import React, { useState, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import useAuthContext from '../../contexts/useAuthContext';
import _ from 'lodash';
import { ATTACHMENTS_LIST_PATH, LOGIN_PATH } from '../../constants/paths';
import AttachmentsService from '../../services/AttachmentsService';

const NewAttachment = ({ setFlash }) => {
  const hiddenFileInput = useRef(null);

  const user = useAuthContext();
  const navigate = useNavigate();

  const [filesInput, setFilesInput] = useState([]);
  const [isErrored, setIsErrored] = useState(false);

  const clickHiddenFileInput = (e) => {
    e.preventDefault();
    const element = hiddenFileInput.current as unknown as HTMLInputElement;
    element.click();
  }

  const createAttachment = (e) => {
    e.preventDefault();
    AttachmentsService.createAttachment(filesInput).then((res) => {
      if(res.status === 201) {
        setFlash(`Utworzono plik pomyslnie, Twoje hasło: ${res.data.password}`);

        navigate(ATTACHMENTS_LIST_PATH);
      }
    }).catch(_e => setIsErrored(true))
  };

  const submitButtonClass = () => {
    return _.isEmpty(filesInput) ?
      'text-gray-500 border bg-white rounded-md p-2 cursor-default' :
      'bg-blue-500 text-white rounded-md p-2';
  }

  if(_.isEmpty(user)) navigate(LOGIN_PATH);

  return (
    <div className="h-screen w-full flex justify-center">
      <div className="w-1/4 h-5/6 border-2 border-blue-500 rounded-md m-5 p-3">
        <div className="text-center text-2xl w-full my-3">Dodaj Plik</div>
        <div className="text-center text-sm w-full my-3">Możesz dodać do 10 plików</div>
        {
          isErrored &&
          <div className="text-red-500 text-md">
            Cos poszlo nie tak, spróbuj ponownie.
          </div>
        }
        <form method="post">
          {_.map(filesInput, (file, key) => {
            return (
              <div className="border rounded-md py-1 px-3 my-2 flex justify-content-between" key={key}>
                <div className="w-3/4 truncate">{file.name}</div>
                <div
                  className="cursor-pointer w-1/4 flex justify-content-end"
                  onClick={() => {
                    const newFilesInput = filesInput;
                    newFilesInput.splice(key, 1);
                    setFilesInput([...newFilesInput]);
                  }}
                >
                  <div className="text-blue-500">Usun</div>
                </div>
              </div>
            )
          })}
          {
            filesInput.length < 10 &&
              <div className="border rounded-md truncate py-1 px-3 my-2">
                <button onClick={clickHiddenFileInput} className="text-center w-full">
                  Dodaj
                </button>
              </div>
          }
          <input
            type="file"
            className="hidden"
            ref={hiddenFileInput}
            onChange={(e) => setFilesInput([...filesInput, e.target.files[0]])}
          />
          <div className="flex justify-end">
            <button
              type="submit"
              className={submitButtonClass()}
              onClick={createAttachment}
              disabled={_.isEmpty(filesInput)}
            >
              Stworz Plik
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default NewAttachment;

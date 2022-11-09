import React, { useEffect, useState } from 'react';
import useAuthContext from '../../contexts/useAuthContext';
import AttachmentsService from '../../services/AttachmentsService';
import { useNavigate } from 'react-router-dom';
import { LOGIN_PATH } from '../../constants/paths';
import Attachment from '../attachments/Attachment';
import _ from 'lodash';

const AttachmentsList = () => {
  const user = useAuthContext();
  const navigate = useNavigate();

  const [pageNumber, setPageNumber] = useState(1);
  const [itemsCount, setItemsCount] = useState(10);
  const [attachments, setAttachments] = useState([]);

  if (_.isEmpty(user)) navigate(LOGIN_PATH);

  const fetchAttachments = async (page) => {
    return await AttachmentsService.fetchAttachments(page, itemsCount).then(res => res.data);
  }

  const fetchNextPage = async (page) => {
      const fetchedAttachments = await fetchAttachments(page);
      await setAttachments(fetchedAttachments);
  }

  useEffect(() => {
    fetchAttachments(pageNumber).then((fetchedAttachments) => {
      setAttachments(fetchedAttachments)
    });
  }, [])

  return (
    <div className="flex flex-col">
      <div className="overflow-x-auto sm:-mx-6 lg:-mx-8">
        <div className="py-2 inline-block min-w-full sm:px-6 lg:px-8">
          <div className="overflow-hidden">
            <table className="min-w-full">
              <thead className="bg-white border-b">
              <tr>
                <th scope="col" className="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                  Id
                </th>
                <th scope="col" className="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                  Nazwa pliku
                </th>
                <th scope="col" className="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                  Stworzony
                </th>
                <th scope="col" className="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                  Rozmiar
                </th>
                <th scope="col" className="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                  Link
                </th>
              </tr>
              </thead>
              <tbody>
              {
                _.map(attachments, (attachmentDetails, key) => {
                  return <Attachment attachment={attachmentDetails} key={key}/>
                })
              }
              </tbody>
            </table>
            <div className="w-full flex justify-content-end">
              {
                pageNumber > 1 &&
                  <div
                    onClick={async () => {
                      const currentPage = pageNumber - 1;

                      await fetchNextPage(currentPage);
                      await setPageNumber(currentPage);
                    }}
                    className={`inline-flex items-center py-2 px-4 text-sm font-medium
                      text-gray-500 bg-white rounded-lg border border-gray-300 hover:bg-gray-100
                      hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400
                      dark:hover:bg-gray-700 dark:hover:text-white cursor-pointer`}
                    id="previous"
                    >
                      Previous
                  </div>
              }
              {
                attachments.length === itemsCount &&
                  <div
                    onClick={async () => {
                      const currentPage = pageNumber + 1;

                      await fetchNextPage(currentPage);
                      await setPageNumber(currentPage);
                    }}
                    className={`inline-flex items-center py-2 px-4 ml-3 text-sm
                  font-medium text-gray-500 bg-white rounded-lg border border-gray-300
                  hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700
                  dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white cursor-pointer`}
                    id="next"
                  >
                    Next
                  </div>
              }
            </div>
          </div>
        </div>
      </div>
    </div>
  )
};

export default AttachmentsList;

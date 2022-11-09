import React from 'react';
import prettyBytes from 'pretty-bytes';

const Attachment = ({ attachment }) => {
  return (
    <tr className="bg-gray-100 border-b" id="attachment-item">
      <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{attachment.id}</td>
      <td className="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
        {attachment.zip_file?.blob?.filename}
      </td>
      <td className="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
        {attachment.created_at}
      </td>
      <td className="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
        {attachment.zip_file && prettyBytes(attachment.zip_file.blob.byte_size)}
      </td>
      <td className="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
        {
          attachment.zip_file &&
            <a href={process.env.REACT_APP_BACKEND_URL + attachment.zip_file?.url} target="_blank">
              Pobierz
            </a>
        }
      </td>
    </tr>
  )
};

export default Attachment;

import axios from '../packs/axios';
import { ATTACHMENTS_LIST_PATH, ATTACHMENTS_PATH } from '../constants/paths';
import _ from 'lodash';

class AttachmentsService {
  async fetchAttachments(pageNumber, items=10) {
    const queryParams = `?items=${items}&page=${pageNumber}`

    return await axios.get('/api/v1' + ATTACHMENTS_LIST_PATH + queryParams).then((res) => {
      if (res.status === 200) return res.data
    }).catch((e) => {
      console.log(e);
    })
  }

  async createAttachment(filesInput) {
    const formData = new FormData();
    _.each(filesInput, (file) => formData.append('files[]', file))

    return await axios.post(
      '/api/v1' + ATTACHMENTS_PATH,
      formData
    ).then((res) => {
      if (res.status === 201) return res;
    }).catch((e) => {
      console.log(e);
      return e;
    });
  }
}

export default new AttachmentsService();

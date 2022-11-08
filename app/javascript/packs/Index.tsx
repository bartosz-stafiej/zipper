// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import App from '../components/App'
import { BrowserRouter as Router } from 'react-router-dom'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Router>
      <App />
    </Router>,
    document.body.appendChild(document.createElement('div')),
  )
});

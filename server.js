// server.js
const express = require('express');
const app = express();
const cors = require('cors');
require('dotenv').config();
const { google } = require('googleapis');
const fs = require('fs');
const axios = require('axios');

app.use(cors({
  origin: '*',
  methods: ['GET','POST','OPTIONS'],
  allowedHeaders: ['Content-Type','Authorization']
}));
app.use(express.json());

const CLIENT_ID = process.env.GOOGLE_CLIENT_ID;
const CLIENT_SECRET = process.env.GOOGLE_CLIENT_SECRET;
const REDIRECT_URI = process.env.GOOGLE_REDIRECT_URI;
const AI_API_URL = process.env.AI_API_URL;
const PHISHING_API_URL = process.env.PHISHING_API_URL || 'http://127.0.0.1:5001/predict_url';

function getOAuth2Client() {
  return new google.auth.OAuth2(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);
}

// แปลง body Base64 ให้เป็นข้อความ
const getBody = (payload) => {
  let body = '';
  if (payload.parts && payload.parts.length > 0) {
    payload.parts.forEach(p => {
      if (p.mimeType === 'text/plain' && p.body && p.body.data) {
        body += Buffer.from(p.body.data, 'base64').toString('utf8');
      } else if (p.parts && p.parts.length > 0) {
        body += getBody(p);
      }
    });
  } else if (payload.body && payload.body.data) {
    body = Buffer.from(payload.body.data, 'base64').toString('utf8');
  }
  return body;
};

// หน้าเว็บหลัก + Google Login
app.get('/', (req, res) => {
  res.send(`
    <html>
      <body>
        <h1>Login with Google</h1>
        <button id="loginBtn">Login with Google</button>
        <pre id="tokenDisplay"></pre>
        <script>
          document.getElementById('loginBtn').onclick = async () => {
            const res = await fetch('/auth');
            const data = await res.json();
            const win = window.open(data.authUrl, 'googleLogin', 'width=500,height=600');
            window.addEventListener('message', function handler(event) {
              if (event.origin !== window.location.origin) return;
              document.getElementById('tokenDisplay').innerText = JSON.stringify(event.data, null, 2);
              win.close();
              window.removeEventListener('message', handler);
            });
          }
        </script>
      </body>
    </html>
  `);
});

// Google OAuth URL
app.get('/auth', (req, res) => {
  if (fs.existsSync('token.json')) fs.unlinkSync('token.json');
  const oAuth2Client = getOAuth2Client();
  const SCOPES = ['https://www.googleapis.com/auth/gmail.readonly'];
  const authUrl = oAuth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: SCOPES,
    prompt: 'select_account'
  });
  res.json({ authUrl });
});

// Google OAuth callback
app.get('/google/callback', async (req, res) => {
  const oAuth2Client = getOAuth2Client();
  const { code } = req.query;
  if (!code) return res.status(400).send('No authorization code provided');
  try {
    const { tokens } = await oAuth2Client.getToken(code);
    oAuth2Client.setCredentials(tokens);
    fs.writeFileSync('token.json', JSON.stringify(tokens, null, 2));
    res.send(`
      <html>
        <body>
          <script>
            window.opener.postMessage(${JSON.stringify(tokens)}, window.location.origin);
          </script>
          <h3>Login successful! You can close this window.</h3>
        </body>
      </html>
    `);
  } catch (error) {
    console.error('Google OAuth error:', error);
    res.status(500).send('Failed to authenticate with Google');
  }
});

// Gmail endpoint
app.get('/gmail', async (req, res) => {
  try {
    if (!fs.existsSync('token.json')) return res.status(400).json({ error: 'No token found' });
    const token = JSON.parse(fs.readFileSync('token.json'));
    const oAuth2Client = getOAuth2Client();
    oAuth2Client.setCredentials(token);

    const gmail = google.gmail({ version: 'v1', auth: oAuth2Client });
    const list = await gmail.users.messages.list({ userId: 'me', maxResults: 10 });
    const messages = list.data.messages || [];

    const emails = await Promise.all(messages.map(async (msg) => {
      const detail = await gmail.users.messages.get({ userId: 'me', id: msg.id, format: 'full' });
      const headers = detail.data.payload.headers;
      const from = headers.find(h => h.name === 'From')?.value || 'Unknown Sender';
      const subject = headers.find(h => h.name === 'Subject')?.value || 'No Subject';
      const date = headers.find(h => h.name === 'Date')?.value || '';
      const body = getBody(detail.data.payload);

      return {
        sender: from,
        subject: subject,
        time: date ? new Date(date).toLocaleString() : '',
        body: body,
        status: 'Safe'
      };
    }));

    res.json(emails);
  } catch (err) {
    console.error('Error fetching Gmail:', err);
    res.status(500).json({ error: err.message });
  }
});

// AI endpoint
app.post('/ask-ai', async (req, res) => {
  try {
    const { text } = req.body;
    const response = await axios.post(AI_API_URL, { text });
    res.json(response.data);
  } catch (err) {
    console.error('AI API error:', err.message);
    res.status(500).json({ error: err.message });
  }
});

// Phishing URL check
app.post('/check_url', async (req, res) => {
  try {
    const { url } = req.body;
    const response = await axios.post(PHISHING_API_URL, { url });
    res.json(response.data);
  } catch (err) {
    console.error('Phishing API error:', err.message);
    res.status(500).json({ error: err.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => console.log(`Server running on http://localhost:${PORT}`));

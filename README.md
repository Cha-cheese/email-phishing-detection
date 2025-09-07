# Email Phishing Detection Application

Senior Project – Mae Fah Luang University

Role: Team Lead | Team size: 3 | Status: Under development


## ** 🖥️  Project Overview**

-   A real-time email phishing detection and prevention application
    
-   Fetches actual emails from users via **Gmail API**
    
-   Classifies emails as **Safe** or **Risk** using an **AI/ML Model**
    
-   Developed as a senior project at [Your University Name]


# 📱 Features

1.  **Home / Inbox**
    
    -   Displays emails in real-time
        
    -   Shows Safe or Risk status
        
    -   Safe emails can be opened to view details
        
    -   Risk emails cannot be opened
        
2.  **Report / Dashboard**
    
    -   Displays daily phishing email statistics in graphs
        
    -   Shows at-risk users
        
3.  **Phishing URL Checker**
    
    -   Allows users to paste URLs to check for potential phishing
        
4.  **Help Page**
    
    -   Provides instructions for using the application and its features

## 🛠️ Tech Stack

 -   **Programming / Development:** Python, JavaScript/TypeScript
    
-   **Backend:** Node.js
    
-   **Frontend / Mobile:** Flutter
    
-   **API Integration:** Gmail API
    
-   **AI/ML:** Model for Safe/Risk email classification
    
-   **Tools & Platforms:** Ngrok (for real-time testing), Jupyter Notebook


## ⚙️ Quick Start

 1. Clone the repository
 `git clone https://github.com/Cha-cheese/email-phishing-detection.git`
 `seniorproject`

 2. Install Node.js dependencies
 `npm install` 
 
 3. Run the server
	- Open a terminal in the server folder:
	`nodemon server.js`
	- Open the Flutter simulator / emulator and run the app
	
 4. Expose server with Ngrok 
    `ngrok http 3000`
    - Copy the Ngrok URL (e.g., `https://<your-ngrok-id>.ngrok-free.app`)
    - Update the **Authorized redirect URI** in Google Cloud Console
    - Add the Ngrok URL to the `.env` file

5.  **Set up Gmail API**
	-   Add authorized email(s) to **Test Users** in Google Cloud Console
    
	-   Download `credentials.json` and place it in the project root
    
	-   Login with an authorized Google account when prompted



## ⚠️ Limitations

-   Only authorized Gmail accounts in **Test Users** can log in and fetch real emails
    
-   External users cannot access Gmail login without permission
    

----------

### 💡 For Testing

-   Contact the project owner to be added as a **Test User** in Google Cloud Console
    
-   Follow the Quick Start steps to run the application
    



## 📌 Project Status

-   Currently **under development**
    
-   Some features are still being improved for full functionality

import pandas as pd
import joblib

# -------------------- Load Pipeline --------------------
full_pipeline = joblib.load("./Model/full_pipeline.pkl")
print("✅ Loaded pipeline")

# -------------------- Mock Emails --------------------
mock_emails = [
    {
        "subject": "Urgent: Update your account information",
        "body": "Click this link to verify your account immediately: http://phishy-link.com",
        "urls": "http://phishy-link.com",
        "sender": "support@secure-login.com"
    },
    {
        "subject": "Meeting agenda for tomorrow",
        "body": "Hi team, please see the agenda attached for tomorrow’s meeting.",
        "urls": "",
        "sender": "colleague@company.com"
    },
    {
        "subject": "Congratulations! You won a prize",
        "body": "Claim your prize by clicking this link: http://winbig.com",
        "urls": "http://winbig.com",
        "sender": "rewards@winbig.com"
    },
    {
        "subject": "Weekly newsletter",
        "body": "Here is our weekly newsletter with updates and news.",
        "urls": "",
        "sender": "newsletter@trustedsource.com"
    }
]

df_mock = pd.DataFrame(mock_emails)

# -------------------- Predict --------------------
predictions = full_pipeline.predict(df_mock)

# -------------------- Show Results --------------------
for email, pred in zip(mock_emails, predictions):
    print(f"Subject: {email['subject']}")
    print(f"Phishing? {'Yes' if pred == 1 else 'No'}\n")

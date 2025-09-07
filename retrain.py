import pandas as pd
import joblib
import cloudpickle
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.pipeline import Pipeline
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import FunctionTransformer

# -------------------- Data Mock (แทนที่จะโหลด CSV) --------------------
data = [
    {
        "subject": "Urgent: Update your account information",
        "body": "Click this link to verify your account immediately: http://phishy-link.com",
        "urls": "http://phishy-link.com",
        "sender": "support@secure-login.com",
        "label": 1
    },
    {
        "subject": "Meeting agenda for tomorrow",
        "body": "Hi team, please see the agenda attached for tomorrow’s meeting.",
        "urls": "",
        "sender": "colleague@company.com",
        "label": 0
    },
    {
        "subject": "Congratulations! You won a prize",
        "body": "Claim your prize by clicking this link: http://winbig.com",
        "urls": "http://winbig.com",
        "sender": "rewards@winbig.com",
        "label": 1
    },
    {
        "subject": "Weekly newsletter",
        "body": "Here is our weekly newsletter with updates and news.",
        "urls": "",
        "sender": "newsletter@trustedsource.com",
        "label": 0
    }
]
df = pd.DataFrame(data)

# -------------------- Pipeline --------------------
text_features = ["subject", "body", "sender", "urls"]

preprocessor = ColumnTransformer(
    transformers=[
        ("subject", TfidfVectorizer(), "subject"),
        ("body", TfidfVectorizer(), "body"),
        ("sender", TfidfVectorizer(), "sender"),
        ("urls", TfidfVectorizer(), "urls"),
    ],
    remainder="drop"
)

model = RandomForestClassifier(n_estimators=50, random_state=42)

full_pipeline = Pipeline([
    ("features", preprocessor),
    ("clf", model)
])

# -------------------- Train --------------------
X = df[text_features]
y = df["label"]

full_pipeline.fit(X, y)

# -------------------- Save --------------------
joblib.dump(full_pipeline, "./Model/full_pipeline.pkl")
print("✅ Retrain เสร็จแล้ว: บันทึก full_pipeline.pkl")

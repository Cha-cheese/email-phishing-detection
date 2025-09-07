import joblib
from flask import Flask, request, jsonify
from flask_cors import CORS  # ✅ เพิ่มเข้ามา

app = Flask(__name__)
CORS(app)  # ✅ เปิด CORS ให้ทุก origin

# โหลดโมเดล
model = joblib.load('/Users/macbookair/Desktop/Phising2/Model/model.joblib')

@app.route('/detect', methods=['POST'])
def detect():
    data = request.json
    email_text = data.get('email_text', '')

    prediction = model.predict([email_text])[0]
    is_phishing = bool(prediction)

    return jsonify({'is_phishing': is_phishing})

if __name__ == '__main__':
    app.run(port=5000)

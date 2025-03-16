import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B263B),
        title: Center(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/minilogo.png',
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How to Use the Phishing Email and URL Detection App',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // เปลี่ยนข้อความเป็นสีขาว
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'This application is designed to help you check emails and URLs for phishing threats, providing real-time protection. It helps ensure that you stay safe by identifying potentially harmful emails or links.',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white), // สีขาว
                        ),
                        SizedBox(height: 20),
                        Text(
                          '1. Email Checking',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        // Risk
                        Row(
                          children: [
                            Icon(Icons.error,
                                color: Colors.red), // Icon error สีแดง
                            SizedBox(width: 10), // เว้นห่าง 10 ต่อหัวข้อ
                            Expanded(
                              child: Text(
                                '- Risk: If the email you receive is detected as potentially phishing, you will not be able to open it. The app will display the message "Risk," meaning this email is considered high-risk and should be avoided.',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white), // สีขาว
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // เว้นระยะห่างระหว่างรายการ
                        // No Data
                        Row(
                          children: [
                            Icon(Icons.warning,
                                color: Colors.yellow), // Icon warning สีเหลือง
                            SizedBox(width: 10), // เว้นห่าง 10 ต่อหัวข้อ
                            Expanded(
                              child: Text(
                                '- No Data: If the system cannot check the data for the incoming email, it will indicate "No Data." This means we cannot determine whether it’s safe or not, but you should still be cautious when interacting with the email or clicking any links.',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white), // สีขาว
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // เว้นระยะห่างระหว่างรายการ
                        // No URL
                        Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: Colors.green), // Icon valid สีเขียว
                            SizedBox(width: 10), // เว้นห่าง 10 ต่อหัวข้อ
                            Expanded(
                              child: Text(
                                '- No URL: If the email does not contain any links, you can open it safely since it is presumed to be secure due to the absence of clickable links. The app will display "No URL," indicating the email is likely safe from phishing.',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white), // สีขาว
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          '2. URL Checking',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'In the URL checking page, you can submit external URLs that you suspect might be phishing. The results will be shown as either:',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white), // สีขาว
                        ),
                        SizedBox(height: 10),
                        // No Data for URL
                        Row(
                          children: [
                            Icon(Icons.error,
                                color: Colors.red), // Icon error สีแดง
                            SizedBox(width: 10), // เว้นห่าง 10 ต่อหัวข้อ
                            Expanded(
                              child: Text(
                                '- Risk: If the URL is identified as a phishing threat, the app will display "Risk," warning you not to visit the website or click on the link.',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white), // สีขาว
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // เว้นระยะห่างระหว่างรายการ
                        // Risk for URL
                        Row(
                          children: [
                            Icon(Icons.warning,
                                color: Colors.yellow), // Icon warning สีเหลือง
                            SizedBox(width: 10), // เว้นห่าง 10 ต่อหัวข้อ
                            Expanded(
                              child: Text(
                                '- No Data: This means the URL cannot be checked at the moment. You should be cautious about clicking on this URL.',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white), // สีขาว
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Recommendations',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'This application helps you check emails and URLs in real-time so that you can make informed decisions about whether to open an email or click on a link. Always exercise caution when opening emails and clicking on links from unknown or untrusted sources.',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white), // สีขาว
                        ),
                        SizedBox(height: 20),
                        Text(
                          'If you have any further questions about how to use the app or how we check for phishing threats, feel free to contact our support team for more assistance!',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white), // สีขาว
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

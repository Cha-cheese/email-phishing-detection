import 'package:flutter/material.dart';

class Detailemail extends StatelessWidget {
  final Map<String, String> email;

  const Detailemail({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B263B),
        title: Center(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Center(
                    child: Image.asset(
                      'assets/images/minilogo.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white), // เปลี่ยนสีของลูกศรย้อนกลับ
      ),
      body: Stack(
        children: [
          // เพิ่ม Container เพื่อทำให้พื้นหลังครอบคลุมเต็มจอ
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Container(
              width: 500,
              height: 500,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // เพิ่ม padding ด้านบนเพื่อขยับลง
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Sender: ${email['sender']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Status: ${email['status']}",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Time: ${email['time']}",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Details:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    email['details'] ?? "No additional information available.",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

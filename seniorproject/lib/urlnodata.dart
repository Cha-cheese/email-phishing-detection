import 'package:flutter/material.dart';

class Urlnodata extends StatefulWidget {
  const Urlnodata({super.key});

  @override
  State<Urlnodata> createState() => _UrlnodataState();
}

class _UrlnodataState extends State<Urlnodata> {
  @override
  Widget build(BuildContext context) {
    // ดึงขนาดหน้าจอ
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // รูปภาพที่ไม่ขยับ
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 130,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/logo.png',
                width: 600,
                height: 600,
              ),
            ),
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0), // ห่างจากขอบซ้าย 20 พิกเซล
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning, // ใช้ไอคอนเตือน
                        color: Colors.yellow, // เปลี่ยนสีไอคอน
                        size: 24, // ขนาดไอคอน
                      ),
                      SizedBox(width: 8), // ช่องว่างระหว่างไอคอนกับข้อความ
                      Text(
                        "No data! Please beware of this site.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'urlrisk.dart';
import 'urlnodata.dart';

class Url extends StatefulWidget {
  const Url({super.key});

  @override
  State<Url> createState() => _UrlState();
}

class _UrlState extends State<Url> {
  TextEditingController _urlController = TextEditingController();
  String? _message = '';

  Widget _currentPage = SizedBox();

  void _checkUrl() {
  String inputUrl = _urlController.text.trim();

  setState(() {
    if (inputUrl.isEmpty) {
      _message = 'Please enter an URL';
      _currentPage = SizedBox();
    } else if (inputUrl == "www.bad.com") {
      _currentPage = Urlrisk();
      _message = null;
    } else if (inputUrl == "www.bood.com") {
      _currentPage = Urlnodata();
      _message = null;
    } else {
      _message = 'No URL found';
      _currentPage = SizedBox();
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B263B),
        title: Center(
          child: Image.asset(
            'assets/images/minilogo.png',
            width: 60,
            height: 60,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 20), // ปรับความห่างจากบนให้ลดลง
              Center(
                child: SizedBox(
                  width: 380,
                  height: 40,
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: "Please enter an url and press check",
                      suffixIcon: Icon(Icons.search),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // ปรับช่องว่างระหว่างช่องค้นหากับปุ่ม
              ElevatedButton(
                onPressed: _checkUrl,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0070FF),
                  foregroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Check'),
                    SizedBox(width: 5),
                    Icon(Icons.ads_click),
                  ],
                ),
              ),
              SizedBox(height: 10), // ปรับช่องว่างระหว่างปุ่มกับข้อความแสดงผล
              if (_message != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    _message!,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              Expanded(child: _currentPage),
            ],
          ),
        ],
      ),
    );
  }
}

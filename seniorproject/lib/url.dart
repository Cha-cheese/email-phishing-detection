import 'package:flutter/material.dart';

class Url extends StatefulWidget {
  const Url({super.key});

  @override
  State<Url> createState() => _UrlState();
}

class _UrlState extends State<Url> {
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
              opacity: 0.3,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 380,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: Icon(Icons.search),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 110,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0070FF),
                        foregroundColor: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text('Check'),
                          Icon(Icons.ads_click),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

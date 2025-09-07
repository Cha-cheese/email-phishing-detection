import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Url extends StatefulWidget {
  const Url({super.key});

  @override
  State<Url> createState() => _UrlState();
}

class _UrlState extends State<Url> {
  TextEditingController _urlController = TextEditingController();
  String? _alertMessage = 'Please enter a URL starting with "https://"';
  Color _alertColor = Colors.black;
  Widget _currentPage = SizedBox();
  bool _hasChecked = false;

  Future<void> _checkUrl() async {
    setState(() {
      _hasChecked = true;
    });

    String inputUrl = _urlController.text.trim();

    if (inputUrl.isEmpty) {
      setState(() {
        _alertMessage = 'Please enter a URL starting with "https://"';
        _alertColor = Colors.black;
      });
      return;
    }

    if (!inputUrl.startsWith('https://') && !inputUrl.startsWith('http://')) {
      setState(() {
        _alertMessage = 'Please enter a URL starting with "https://"';
        _alertColor = Colors.red;
      });
      return;
    }

    final apiUrl = Uri.parse(
        'http://localhost:3000/check_url?url=${Uri.encodeComponent(inputUrl)}');

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          if (data['status'] == 'phishing') {
            _alertMessage = 'Risk! This url is a phishing attempt';
            _alertColor = Colors.red;
          } else if (data['status'] == 'safe') {
            _alertMessage = 'This URL is safe to access.';
            _alertColor = Colors.green;
          } else if (data['status'] == 'no_data') {
            _alertMessage =
                'Data Not Found! \n This URL isn’t in our database. \n Please be careful when accessing it.';
            _alertColor = Colors.yellow;
          } else {
            _alertMessage = 'Unexpected response from server';
            _alertColor = Colors.white;
          }
        });
      } else {
        setState(() {
          _alertMessage = 'Server error: ${response.statusCode}';
          _alertColor = Colors.white;
        });
      }
    } catch (e) {
      setState(() {
        _alertMessage = 'Failed to connect to server: ${e.toString()}';
        _alertColor = Colors.white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 159, 188, 242),
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
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 380,
                  height: 40,
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: "https:// or http://",
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
              SizedBox(height: 10),
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
              SizedBox(height: 10),

              if (_alertMessage != null && _alertMessage != '')
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_alertMessage !=
                          'Please enter a URL starting with "https://"')
                        Icon(
                          _alertColor == Colors.yellow
                              ? Icons.warning
                              : _alertColor == Colors.red
                                  ? Icons.error
                                  : Icons.check_circle,
                          color: _alertColor,
                          size: 24,
                        ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _alertMessage!,
                          style: TextStyle(fontSize: 16, color: _alertColor),
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 320,
                  child: Card(
                    color: Color(0xFF2E3A59),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'URL Status',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(color: Colors.white54),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.warning,
                                      color: Colors.yellow, size: 40),
                                  SizedBox(height: 8),
                                  Text('Data Not Found',
                                      style:
                                          TextStyle(color: Colors.white70)),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.error,
                                      color: Colors.red, size: 40),
                                  SizedBox(height: 8),
                                  Text('Risk Alert',
                                      style:
                                          TextStyle(color: Colors.white70)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Color(0xFF2E3A59),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '💡 Usage Tips',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('- Always include https:// or http:// at the start.',
                          style: TextStyle(color: Colors.white70)),
                      Text('- Don’t trust unknown shortened links.',
                          style: TextStyle(color: Colors.white70)),
                      Text('- Regularly scan unfamiliar websites.',
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<FlSpot> phishingData = [
    FlSpot(1, 9),
    FlSpot(2, 3),
    FlSpot(3, 6),
    FlSpot(4, 5),
    FlSpot(5, 8),
    FlSpot(6, 2),
    FlSpot(7, 7),
    FlSpot(8, 4),
    FlSpot(9, 1),
    FlSpot(10,6),
  ];

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
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(color: Colors.white), // สีขาวในแกน Y
                            );
                          }),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: TextStyle(color: Colors.white), // สีขาวในแกน X
                              );
                            }
                          ),
                        ),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // ปิดตัวเลขด้านบนกราฟ
                      ),
                      borderData: FlBorderData(show: true, border: Border.all(color: Colors.white)),
                      lineBarsData: [
                        LineChartBarData(
                          spots: phishingData,
                          isCurved: true,
                          color: Colors.white, // เปลี่ยนเส้นเป็นสีขาว
                          barWidth: 4,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(show: true, color: Colors.white.withOpacity(0.3)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    emailCard('Thai Tour Partnership', 'No data', Colors.orange),
                    emailCard('Maha Settee', 'Risk', Colors.red),
                    emailCard('Pipo Employment', 'No url', Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget emailCard(String title, String status, Color statusColor) {
    return SizedBox(
      height: 70,
      width: 500,
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.email,
                  size: 40,
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 16.0),
                child: Column(
                  children: [
                    Text(
                      '9:41 AM',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

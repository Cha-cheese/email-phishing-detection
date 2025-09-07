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
    FlSpot(10, 6),
  ];

  final List<Map<String, dynamic>> emailList = [
    {'title': 'Maha Settee', 'status': 'Risk', 'color': Colors.red},
    {'title': 'Thai Tour Partnership', 'status': 'No data', 'color': Colors.orange},
    {'title': 'Pipo Employment', 'status': 'No url', 'color': Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredEmails = emailList.where((email) => email['status'] == 'Risk').toList();

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
              opacity: 0.15,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.black.withOpacity(0.3),
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors.black.withOpacity(0.3),
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(color: Colors.black, fontSize: 12),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(color: Colors.black, fontSize: 12),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.black.withOpacity(0.5)),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: phishingData,
                          isCurved: true,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF42A5F5),
                              Color(0xFF478DE0),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          barWidth: 4,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF42A5F5).withOpacity(0.3),
                                const Color(0xFF478DE0).withOpacity(0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Colors.white,
                                strokeWidth: 2,
                                strokeColor: Colors.blueAccent,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: filteredEmails.map((email) {
                    return emailCard(
                      email['title'],
                      email['status'],
                      email['color'],
                    );
                  }).toList(),
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
            const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8.0),
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
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(top: 12.0, right: 16.0),
                child: Column(
                  children: [
                    Text('9:41 AM'),
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

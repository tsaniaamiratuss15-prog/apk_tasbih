import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class TrendPage extends StatefulWidget {
  const TrendPage({super.key});

  @override
  State<TrendPage> createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
  List data = [];

  Future getTrend() async {
    final response = await http.get(
      Uri.parse("http://localhost/go_tasbih_api/get_trend.php"),
    );

    setState(() {
      data = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getTrend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8EFE6),

      appBar: AppBar(
        backgroundColor: const Color(0xffE8EFE6),

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Tren Dzikir",

          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(height: 20),

                  Expanded(
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(show: false),

                        titlesData: FlTitlesData(
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),

                        barGroups: List.generate(data.length, (index) {
                          return BarChartGroupData(
                            x: index,

                            barRods: [
                              BarChartRodData(
                                toY: double.parse(data[index]['total_count']),

                                width: 30,
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// list data
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,

                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Text("${index + 1}"),

                            title: Text(data[index]['nama_dzikir']),

                            trailing: Text("${data[index]['total_count']}x"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

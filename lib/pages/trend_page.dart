import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
as http;
import 'package:shared_preferences/shared_preferences.dart';

class TrendPage
    extends StatefulWidget {

  const TrendPage({
    super.key,
  });

  @override
  State<TrendPage>
  createState() =>
      _TrendPageState();
}

class _TrendPageState
    extends State<
    TrendPage> {

  List trendData = [];

  bool isLoading =
      true;

  int totalDzikir =
      0;

  String hariAktif =
      "-";

  @override
  void initState() {
    super.initState();

    getTrend();
  }

  Future<void>
  getTrend() async {

    SharedPreferences
    prefs =
    await SharedPreferences
        .getInstance();

    int userId =
        prefs.getInt(
            'user_id') ??
            1;

    try {

      final response =
      await http.get(

        Uri.parse(
          "http://10.0.2.2:8000/api/trend/$userId",
        ),
      );

      final data =
      jsonDecode(
          response.body);

      int total =
      0;

      String bestDay =
          "-";

      int max =
      0;

      for (var item
      in data) {

        total +=
        item['total']
        as int;

        if (item[
        'total'] >
            max) {

          max =
          item[
          'total'];

          bestDay =
          item['day'];
        }
      }

      setState(() {

        trendData =
        data;

        totalDzikir =
        total;

        hariAktif =
        bestDay;

        isLoading =
        false;
      });

    } catch (e) {

      setState(() {
        isLoading =
        false;
      });
    }
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(
          0xffE8EFE6),

      appBar: AppBar(

        backgroundColor:
        const Color(
            0xff4F7C63),

        foregroundColor:
        Colors.white,

        title:
        const Text(
          "Tren Dzikir",
        ),

        centerTitle:
        true,
      ),

      body: isLoading

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : SingleChildScrollView(

        padding:
        const EdgeInsets
            .all(20),

        child: Column(

          children: [

            /// CARD SUMMARY
            Row(

              children: [

                Expanded(
                  child:
                  summaryCard(
                    "Total",
                    "$totalDzikir",
                    Icons
                        .mosque,
                  ),
                ),

                const SizedBox(
                    width:
                    14),

                Expanded(
                  child:
                  summaryCard(
                    "Hari Aktif",
                    hariAktif,
                    Icons
                        .local_fire_department,
                  ),
                ),
              ],
            ),

            const SizedBox(
                height:
                24),

            /// CHART CARD
            Container(

              padding:
              const EdgeInsets
                  .all(20),

              decoration:
              BoxDecoration(

                color:
                Colors.white,

                borderRadius:
                BorderRadius
                    .circular(
                    24),

                boxShadow: [

                  BoxShadow(
                    color:
                    Colors.black
                        .withOpacity(
                        .06),

                    blurRadius:
                    12,
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [

                  const Text(

                    "Intensitas Dzikir",
                    style:
                    TextStyle(
                      fontSize:
                      18,

                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),

                  const SizedBox(
                      height:
                      20),

                  SizedBox(

                    height:
                    280,

                    child:
                    BarChart(

                      BarChartData(

                        borderData:
                        FlBorderData(
                          show:
                          false,
                        ),

                        gridData:
                        FlGridData(
                          show:
                          true,
                        ),

                        titlesData:
                        FlTitlesData(

                          rightTitles:
                          const AxisTitles(
                            sideTitles:
                            SideTitles(
                              showTitles:
                              false,
                            ),
                          ),

                          topTitles:
                          const AxisTitles(
                            sideTitles:
                            SideTitles(
                              showTitles:
                              false,
                            ),
                          ),

                          leftTitles:
                          const AxisTitles(
                            sideTitles:
                            SideTitles(
                              showTitles:
                              true,
                            ),
                          ),

                          bottomTitles:
                          AxisTitles(

                            sideTitles:
                            SideTitles(

                              showTitles:
                              true,

                              getTitlesWidget:
                                  (
                                  value,
                                  meta,
                                  ) {

                                List days = [
                                  "Mon",
                                  "Tue",
                                  "Wed",
                                  "Thu",
                                  "Fri",
                                  "Sat",
                                  "Sun",
                                ];

                                return Text(
                                  days[
                                  value
                                      .toInt()],
                                );
                              },
                            ),
                          ),
                        ),

                        barGroups:
                        List.generate(

                          trendData
                              .length,

                              (
                              index,
                              ) {

                            return BarChartGroupData(

                              x:
                              index,

                              barRods: [

                                BarChartRodData(

                                  toY:
                                  trendData[index]
                                  ['total']
                                  .toDouble(),

                                  width:
                                  20,

                                  borderRadius:
                                  BorderRadius.circular(
                                      8),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryCard(
      String title,
      String value,
      IconData icon,
      ) {

    return Container(

      padding:
      const EdgeInsets
          .all(18),

      decoration:
      BoxDecoration(
        color:
        Colors.white,

        borderRadius:
        BorderRadius
            .circular(
            20),

        boxShadow: [

          BoxShadow(
            color:
            Colors.black
                .withOpacity(
                .05),

            blurRadius:
            8,
          ),
        ],
      ),

      child: Column(

        children: [

          Icon(
            icon,
            size: 34,
            color:
            const Color(
                0xff4F7C63),
          ),

          const SizedBox(
              height:
              10),

          Text(
            title,
            style:
            TextStyle(
              color:
              Colors
                  .grey
                  .shade600,
            ),
          ),

          const SizedBox(
              height:
              8),

          Text(
            value,

            style:
            const TextStyle(
              fontSize:
              22,

              fontWeight:
              FontWeight
                  .bold,
            ),
          ),
        ],
      ),
    );
  }
}
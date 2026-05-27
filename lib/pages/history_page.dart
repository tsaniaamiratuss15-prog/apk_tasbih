import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage
    extends StatefulWidget {

  const HistoryPage({
    super.key,
  });

  @override
  State<HistoryPage>
  createState() =>
      _HistoryPageState();
}

class _HistoryPageState
    extends State<
    HistoryPage> {

  List historyList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getHistory();
  }

  /// GET HISTORY
  Future<void>
  getHistory() async {

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
          "http://10.0.2.2:8000/api/history/$userId",
        ),
      );

      final data =
      jsonDecode(
          response.body);

      setState(() {

        historyList =
        data;

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
          "Riwayat Dzikir",
        ),

        centerTitle:
        true,
      ),

      body: isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )

          : historyList
          .isEmpty

          ? const Center(
        child: Text(
          "Belum ada riwayat dzikir",
        ),
      )

          : ListView.builder(

        padding:
        const EdgeInsets
            .all(16),

        itemCount:
        historyList.length,

        itemBuilder:
            (
            context,
            index,
            ) {

          final item =
          historyList[
          index];

          return buildHistoryCard(

            dzikir:
            item[
            'nama_dzikir'],

            jumlah:
            "${item['jumlah']} Kali",

            tanggal:
            item[
            'tanggal'],

            target:
            item[
            'target']
                .toString(),
          );
        },
      ),
    );
  }

  Widget
  buildHistoryCard({

    required String
    dzikir,

    required String
    jumlah,

    required String
    tanggal,

    required String
    target,
  }) {

    return Container(

      margin:
      const EdgeInsets.only(
          bottom: 14),

      padding:
      const EdgeInsets.all(
          16),

      decoration:
      BoxDecoration(
        color:
        Colors.white,

        borderRadius:
        BorderRadius
            .circular(
            18),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black
                .withOpacity(
                0.06),

            blurRadius:
            8,
          ),
        ],
      ),

      child: Row(

        children: [

          Container(

            width: 52,
            height: 52,

            decoration:
            BoxDecoration(

              color:
              const Color(
                  0xff4F7C63)
                  .withOpacity(
                  0.15),

              borderRadius:
              BorderRadius
                  .circular(
                  14),
            ),

            child:
            const Icon(
              Icons
                  .mosque,

              color:
              Color(
                  0xff4F7C63),
            ),
          ),

          const SizedBox(
              width: 14),

          Expanded(

            child:
            Column(

              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [

                Text(

                  dzikir,

                  style:
                  const TextStyle(
                    fontSize:
                    16,

                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),

                const SizedBox(
                    height:
                    4),

                Text(
                  jumlah,
                  style:
                  TextStyle(
                    color:
                    Colors
                        .grey
                        .shade700,
                  ),
                ),

                const SizedBox(
                    height:
                    4),

                Text(
                  "Target: $target",

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
                    4),

                Text(
                  tanggal,

                  style:
                  TextStyle(
                    color:
                    Colors
                        .grey
                        .shade500,

                    fontSize:
                    12,
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
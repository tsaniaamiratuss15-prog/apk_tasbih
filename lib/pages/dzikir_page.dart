import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DzikirPage extends StatefulWidget {
  const DzikirPage({super.key});

  @override
  State<DzikirPage> createState() =>
      _DzikirPageState();
}

class _DzikirPageState
    extends State<DzikirPage> {
  int counter = 0;
  int target = 0;

  final AudioPlayer
      audioPlayer =
      AudioPlayer();

  final TextEditingController
      customController =
      TextEditingController();

  String selectedDzikir =
      "Subhanallah";

  final Map<String, String>
      dzikirList = {
    "Subhanallah":
        "Maha Suci Allah",
    "Alhamdulillah":
        "Segala Puji Bagi Allah",
    "Allahu Akbar":
        "Allah Maha Besar",
    "Astaghfirullah":
        "Aku memohon ampun kepada Allah",
  };

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {
        showTargetDialog();
      },
    );
  }

  /// SAVE HISTORY
  Future<void> saveHistory()
  async {
    SharedPreferences
        prefs =
        await SharedPreferences
            .getInstance();

    int userId =
        prefs.getInt(
                'user_id') ??
            1;

    await http.post(
      Uri.parse(
        "http://10.0.2.2:8000/api/history",
      ),
      body: {
        "user_id":
            userId.toString(),
        "nama_dzikir":
            selectedDzikir,
        "target":
            target.toString(),
        "jumlah":
            counter.toString(),
        "tanggal":
            DateTime.now()
                .toString()
                .split(
                    ' ')[0],
      },
    );
  }

  void showTargetDialog() {
    showDialog(

      context: context,

      barrierDismissible:
      false,

      builder: (context) {

        return AlertDialog(

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
                20),
          ),

          title: Row(

            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

            children: [

              const Text(
                "Pilih Target Dzikir",
              ),

              GestureDetector(

                onTap: () {

                  Navigator.pop(
                      context);

                  Navigator.pop(
                      this.context);
                },

                child:
                const Icon(
                  Icons.close,
                  size: 24,
                ),
              ),
            ],
          ),

          content: Column(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              targetButton(
                  33),

              targetButton(
                  99),

              targetButton(
                  1000),

              const SizedBox(
                  height: 10),

              SizedBox(
                width:
                double.infinity,

                child:
                ElevatedButton(

                  onPressed:
                      () {

                    Navigator.pop(
                        context);

                    showCustomDialog();
                  },

                  child:
                  const Text(
                    "Custom",
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget targetButton(
      int value) {
    return Padding(
      padding:
          const EdgeInsets
              .only(
                  bottom:
                      8),
      child: SizedBox(
        width: double.infinity,
        child:
            ElevatedButton(
          onPressed:
              () {
            if (value <
                counter) {
              ScaffoldMessenger
                      .of(
                          context)
                  .showSnackBar(
                const SnackBar(
                  content:
                      Text(
                    "Target tidak boleh lebih kecil dari progress dzikir",
                  ),
                ),
              );

              return;
            }

            setState(() {
              target =
                  value;
            });

            Navigator.pop(
                context);
          },
          child: Text(
            "$value Kali",
          ),
        ),
      ),
    );
  }

  /// CUSTOM TARGET
  void showCustomDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false,
      builder: (context) {
        return AlertDialog(
          title:
              const Text(
            "Masukkan Target",
          ),
          content:
              TextField(
            controller:
                customController,
            keyboardType:
                TextInputType
                    .number,
            decoration:
                const InputDecoration(
              hintText:
                  "Contoh: 200",
            ),
          ),
          actions: [
            TextButton(
              onPressed:
                  () {
                int custom =
                    int.tryParse(
                            customController.text) ??
                        0;

                if (custom <
                    counter) {
                  ScaffoldMessenger
                          .of(
                              context)
                      .showSnackBar(
                    const SnackBar(
                      content:
                          Text(
                        "Target tidak boleh lebih kecil dari progress",
                      ),
                    ),
                  );

                  return;
                }

                setState(() {
                  target =
                      custom;
                });

                Navigator.pop(
                    context);
              },
              child:
                  const Text(
                "Simpan",
              ),
            )
          ],
        );
      },
    );
  }

  /// TAP
  Future<void>
      incrementCounter()
  async {
    if (target == 0) {
      return;
    }

    setState(() {
      counter++;
    });

    if (counter >=
        target) {
      await audioPlayer
          .play(
        AssetSource(
          'audio/success.mp3',
        ),
      );

      showCompletedDialog();
    }
  }

  /// TARGET DONE
  void showCompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false,
      builder: (context) {
        return AlertDialog(
          title:
              const Text(
            "Alhamdulillah 🎉",
          ),
          content: Text(
            "Target dzikir $target kali telah terpenuhi.",
          ),
          actions: [
            TextButton(
              onPressed:
                  () {
                Navigator.pop(
                    context);

                showTargetDialog();
              },
              child:
                  const Text(
                "Lanjut",
              ),
            ),
            ElevatedButton(
              onPressed:
                  () async {
                await saveHistory();

                if (!mounted)
                  return;

                Navigator.pop(
                    context);

                Navigator.pop(
                    context);
              },
              child:
                  const Text(
                "Simpan",
              ),
            ),
          ],
        );
      },
    );
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(
              0xffE8EFE6),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets
                  .all(20),

          child:
              SingleChildScrollView(
            child:
                Column(
              children: [
                /// HEADER
                Row(
                  children: [
                    IconButton(
                      onPressed:
                          () {
                        Navigator.pop(
                            context);
                      },
                      icon:
                          const Icon(
                        Icons
                            .arrow_back,
                      ),
                    ),

                    const Spacer(),

                    const Text(
                      "Dzikir",
                      style:
                          TextStyle(
                        fontSize:
                            22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const Spacer(),
                  ],
                ),

                const SizedBox(
                    height:
                        20),

                /// DROPDOWN
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal:
                        16,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),

                  child:
                      DropdownButtonHideUnderline(
                    child:
                        DropdownButton<
                            String>(
                      value:
                          selectedDzikir,
                      isExpanded:
                          true,

                      items:
                          dzikirList.keys
                              .map(
                        (dzikir) {
                          return DropdownMenuItem(
                            value:
                                dzikir,
                            child:
                                Text(
                              dzikir,
                            ),
                          );
                        },
                      ).toList(),

                      onChanged:
                          (value) {
                        setState(
                            () {
                          selectedDzikir =
                              value!;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(
                    height:
                        20),

                /// TARGET CARD
                Container(
                  width:
                      double.infinity,

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal:
                        20,
                    vertical:
                        18,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                            26),

                    boxShadow: [
                      BoxShadow(
                        color: Colors
                            .black
                            .withOpacity(
                                .06),

                        blurRadius:
                            18,

                        offset:
                            const Offset(
                                0,
                                8),
                      ),
                    ],
                  ),

                  child:
                      Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.all(
                                        8),

                                decoration:
                                    BoxDecoration(
                                  color:
                                      const Color(
                                              0xff4F7C63)
                                          .withOpacity(
                                              .12),

                                  borderRadius:
                                      BorderRadius.circular(
                                          12),
                                ),

                                child:
                                    const Icon(
                                  Icons
                                      .flag,
                                  color:
                                      Color(
                                          0xff4F7C63),
                                ),
                              ),

                              const SizedBox(
                                  width:
                                      10),

                              const Text(
                                "Target Dzikir",
                                style:
                                    TextStyle(
                                  fontSize:
                                      16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          GestureDetector(
                            onTap:
                                showTargetDialog,

                            child:
                                Container(
                              padding:
                                  const EdgeInsets.all(
                                      8),

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                            0xff4F7C63)
                                        .withOpacity(
                                            .12),

                                borderRadius:
                                    BorderRadius.circular(
                                        12),
                              ),

                              child:
                                  const Icon(
                                Icons
                                    .edit,
                                size:
                                    20,
                                color:
                                    Color(
                                        0xff4F7C63),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height:
                              18),

                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(
                                100),

                        child:
                            LinearProgressIndicator(
                          value:
                              target ==
                                      0
                                  ? 0
                                  : counter /
                                      target,

                          minHeight:
                              12,
                        ),
                      ),

                      const SizedBox(
                          height:
                              12),

                      Text(
                        "$counter dari $target dzikir",
                        style:
                            TextStyle(
                          fontSize:
                              16,
                          fontWeight:
                              FontWeight.w600,
                          color:
                              Colors.grey.shade800,
                        ),
                      ),

                      const SizedBox(
                          height:
                              4),

                      Text(
                        "${target == 0 ? 0 : ((counter / target) * 100).toInt()}% selesai",
                        style:
                            const TextStyle(
                          fontSize:
                              13,
                          color:
                              Color(
                                  0xff4F7C63),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height:
                        35),

                /// BUTTON TAP
Opacity(

  opacity:
  (target > 0 &&
      counter >=
          target)
      ? 0.45
      : 1,

  child:
  IgnorePointer(

    ignoring:
    target > 0 &&
        counter >=
            target,

    child:
    GestureDetector(

      onTap:
      incrementCounter,

      child:
      AnimatedContainer(

        duration:
        const Duration(
            milliseconds:
            250),

        width: 220,
        height: 220,

        decoration:
        BoxDecoration(

          shape:
          BoxShape.circle,

          gradient:
          const LinearGradient(
            colors: [
              Color(
                  0xff8BC59B),
              Color(
                  0xff4F7C63),
            ],
          ),

          boxShadow: [

            BoxShadow(
              color:
              const Color(
                  0xff4F7C63)
                  .withOpacity(
                  .35),

              blurRadius:
              28,

              offset:
              const Offset(
                  0, 12),
            ),
          ],
        ),

        child:
        Column(

          mainAxisAlignment:
          MainAxisAlignment
              .center,

          children: [

            Text(
              "$counter",

              style:
              const TextStyle(
                fontSize:
                52,

                color:
                Colors.white,

                fontWeight:
                FontWeight
                    .bold,
              ),
            ),

            const Text(
              "TAP",

              style:
              TextStyle(
                color:
                Colors.white,

                fontSize:
                16,

                letterSpacing:
                2,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),

                const SizedBox(
                    height:
                        30),

                SizedBox(
                  width:
                      double.infinity,

                  child:
                      ElevatedButton.icon(
                    onPressed:
                        resetCounter,

                    icon:
                        const Icon(
                      Icons.refresh,
                    ),

                    label:
                        const Text(
                      "Reset",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
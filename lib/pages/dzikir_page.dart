import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DzikirPage extends StatefulWidget {
  const DzikirPage({super.key});

  @override
  State<DzikirPage> createState() => _DzikirPageState();
}

class _DzikirPageState extends State<DzikirPage> {
  int counter = 0;

  Map<String, String> dzikirList = {
    "Subhanallah": "Maha Suci Allah",
    "Alhamdulillah": "Segala Puji Bagi Allah",
    "Allahu Akbar": "Allah Maha Besar",
    "Astaghfirullah": "Aku memohon ampun kepada Allah",
  };

  String selectedDzikir = "Subhanallah";

  /// kirim data ke database
  Future<void> updateTrend() async {
    await http.post(
      Uri.parse("http://127.0.0.1/go_tasbih_api/update_dzikir.php"),

      body: {"nama_dzikir": selectedDzikir},
    );
  }

  /// tambah counter
  void incrementCounter() {
    setState(() {
      counter++;
    });

    updateTrend();
  }

  /// reset counter
  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8EFE6),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              /// header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),

                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Spacer(),

                  const Text(
                    "Dzikir",

                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const Spacer(),
                ],
              ),

              const SizedBox(height: 20),

              /// dropdown dzikir
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(16),
                ),

                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedDzikir,

                    isExpanded: true,

                    items: dzikirList.keys.map((String dzikir) {
                      return DropdownMenuItem(
                        value: dzikir,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              dzikir,

                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              dzikirList[dzikir]!,

                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedDzikir = value!;
                        counter = 0;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 60),

              /// tombol counter
              GestureDetector(
                onTap: incrementCounter,

                child: Container(
                  width: 220,
                  height: 220,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    gradient: const LinearGradient(
                      colors: [Color(0xff7FAF8B), Color(0xff4F7C63)],

                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(.3),

                        blurRadius: 20,
                      ),
                    ],
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "$counter",

                        style: const TextStyle(
                          fontSize: 44,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        "TAP",

                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// tombol reset
              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: resetCounter,

                  icon: const Icon(Icons.refresh),

                  label: const Text("Reset"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

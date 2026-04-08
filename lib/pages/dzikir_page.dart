import 'package:flutter/material.dart';

class DzikirPage extends StatefulWidget {
  const DzikirPage({super.key});

  @override
  State<DzikirPage> createState() => _DzikirPageState();
}

class _DzikirPageState extends State<DzikirPage> {
  int counter = 0;
  int target = 33;

  void incrementCounter() {
    if (counter < target) {
      setState(() {
        counter++;
      });
    }
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  void changeTarget(int newTarget) {
    setState(() {
      target = newTarget;
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dzikir"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// teks dzikir
            const SizedBox(height: 20),

            const Text(
              "Subhanallah",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              "Maha Suci Allah",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 40),

            /// tombol counter
            GestureDetector(
              onTap: incrementCounter,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green[400],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade200,
                      blurRadius: 20,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        "$counter",
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "TAP",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// pilihan target dzikir
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                targetButton(33),
                targetButton(100),
                targetButton(1000),

              ],
            ),

            const SizedBox(height: 20),

            /// reset button
            ElevatedButton.icon(
              onPressed: resetCounter,
              icon: const Icon(Icons.refresh),
              label: const Text("Reset"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// widget tombol target
  Widget targetButton(int value) {
    return ElevatedButton(
      onPressed: () => changeTarget(value),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            target == value ? Colors.green : Colors.grey[300],
        foregroundColor:
            target == value ? Colors.white : Colors.black,
      ),
      child: Text("$value"),
    );
  }
}
import 'package:flutter/material.dart';

class DoaPage extends StatelessWidget {
  const DoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xffE8EFE6),
          ),

          /// CONTENT
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text(
                          "Kumpulan Doa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                /// LIST DOA
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: const [
                      DoaItem(
                        title: "1. Doa Sebelum Makan",
                        image: "assets/images/1doa_sebelum_makan.jpeg",
                        latin:
                            "Allahumma barik lana fi ma razaqtana wa qina adzaban nar, bismillah.",
                        arti:
                            "Ya Allah, berkahilah kami pada apa yang telah Engkau karuniakan dan lindungilah kami dari siksa neraka. Bismillah.",
                      ),

                      DoaItem(
                        title: "2. Doa Bangun Tidur",
                        image: "assets/images/4doa_bangun_tidur.jpeg",
                        latin:
                            "Alhamdulillahil ladzi ahyana ba’da ma amatana wa ilaihin nushur.",
                        arti:
                            "Segala puji bagi Allah yang telah menghidupkan kami setelah mematikan kami, dan kepada-Nya kami dibangkitkan.",
                      ),

                      DoaItem(
                        title: "3. Doa Sebelum Tidur",
                        image: "assets/images/3doa_sebelum_tidur.jpeg",
                        latin: "Bismika Allahumma ahya wa amut.",
                        arti: "Dengan nama-Mu ya Allah aku hidup dan aku mati.",
                      ),

                      DoaItem(
                        title: "4. Doa Sesudah Makan",
                        image: "assets/images/2doa_setelah_makan.jpeg",
                        latin:
                            "Alhamdulillahil ladzi ath’amana wa saqana wa ja’alana minal muslimin.",
                        arti:
                            "Segala puji bagi Allah yang telah memberi kami makan dan minum serta menjadikan kami termasuk orang-orang muslim.",
                      ),

                      DoaItem(
                        title: "5. Doa Keluar Rumah",
                        image: "assets/images/5doa_keluar_rumah.jpeg",
                        latin:
                            "Bismillahi tawakkaltu ‘alallah, laa haula wa laa quwwata illa billah.",
                        arti:
                            "Dengan nama Allah aku bertawakal kepada Allah, tiada daya dan kekuatan kecuali dengan pertolongan Allah.",
                      ),
                    ],
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

class DoaItem extends StatelessWidget {
  final String title;
  final String image;
  final String latin;
  final String arti;

  const DoaItem({
    super.key,
    required this.title,
    required this.image,
    required this.latin,
    required this.arti,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          /// ARAB (IMAGE)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(image),
          ),

          const SizedBox(height: 12),

          /// LATIN
          Text(
            latin,
            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
          ),

          const SizedBox(height: 8),

          /// ARTI
          Text("Artinya: $arti", style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

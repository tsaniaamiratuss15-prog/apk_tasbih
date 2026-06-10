import 'package:flutter/material.dart';

class DoaPage extends StatelessWidget {
  const DoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xffE8EFE6)),

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

                      DoaItem(
                        title: "6. Doa Pagi Hari",
                        image: "assets/images/6doa_pagi_hari.jpg",
                        latin:
                            "Allahumma bika ashbahnaa wa bika amsainaa wa bika nahyaa wa bika namuutu wa ilaikan nusyuuru.",
                        arti:
                            "Ya Allah, karena Engkau kami mengalami waktu pagi dan waktu petang, dan karena Engkau kami hidup dan mati dan kepada-Mu juga kami akan kembali.",
                      ),

                      DoaItem(
                        title: "7. Doa Sebelum Beraktivitas",
                        image: "assets/images/7doa_sebelum_beraktifitas.jpg",
                        latin:
                            "Rabbana atina min ladunka rahmatan, wa hayyi' lana min amrina rasyadan, rabbisyrah li shadri, wa yassir li amri.",
                        arti:
                            "Wahai Tuhan kami, berikanlah rahmat kepada kami dari sisi-Mu dan sempurnakanlah bagi kami petunjuk yang lurus dalam urusan kami ini. Ya Tuhanku, lapangkanlah untukku dadaku dan mudahkanlah untukku urusanku.",
                      ),

                      DoaItem(
                        title: "8. Doa Ketika Bercermin",
                        image: "assets/images/8doa_ketika_bercermin.jpg",
                        latin:
                            "Allahumma kama hassanta khalqi fahassin khuluqi.",
                        arti:
                            "Wahai Allah, sebagaimana telah Kau baguskan kejadianku, maka baguskanlah perangai dan akhlakku.",
                      ),

                      DoaItem(
                        title: "9. Doa Naik Kendaraan",
                        image: "assets/images/9doa_naik_kendaraan.jpg",
                        latin:
                            "Bismillaahi majrahaa wa mursaahaa inna robbii laghofuurur rohiim.",
                        arti:
                            "Dengan nama Allah yang menjalankan kendaraan ini berlayar dan berlabuh, sesungguhnya Tuhanku benar-benar Maha Pengampun lagi Maha Penyayang.",
                      ),

                      DoaItem(
                        title: "10. Doa Kelancaran Berbicara",
                        image: "assets/images/10doa_kelancaran_berbicara.jpg",
                        latin:
                            "Robbis rohlii shodrii, wa yassirlii amrii, wahlul 'uqdatam mil lisaanii yafqohu qoulii.",
                        arti:
                            "Ya Rabbku, lapangkanlah untukku dadaku, mudahkanlah urusanku, dan lepaskanlah kekakuan dari lidahku supaya mereka mengerti perkataanku.",
                      ),

                      DoaItem(
                        title: "11. Doa Sebelum Belajar",
                        image: "assets/images/11doa_sebelum_belajar.jpg",
                        latin: "Yaarobbi zidnii 'ilman warzuqnii fahmaa.",
                        arti:
                            "Ya Allah, tambahkanlah aku ilmu dan berikanlah aku rezeki berupa pemahaman.",
                      ),

                      DoaItem(
                        title: "12. Doa Kedua Orang Tua",
                        image: "assets/images/12doa_kedua_orangtua.jpg",
                        latin:
                            "Allohummaghfirlii waliwaalidayya warhamhumaa kamaa rabbayaanii shaghiraa.",
                        arti:
                            "Wahai Tuhanku, ampunilah aku dan kedua orang tuaku (ibu dan bapakku), serta sayangilah mereka sebagaimana mereka menyayangiku di waktu kecil.",
                      ),

                      DoaItem(
                        title: "13. Doa Turun Hujan",
                        image: "assets/images/13doa_turun_hujan.jpg",
                        latin:
                            "Allahumma shayyiban haniyyan wa shayyiban nafi'an.",
                        arti:
                            "Wahai Tuhanku, jadikan hujan ini hujan yang baik dan membawa manfaat.",
                      ),

                      DoaItem(
                        title: "14. Doa Niat Puasa Ramadhan",
                        image: "assets/images/14doa_niat_puasa_ramadhan.jpg",
                        latin:
                            "Nawaitu shauma ghadin 'an ada'i fardhi syahri Ramadhana hadzihis sanati lillahi ta'ala.",
                        arti:
                            "Aku niat berpuasa esok hari untuk menunaikan kewajiban puasa bulan Ramadhan tahun ini karena Allah Ta'ala.",
                      ),

                      DoaItem(
                        title: "15. Doa Selamat Dunia Akhirat",
                        image: "assets/images/15doa_selamat_dunia_akhirat.jpg",
                        latin:
                            "Rabbanaa aatinaa fid dunyaa hasanah, wa fil aakhirati hasanah, wa qinaa 'adzaaban naar.",
                        arti:
                            "Tuhan kami, berikan kami kebaikan di dunia dan kebaikan di akhirat. Lindungilah kami dari siksa neraka.",
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

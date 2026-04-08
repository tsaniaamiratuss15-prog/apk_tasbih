import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [

          /// background image
          SizedBox.expand(
            child: Image.asset(
              "assets/images/bg_home.png",
              fit: BoxFit.cover,
            ),
          ),

          /// content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),

              child: Column(
                children: [

                  const SizedBox(height: 80),

                  /// title
                  Image.asset(
                    "assets/images/judul.png",
                    height: 80,
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Dzikir dan Doa Harian",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),

                  const SizedBox(height: 140),

                  /// tombol dzikir
                  menuCard(
                    context,
                    title: "Dzikir",
                    route: AppRoutes.dzikir,
                  ),

                  const SizedBox(height: 20),

                  /// tombol doa
                  menuCard(
                    context,
                    title: "Doa",
                    route: AppRoutes.doa,
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  /// reusable card button
  Widget menuCard(
      BuildContext context,
      {
        required String title,
        required String route,
      }) {

    return GestureDetector(

      onTap: () {
        Navigator.pushNamed(context, route);
      },

      child: Container(

        width: double.infinity,
        height: 70,

        decoration: BoxDecoration(

          color: Colors.white.withOpacity(0.9),

          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(2, 2),
            )
          ],
        ),

        alignment: Alignment.centerLeft,

        padding: const EdgeInsets.symmetric(horizontal: 24),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Icon(Icons.arrow_forward_ios),

          ],
        ),
      ),
    );
  }
}
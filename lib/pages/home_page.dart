import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> logout(
    BuildContext context,
  ) async {
    SharedPreferences prefs =
        await SharedPreferences
            .getInstance();

    await prefs.clear();

    if (!context.mounted)
      return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [

          /// background
          SizedBox.expand(
            child: Image.asset(
              "assets/images/bg_home.png",
              fit: BoxFit.cover,
            ),
          ),

          /// content
          SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: Column(
                children: [

                  const SizedBox(
                    height: 80,
                  ),

                  /// title
                  Image.asset(
                    "assets/images/judul.png",
                    height: 80,
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  const Text(
                    "Dzikir dan Doa Harian",
                    style: TextStyle(
                      fontSize: 16,
                      color:
                      Colors.white,
                    ),
                  ),

                  const SizedBox(
                    height: 120,
                  ),

                  /// dzikir
                  menuCard(
                    context,
                    title:
                    "Dzikir",
                    icon:
                    Icons
                        .mosque_outlined,
                    route:
                    AppRoutes
                        .dzikir,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  /// doa
                  menuCard(
                    context,
                    title:
                    "Doa",
                    icon:
                    Icons
                        .menu_book_outlined,
                    route:
                    AppRoutes
                        .doa,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  /// trend
                  menuCard(
                    context,
                    title:
                    "Tren Dzikir",
                    icon:
                    Icons
                        .bar_chart_rounded,
                    route:
                    AppRoutes
                        .trend,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  /// history
                  menuCard(
                    context,
                    title:
                    "Riwayat Dzikir",
                    icon:
                    Icons.history,
                    route:
                    AppRoutes
                        .history,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  /// logout
                  menuCard(
                    context,
                    title:
                    "Logout",
                    icon:
                    Icons.logout,

                    onTap:
                        () async {

                      bool? confirm =
                      await showDialog(

                        context:
                        context,

                        builder:
                            (_) {

                          return AlertDialog(

                            title:
                            const Text(
                              "Logout",
                            ),

                            content:
                            const Text(
                              "Yakin ingin keluar akun?",
                            ),

                            actions: [

                              TextButton(

                                onPressed:
                                    () {

                                  Navigator.pop(
                                    context,
                                    false,
                                  );
                                },

                                child:
                                const Text(
                                  "Batal",
                                ),
                              ),

                              ElevatedButton(

                                onPressed:
                                    () {

                                  Navigator.pop(
                                    context,
                                    true,
                                  );
                                },

                                child:
                                const Text(
                                  "Logout",
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirm ==
                          true) {

                        logout(
                            context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// reusable menu card
  Widget menuCard(
    BuildContext context, {

    required String title,

    required IconData icon,

    String? route,

    VoidCallback? onTap,
  }) {

    return GestureDetector(

      onTap: () {

        if (onTap !=
            null) {

          onTap();

        } else if
        (route !=
            null) {

          Navigator.pushNamed(
            context,
            route,
          );
        }
      },

      child: Container(

        width:
        double.infinity,

        height: 72,

        decoration:
        BoxDecoration(

          color:
          Colors.white
              .withOpacity(
              0.92),

          borderRadius:
          BorderRadius.circular(
              22),

          boxShadow: [

            BoxShadow(
              color:
              Colors.black
                  .withOpacity(
                  .08),

              blurRadius:
              10,

              offset:
              const Offset(
                  0, 4),
            ),
          ],
        ),

        padding:
        const EdgeInsets.symmetric(
          horizontal: 22,
        ),

        child: Row(
          children: [

            Container(

              width: 48,
              height: 48,

              decoration:
              BoxDecoration(

                color:
                const Color(
                    0xff4F7C63)
                    .withOpacity(
                    .12),

                borderRadius:
                BorderRadius
                    .circular(
                    14),
              ),

              child: Icon(
                icon,

                color:
                const Color(
                    0xff4F7C63),
              ),
            ),

            const SizedBox(
                width: 16),

            Expanded(
              child: Text(
                title,

                style:
                const TextStyle(
                  fontSize:
                  18,

                  fontWeight:
                  FontWeight
                      .w600,
                ),
              ),
            ),

            const Icon(
              Icons
                  .arrow_forward_ios,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
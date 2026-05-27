import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

  bool obscurePassword = true;
  bool obscureConfirmPassword =
      true;

  // CONTROLLER
  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6B9B7A),
              Color(0xffE8EFE6),
            ],
            begin:
            Alignment.topCenter,
            end:
            Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(

          child: Center(

            child:
            SingleChildScrollView(

              padding:
              const EdgeInsets.symmetric(
                  horizontal: 24),

              child: Container(

                padding:
                const EdgeInsets.all(
                    28),

                decoration:
                BoxDecoration(
                  color:
                  Colors.white
                      .withOpacity(
                      .95),

                  borderRadius:
                  BorderRadius
                      .circular(
                      30),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black
                          .withOpacity(
                          .08),

                      blurRadius:
                      20,

                      offset:
                      const Offset(
                          0,
                          8),
                    )
                  ],
                ),

                child: Column(

                  children: [

                    Image.asset(
                      "assets/images/logo2.png",
                      height: 90,
                    ),

                    const SizedBox(
                        height: 20),

                    const Text(
                      "Daftar Akun",
                      style:
                      TextStyle(
                        fontSize:
                        28,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),

                    const SizedBox(
                        height: 8),

                    Text(
                      "Daftar untuk mulai menggunakan aplikasi",
                      textAlign:
                      TextAlign
                          .center,
                      style:
                      TextStyle(
                        color:
                        Colors.grey
                            .shade600,
                      ),
                    ),

                    const SizedBox(
                        height: 30),

                    // NAMA
                    buildField(
                      controller:
                      nameController,
                      hint:
                      "Nama Lengkap",
                      icon:
                      Icons
                          .person_outline,
                    ),

                    const SizedBox(
                        height: 16),

                    // EMAIL
                    buildField(
                      controller:
                      emailController,
                      hint:
                      "Email",
                      icon:
                      Icons
                          .email_outlined,
                    ),

                    const SizedBox(
                        height: 16),

                    // PASSWORD
                    TextField(

                      controller:
                      passwordController,

                      obscureText:
                      obscurePassword,

                      decoration:
                      InputDecoration(
                        hintText:
                        "Password",

                        prefixIcon:
                        const Icon(
                          Icons
                              .lock_outline,
                        ),

                        suffixIcon:
                        IconButton(
                          icon:
                          Icon(
                            obscurePassword
                                ? Icons
                                .visibility_off
                                : Icons
                                .visibility,
                          ),

                          onPressed:
                              () {

                            setState(
                                    () {

                                  obscurePassword =
                                  !obscurePassword;
                                });
                          },
                        ),

                        filled:
                        true,

                        fillColor:
                        const Color(
                            0xffF4F6F5),

                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                              18),

                          borderSide:
                          BorderSide
                              .none,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 16),

                    // KONFIRMASI PASSWORD
                    TextField(

                      controller:
                      confirmPasswordController,

                      obscureText:
                      obscureConfirmPassword,

                      decoration:
                      InputDecoration(
                        hintText:
                        "Konfirmasi Password",

                        prefixIcon:
                        const Icon(
                          Icons
                              .lock_outline,
                        ),

                        suffixIcon:
                        IconButton(
                          icon:
                          Icon(
                            obscureConfirmPassword
                                ? Icons
                                .visibility_off
                                : Icons
                                .visibility,
                          ),

                          onPressed:
                              () {

                            setState(
                                    () {

                                  obscureConfirmPassword =
                                  !obscureConfirmPassword;
                                });
                          },
                        ),

                        filled:
                        true,

                        fillColor:
                        const Color(
                            0xffF4F6F5),

                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                              18),

                          borderSide:
                          BorderSide
                              .none,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 28),

                    // BUTTON REGISTER
                    SizedBox(
                      width:
                      double.infinity,
                      height: 58,

                      child:
                      ElevatedButton(

                        onPressed:
                            () async {

                          // VALIDASI PASSWORD
                          if (passwordController
                              .text !=
                              confirmPasswordController
                                  .text) {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content:
                                Text(
                                  "Password tidak sama",
                                ),
                              ),
                            );

                            return;
                          }

                          final response =
                          await AuthService
                              .register(

                            name:
                            nameController
                                .text,

                            email:
                            emailController
                                .text,

                            password:
                            passwordController
                                .text,
                          );

                          if (response[
                          'message'] ==
                              'Register berhasil') {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content:
                                Text(
                                  "Register berhasil",
                                ),
                              ),
                            );

                            Navigator.pop(
                                context);

                          } else {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content:
                                Text(
                                  "Register gagal",
                                ),
                              ),
                            );
                          }
                        },

                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          const Color(
                              0xff4F7C63),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                                18),
                          ),
                        ),

                        child:
                        const Text(
                          "Register",
                          style:
                          TextStyle(
                            fontSize:
                            18,
                            color:
                            Colors
                                .white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    // LOGIN
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                      children: [

                        const Text(
                          "Sudah punya akun? ",
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context);
                          },

                          child:
                          const Text(
                            "Masuk",
                            style:
                            TextStyle(
                              color:
                              Color(
                                  0xff4F7C63),

                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField({
    required TextEditingController
    controller,

    required String hint,

    required IconData icon,
  }) {

    return TextField(

      controller:
      controller,

      decoration:
      InputDecoration(
        hintText: hint,

        prefixIcon:
        Icon(icon),

        filled: true,

        fillColor:
        const Color(
            0xffF4F6F5),

        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(
              18),

          borderSide:
          BorderSide.none,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool obscurePassword =
      true;

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      body: Container(

        decoration:
        const BoxDecoration(
          gradient:
          LinearGradient(
            colors: [
              Color(
                  0xff6B9B7A),
              Color(
                  0xffE8EFE6),
            ],
            begin:
            Alignment
                .topCenter,
            end:
            Alignment
                .bottomCenter,
          ),
        ),

        child: SafeArea(

          child: Center(

            child:
            SingleChildScrollView(

              padding:
              const EdgeInsets
                  .symmetric(
                  horizontal:
                  24),

              child: Container(

                padding:
                const EdgeInsets
                    .all(28),

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
                    ),
                  ],
                ),

                child: Column(

                  children: [

                    /// LOGO
                    Image.asset(
                      "assets/images/logo2.png",
                      height: 80,
                    ),

                    const SizedBox(
                        height:
                        20),

                    const Text(
                      "Selamat Datang",
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
                        height:
                        8),

                    Text(
                      "Masuk untuk melanjutkan",
                      style:
                      TextStyle(
                        fontSize:
                        15,
                        color:
                        Colors
                            .grey
                            .shade600,
                      ),
                    ),

                    const SizedBox(
                        height:
                        30),

                    /// EMAIL
                    TextField(
                      controller:
                      emailController,

                      decoration:
                      InputDecoration(
                        hintText:
                        "Email",

                        prefixIcon:
                        const Icon(
                          Icons
                              .email_outlined,
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
                        height:
                        18),

                    /// PASSWORD
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
                        height:
                        28),

                    /// BUTTON LOGIN
                    SizedBox(

                      width:
                      double.infinity,

                      height:
                      58,

                      child:
                      ElevatedButton(

                        onPressed:
                            () async {

                          final response =
                          await AuthService
                              .login(

                            email:
                            emailController
                                .text,

                            password:
                            passwordController
                                .text,
                          );

                          if (response
                              .containsKey(
                              'token')) {

                            SharedPreferences
                            prefs =
                            await SharedPreferences
                                .getInstance();

                            /// save login
                            await prefs
                                .setString(
                              'token',
                              response[
                              'token'],
                            );

                            await prefs
                                .setInt(
                              'user_id',
                              response[
                              'user']['id'],
                            );

                            await prefs
                                .setString(
                              'name',
                              response[
                              'user']['name'],
                            );

                            await prefs
                                .setString(
                              'email',
                              response[
                              'user']
                              ['email'],
                            );

                            if (!context
                                .mounted) {
                              return;
                            }

                            ScaffoldMessenger
                                .of(
                              context,
                            )
                                .showSnackBar(
                              const SnackBar(
                                content:
                                Text(
                                  "Login berhasil",
                                ),
                              ),
                            );

                            Navigator
                                .pushReplacementNamed(
                              context,
                              AppRoutes
                                  .home,
                            );

                          } else {

                            ScaffoldMessenger
                                .of(
                              context,
                            )
                                .showSnackBar(
                              SnackBar(
                                content:
                                Text(
                                  response[
                                  'message'] ??
                                      "Login gagal",
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
                          "Login",
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
                        height:
                        20),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                      children: [

                        const Text(
                          "Belum punya akun?",
                        ),

                        TextButton(

                          onPressed:
                              () {

                            Navigator
                                .pushNamed(
                              context,
                              AppRoutes
                                  .register,
                            );
                          },

                          child:
                          const Text(
                            "Daftar",

                            style:
                            TextStyle(
                              fontWeight:
                              FontWeight
                                  .bold,

                              color:
                              Color(
                                  0xff4F7C63),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
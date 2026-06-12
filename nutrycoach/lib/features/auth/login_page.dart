import 'package:flutter/material.dart';

import '../dashboard/dashboard_page.dart';
import 'auth_service.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final _authService =
      AuthService();

  bool loading = false;

  Future<void> login() async {

    try {

      setState(() {
        loading = true;
      });

      await _authService.signIn(
        email:
            _emailController.text.trim(),
        password:
            _passwordController.text,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) =>
                  const DashboardPage(),
        ),
      );
    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text(e.toString()),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FA),

      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: 280,

              width: double.infinity,

              decoration:
                  const BoxDecoration(
                gradient:
                    LinearGradient(
                  colors: [
                    Color(0xFF22C55E),
                    Color(0xFF16A34A),
                  ],
                ),
              ),

              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  const Icon(
                    Icons.spa,
                    color: Colors.white,
                    size: 90,
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  const Text(
                    'NutryCoach',
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontSize: 34,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  const Text(
                    'Seu nutricionista digital',
                    style: TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            Transform.translate(
              offset:
                  const Offset(0, -40),

              child: Container(
                margin:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                padding:
                    const EdgeInsets.all(
                  24,
                ),

                decoration:
                    BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),

                  boxShadow: [

                    BoxShadow(
                      color: Colors.black
                          .withOpacity(
                        0.08,
                      ),
                      blurRadius: 20,
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    TextField(
                      controller:
                          _emailController,

                      decoration:
                          InputDecoration(
                        labelText:
                            'E-mail',

                        prefixIcon:
                            const Icon(
                          Icons.email,
                        ),

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    TextField(
                      controller:
                          _passwordController,

                      obscureText: true,

                      decoration:
                          InputDecoration(
                        labelText:
                            'Senha',

                        prefixIcon:
                            const Icon(
                          Icons.lock,
                        ),

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    SizedBox(
                      width:
                          double.infinity,

                      height: 55,

                      child:
                          ElevatedButton(
                        onPressed:
                            loading
                                ? null
                                : login,

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(
                            0xFF22C55E,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),
                          ),
                        ),

                        child: Text(
                          loading
                              ? 'Entrando...'
                              : 'Entrar',
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    TextButton(
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Criar conta',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
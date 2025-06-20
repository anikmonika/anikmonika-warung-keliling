import 'package:flutter/material.dart';
import 'package:warungkeliling/login.dart'; // pastikan import ini mengarah ke file login.dart yang ada kelas LoginPage

void main() {
  runApp(const FigmaToCodeApp());
}

// Aplikasi Utama
class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Home(),
    );
  }
}

// Halaman Splash/Home
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    // Delay 2 detik sebelum navigasi ke halaman login otomatis
    Future.delayed(const Duration(seconds: 2), () {
      _navigateToLogin();
    });
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(_createFadeRoute(const LoginPage()));
  }

  // Fungsi membuat route dengan animasi fade
  Route _createFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: _navigateToLogin, // Klik di mana saja pindah ke LoginPage
      child: Center(
        child: Container(
          width: 430,
          height: 932,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 430,
                  height: 53,
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '12:30',
                        style: TextStyle(
                          color: Color(0xFF170E2B),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 17.76,
                        height: 7.76,
                        decoration: BoxDecoration(
                          color: const Color(0xFF170E2B),
                          borderRadius: BorderRadius.circular(1.33),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 53,
                child: Container(
                  width: 430,
                  height: 879,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 67,
                        top: 404,
                        child: Text(
                          'warung keliling',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF0CA201),
                            fontSize: 42,
                            fontFamily: 'Baloo Da',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 421.81,
                        top: 920.75,
                        child: Transform.rotate(
                          angle: -3.05,
                          child: Container(
                            width: 459.06,
                            height: 407.30,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://placehold.co/459x407"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

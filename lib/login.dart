import 'package:flutter/material.dart';
import 'package:warungkeliling/warung.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Tema terang karena background putih
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController telpController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    telpController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final nama = namaController.text.trim();
    final telp = telpController.text.trim();

    if (nama.isNotEmpty && telp.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Warung()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan isi nama dan nomor telepon')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image (from assets)
            Positioned.fill(
              child: Opacity(
                opacity: 0.2, // Background semu
                child: Image.asset(
                  'assets/login.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // WARUNG KELILING di paling atas setelah SafeArea, diperbesar, bold, hijau muda
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                alignment: Alignment.center,
                child: const Text(
                  'WARUNG KELILING',
                  style: TextStyle(
                    color: Color(0xFF32CD32), // Hijau muda (Lime Green)
                    fontWeight: FontWeight.w900, // sangat tebal
                    fontSize: 40, // font size besar
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),

            // Content form (nama, telp, sign in)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 80), // Jeda supaya tidak terlalu dekat tulisan atas

                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 32, // Lebih besar
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Input Nama
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFF1DED20)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: namaController,
                        decoration: const InputDecoration(
                          hintText: 'Nama',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18, // diperbesar
                        ),
                      ),
                    ),

                    // Input Nomor Telepon
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFF1DED20)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: telpController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Nomor Telepon',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18, // diperbesar
                        ),
                      ),
                    ),

                    // Tombol SIGN IN
                    GestureDetector(
                      onTap: _handleLogin,
                      child: Container(
                        width: double.infinity,
                        height: 47,
                        decoration: BoxDecoration(
                          color: const Color(0xFF33CD28),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF33CD28), width: 2),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
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
    );
  }
}

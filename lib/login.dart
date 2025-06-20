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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
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
            // Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/430x932"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Input & Button Area
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        style: const TextStyle(color: Colors.black),
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
                        style: const TextStyle(color: Colors.black),
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

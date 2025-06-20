import 'package:flutter/material.dart';
import 'package:warungkeliling/product.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Ubah ke light supaya teks hitam tampak jelas
      home: const Scaffold(
        body: Warung(),
      ),
    );
  }
}

class Warung extends StatelessWidget {
  const Warung({super.key});

  void _showSelectedDialog(BuildContext context, String warungName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Warung Dipilih'),
        content: Text('Kamu memilih $warungName'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Product()),
              );
            },
            child: const Text('Lanjut'),
          ),
        ],
      ),
    );
  }

  Widget _buildWarungButton(BuildContext context, String label, double top) {
    return Positioned(
      left: 76,
      top: top,
      child: GestureDetector(
        onTap: () => _showSelectedDialog(context, label),
        child: Container(
          width: 269,
          height: 47,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF33CD28),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF33CD28), width: 2),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none, // Pastikan tidak ada underline
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430,
      height: 932,
      color: Colors.white,
      child: Stack(
        children: [
          // Background bawah yang agak semu
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 250,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/warung.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Judul
          const Positioned(
            left: 76,
            top: 130, // lebih ke bawah
            child: SizedBox(
              width: 269,
              child: Text(
                'PILIH WARUNG',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  decoration: TextDecoration.none, // Tidak underline
                ),
              ),
            ),
          ),

          // Tombol-tombol warung (diturunkan sedikit)
          _buildWarungButton(context, 'WARUNG BU NANING', 200),
          _buildWarungButton(context, 'WARUNG ABC', 265),
          _buildWarungButton(context, 'WARUNG MBAK ANNA', 330),
          _buildWarungButton(context, 'WARUNG SEMBAKO', 395),
        ],
      ),
    );
  }
}

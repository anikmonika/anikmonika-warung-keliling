import 'package:flutter/material.dart';
import 'package:warungkeliling/product.dart'; // Import your Product page here

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Scaffold(
        body: Warung(),
      ),
    );
  }
}

class Warung extends StatelessWidget {
  const Warung({super.key});

  void _navigateToProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Product()),
    );
  }

  Widget _buildWarungButton(BuildContext context, String label, double top) {
    return Positioned(
      left: 76,
      top: top,
      child: GestureDetector(
        onTap: () => _navigateToProduct(context),
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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://placehold.co/430x932"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 76,
            top: 72,
            child: SizedBox(
              width: 269,
              height: 37,
              child: Text(
                'PILIH WARUNG',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Warung buttons
          _buildWarungButton(context, 'WARUNG BU NANING', 165),
          _buildWarungButton(context, 'WARUNG ABC', 230),
          _buildWarungButton(context, 'WARUNG MBAK ANNA', 295),
          _buildWarungButton(context, 'WARUNG SEMBAKO', 360),

          // Top white transparent header
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 430,
              height: 53,
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(217),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 15,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
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
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:warungkeliling/home.dart';
import 'package:warungkeliling/login.dart'; 
import 'package:warungkeliling/order.dart';
import 'package:warungkeliling/product.dart';
import 'package:warungkeliling/checkout.dart';
import 'package:warungkeliling/warung.dart';
import 'package:warungkeliling/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warung Keliling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      initialRoute: '/login', // Halaman awal = Login
      routes: {
        '/login': (context) => const LoginPage(), 
        '/home': (context) => const Home(),
        '/order': (context) => const Order(),
        '/product': (context) => const Product(),
        '/profile': (context) => const Checkout(),
        '/warung': (context) => const Warung(),
        '/cart': (context) => const Cart(),
      },
    );
  }
}

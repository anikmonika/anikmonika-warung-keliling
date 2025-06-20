import 'package:flutter/material.dart';
import 'package:warungkeliling/home.dart';
import 'package:warungkeliling/login.dart'; 
import 'package:warungkeliling/order.dart';
import 'package:warungkeliling/product.dart';
import 'package:warungkeliling/checkout.dart';
import 'package:warungkeliling/warung.dart';
import 'package:warungkeliling/cartpage.dart';

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
        scaffoldBackgroundColor: const Color.fromARGB(255, 246, 247, 247),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(), 
        '/home': (context) => const Home(),
        '/order': (context) => const Order(),
        '/product': (context) => const Product(),
        '/checkout': (context) => const Checkout(cartItems: [],),
        '/warung': (context) => const Warung(),
        '/cart': (context) => const CartPage(cartItems: [],),
      },
    );
  }
}

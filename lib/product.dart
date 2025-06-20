import 'package:flutter/material.dart';
import 'package:warungkeliling/cart.dart';
import 'package:warungkeliling/home.dart';

import 'package:warungkeliling/profile.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  static const List<Map<String, dynamic>> products = [
    {
      'name': 'BROCCOLI',
      'price': 3.99,
      'rating': 4.8,
      'reviewCount': 287,
      'image': 'assets/broccoli.jpg',
    },
    {
      'name': 'CABBAGE',
      'price': 2.99,
      'rating': 4.8,
      'reviewCount': 287,
      'image': 'assets/cabbage.jpg',
    },
    {
      'name': 'CARROT',
      'price': 3.99,
      'rating': 4.8,
      'reviewCount': 287,
      'image': 'assets/Carrot.jpg',
    },
    {
      'name': 'EGGPLANT',
      'price': 5.29,
      'rating': 4.8,
      'reviewCount': 287,
      'image': 'assets/Eggplant.jpg',
    },
    {
      'name': 'GARLIC',
      'price': 5.29,
      'rating': 4.8,
      'reviewCount': 287,
      'image': 'assets/Garlic.jpg',
    },
    {
      'name': 'LONG BEAN',
      'price': 5.29,
      'rating': 4.8,
      'reviewCount': 287,
      'image': 'assets/longbean.jpg',
    },
    {
      'name': 'ONION',
      'price': 2.25,
      'rating': 4.8,
      'reviewCount': 287,
      'image': 'assets/onion.jpg',
    },
    {
      'name': 'SAWI',
      'price': 2.25,
      'rating': 4.8,
      'reviewCount': 287,
      'image': 'assets/sawi.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 6,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.asset(
                          product['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.add_circle, color: Colors.green),
                          onPressed: () {
                            // Tambahkan aksi tambah produk ke keranjang
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 14),
                          const SizedBox(width: 2),
                          Text('${product['rating']} (${product['reviewCount']})'),
                        ],
                      ),
                      Text('\$${product['price']}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Home()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Cart()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Profile()));
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
      ],
    );
  }
}

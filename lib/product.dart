import 'package:flutter/material.dart';
import 'cartpage.dart';

class ProductModel {
  final String name;
  final String imagePath;
  final double price;
  final double rating;
  final int reviewCount;

  ProductModel({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.rating,
    required this.reviewCount,
  });
}

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// MAIN APP
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Product(),
    );
  }
}

// PRODUCT PAGE (widget)
class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int _selectedIndex = 0;
  final List<CartItem> cartItems = [];

  final List<ProductModel> products = [
    ProductModel(name: 'Broccoli', imagePath: 'assets/broccoli.jpg', price: 2.99, rating: 4.7, reviewCount: 150),
    ProductModel(name: 'Cabbage', imagePath: 'assets/cabbage.jpg', price: 1.99, rating: 4.4, reviewCount: 120),
    ProductModel(name: 'Garlic', imagePath: 'assets/garlic.jpg', price: 0.99, rating: 4.8, reviewCount: 200),
    ProductModel(name: 'Onion', imagePath: 'assets/onion.jpg', price: 1.50, rating: 4.6, reviewCount: 180),
    ProductModel(name: 'Eggplant', imagePath: 'assets/eggplant.jpg', price: 2.50, rating: 4.5, reviewCount: 160),
    ProductModel(name: 'Sawi', imagePath: 'assets/sawi.jpg', price: 1.75, rating: 4.3, reviewCount: 140),
    ProductModel(name: 'Longbean', imagePath: 'assets/longbean.jpg', price: 2.20, rating: 4.4, reviewCount: 130),
    ProductModel(name: 'Carrot', imagePath: 'assets/carrot.jpg', price: 1.80, rating: 4.7, reviewCount: 170),
  ];

  int getTotalItemsInCart() {
    return cartItems.fold(0, (total, item) => total + item.quantity);
  }

  void _addToCart(ProductModel product) {
    setState(() {
      final index = cartItems.indexWhere((item) => item.product.name == product.name);
      if (index == -1) {
        cartItems.add(CartItem(product: product));
        _showAddPopup(1);
      } else {
        cartItems[index].quantity++;
        _showAddPopup(cartItems[index].quantity);
      }
    });
  }

  void _showAddPopup(int totalQuantity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Jumlah barang di cart: $totalQuantity'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CartPage(cartItems: cartItems)),
      );
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MenuPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalItems = getTotalItemsInCart();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUCT LIST'),
        backgroundColor: Colors.green, 
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(product.imagePath, fit: BoxFit.cover, width: double.infinity),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Rp ${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 14),
                        Text('${product.rating}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          iconSize: 30,
                          onPressed: () => _addToCart(product),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (totalItems > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '$totalItems',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
    );
  }
}

// ProfilePage
class ProfilePage extends StatelessWidget {
  const ProfilePage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('This is Profile Page')),
    );
  }
}

// MenuPage
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: const Center(child: Text('This is Menu Page')),
    );
  }
}

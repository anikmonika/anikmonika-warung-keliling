import 'package:flutter/material.dart';
import 'product.dart' as product_model;
import 'checkout.dart' as checkout_model;

class CartPage extends StatefulWidget {
  final List<product_model.CartItem> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<product_model.CartItem> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);
  }

  void _increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity--;
      if (cartItems[index].quantity <= 0) {
        cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalItems = cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
    final totalPrice = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('CART'),
        backgroundColor: Colors.green, 
        centerTitle: true, 
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Keranjang kosong'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.asset(item.product.imagePath, width: 50, height: 50),
                  title: Text(item.product.name),
                  subtitle: Text('Jumlah: ${item.quantity}'),
                  trailing: SizedBox(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _decreaseQuantity(index),
                        ),

                        Text(
                          '${item.quantity}',
                          style: const TextStyle(fontSize: 16),
                        ),


                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => _increaseQuantity(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Item: $totalItems | Total Harga: Rp ${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: cartItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => checkout_model.Checkout(cartItems: cartItems),
                            ),
                          );
                        },
                  child: const Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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

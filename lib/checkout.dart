import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  // Contoh data pesanan
  final List<Map<String, dynamic>> orderItems = const [
    {'name': 'Produk 1', 'price': 10.0, 'quantity': 1},
    {'name': 'Produk 2', 'price': 15.0, 'quantity': 2},
    {'name': 'Produk 3', 'price': 5.25, 'quantity': 3},
  ];

  @override
  Widget build(BuildContext context) {
    double subtotal = orderItems.fold(0, (sum, item) => sum + item['price'] * item['quantity']);
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        hintText: 'Nama Lengkap',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Nomor Telepon',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              child: const ListTile(
                title: Text('Address'),
                subtitle: Text('Aalamat lengkap'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Delivery', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              child: Column(
                children: [
                  RadioListTile<int>(
                    value: 0,
                    groupValue: 0,
                    title: const Text('Priority (10-20 mins)'),
                    onChanged: (_) {},
                    activeColor: Colors.green,
                  ),
                  RadioListTile<int>(
                    value: 1,
                    groupValue: 0,
                    title: const Text('Standard (30-45 mins)'),
                    onChanged: (_) {},
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Order Summary (${orderItems.length} items)',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    ...orderItems.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${item['name']} x${item['quantity']}',
                                  style: const TextStyle(fontSize: 14)),
                              Text(
                                '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                    const Divider(),
                    _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                    _buildSummaryRow('Service fee', '\$5.25'),
                    _buildSummaryRow('Delivery', '\$0.00'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Implementasi checkout
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Place Order', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSummaryRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(amount, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

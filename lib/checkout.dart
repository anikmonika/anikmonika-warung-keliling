import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'product.dart' as product_model; 
import 'order.dart'; 

class Checkout extends StatefulWidget {
  final List<product_model.CartItem> cartItems;

  const Checkout({super.key, required this.cartItems});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isPriorityDelivery = true;

  double getSubtotal() {
    return widget.cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  }

  int getTotalItems() {
    return widget.cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  double getServiceFee() => 5.25;

  double getDeliveryFee() {
    return _isPriorityDelivery ? 5.00 : 3.00;
  }

  bool get _isFormValid {
    return _fullNameController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _addressController.text.trim().isNotEmpty;
  }

  void _placeOrder() {
    if (!_isFormValid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Harap isi semua detail sebelum melakukan pemesanan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Order()),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  final RegExp _nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

  @override
  Widget build(BuildContext context) {
    final subtotal = getSubtotal();
    final deliveryFee = getDeliveryFee();
    final total = subtotal + getServiceFee() + deliveryFee;
    final totalItems = getTotalItems();

    return Scaffold(
      backgroundColor: Colors.grey[300], 
      appBar: AppBar(
        centerTitle: true, 
        title: const Text('CHECKOUT'),
        backgroundColor: Colors.green, 
        foregroundColor: Colors.black, 
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 28, 
          
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildTextField('Full Name', _fullNameController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                      ])),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTextField('Phone Number', _phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ])),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField('Address', _addressController, maxLines: 3),
              const SizedBox(height: 16),
              const Text('Delivery', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildDeliveryOption('Priority (10-20 mins) - Rp 5.00', true),
              const SizedBox(height: 8),
              _buildDeliveryOption('Standard (30-45 mins) - Rp 3.00', false),
              const SizedBox(height: 16),
              Text('Order Summary ($totalItems items)', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildOrderSummary('Subtotal', 'Rp ${subtotal.toStringAsFixed(2)}'),
              _buildOrderSummary('Service fee', 'Rp ${getServiceFee().toStringAsFixed(2)}'),
              _buildOrderSummary('Delivery', 'Rp ${deliveryFee.toStringAsFixed(2)}'),
              const Divider(),
              _buildOrderSummary('Total', 'Rp ${total.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    final name = _fullNameController.text.trim();
                    if (!_nameRegExp.hasMatch(name)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Nama lengkap hanya boleh huruf dan spasi')),
                      );
                      return;
                    }
                    _placeOrder();
                  },
                  child: const Text(
                    'Place Order',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1, List<TextInputFormatter>? inputFormatters}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }

  Widget _buildDeliveryOption(String text, bool isPriorityOption) {
    return Row(
      children: [
        Radio<bool>(
          value: isPriorityOption,
          groupValue: _isPriorityDelivery,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _isPriorityDelivery = value;
              });
            }
          },
          activeColor: Colors.green,
        ),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _buildOrderSummary(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(amount),
        ],
      ),
    );
  }
}

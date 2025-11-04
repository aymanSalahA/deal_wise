import 'package:deal_wise/features/cart/data/services/cart_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();
  List<Map<String, dynamic>> _cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    try {
      final items = await _cartService.fetchCart();
      setState(() {
        _cartItems = items;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('❌ Error loading cart: $e');
      setState(() => _isLoading = false);
    }
  }

  double get total =>
<<<<<<< HEAD
      _cartItems.fold(0, (sum, item) => sum + item['price'] * item['quantity']);
=======
      _cartItems.fold(0, (sum, item) => sum + (item['price'] * (item['quantity'] ?? 1)));
>>>>>>> origin/cart-feature

  void _increaseQty(int index) async {
    final item = _cartItems[index];
    final newQty = (item['quantity'] ?? 1) + 1;
    await _cartService.updateQuantity(item['id'], newQty);
    setState(() => _cartItems[index]['quantity'] = newQty);
  }

  void _decreaseQty(int index) async {
    final item = _cartItems[index];
    final newQty = (item['quantity'] ?? 1) - 1;
    if (newQty < 1) return;
    await _cartService.updateQuantity(item['id'], newQty);
    setState(() => _cartItems[index]['quantity'] = newQty);
  }

  void _removeItem(int index) async {
    final item = _cartItems[index];
    await _cartService.removeFromCart(item['id']);
    setState(() => _cartItems.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF72C9F8),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Cart',
<<<<<<< HEAD
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
=======
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
>>>>>>> origin/cart-feature
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty 😔'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  item['imageUrl'] ?? '',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'] ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
<<<<<<< HEAD
                                      item['category'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${item['price'].toStringAsFixed(2)}',
=======
                                      '\$${item['price']}',
>>>>>>> origin/cart-feature
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () => _removeItem(index),
                                  ),
                                  Row(
                                    children: [
                                      _qtyButton(
                                        Icons.remove,
                                        () => _decreaseQty(index),
                                        Colors.grey[200]!,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
<<<<<<< HEAD
                                          '${item['quantity']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
=======
                                          '${item['quantity'] ?? 1}',
                                          style: const TextStyle(fontWeight: FontWeight.w600),
>>>>>>> origin/cart-feature
                                        ),
                                      ),
                                      _qtyButton(
                                        Icons.add,
                                        () => _increaseQty(index),
                                        Colors.blue[100]!,
                                      ),
                                    ],
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
                _buildBottomSection(),
              ],
            ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
<<<<<<< HEAD
              const Text(
                "Subtotal",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
=======
              const Text("Total", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
>>>>>>> origin/cart-feature
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Proceed to Checkout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap, Color bgColor) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Icon(icon, size: 16, color: Colors.black87),
      ),
    );
  }
}

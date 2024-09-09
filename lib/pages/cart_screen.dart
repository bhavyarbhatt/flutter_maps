// lib/pages/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_maps/pages/home_page.dart';
import 'package:flutter_maps/pages/profile_screen.dart';
import '../common/app_color.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = true; // Loading state
  List<dynamic> _cartItems = []; // Cart items data
  final String _defaultImage = 'assets/images/default_image.png'; // Path to your default image

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Start from below the screen
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward(); // Start the animation
    _fetchCartItems(); // Fetch cart items data
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchCartItems() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    // Mock cart items data; replace this with your API call
    setState(() {
      _cartItems = [
        {
          "name": "Product 1",
          "image": "https://via.placeholder.com/150", // Placeholder image
          "price": 29.99,
        },
        {
          "name": "Product 2",
          "image": "invalid_url", // Invalid URL to simulate loading failure
          "price": 19.99,
        },
        {
          "name": "Product 3",
          "image": "https://via.placeholder.com/150",
          "price": 39.99,
        },
      ];
      _isLoading = false; // Set loading to false when data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: AppColors.backgroundColor)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: _isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading indicator
            : Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildImage(_cartItems[index]['image'], _cartItems[index]['name']),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _cartItems[index]['name'], // Show product name
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '\$${_cartItems[index]['price'].toStringAsFixed(2)}', // Show product price
                              style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
            // Stay on Cart Screen
              break;
            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildImage(String imageUrl, String productName) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child; // Image loaded
        return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            )
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // Show the fallback category name if the image fails to load
        return Center(
          child: Text(
            productName, // Show the product name as fallback
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
        );
      },
    );
  }
}
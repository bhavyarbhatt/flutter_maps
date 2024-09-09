// lib/pages/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_maps/pages/profile_screen.dart';
import 'package:http/http.dart' as http; // Add this dependency in pubspec.yaml
import 'dart:convert';
import 'package:shimmer/shimmer.dart'; // Import shimmer package
import '../common/app_color.dart';
import 'cart_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = true; // Loading state
  List<dynamic> _products = []; // Products data
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
    _fetchProducts(); // Fetch products data
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchProducts() async {
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay

      // Mock product data; replace this with your API call
      setState(() {
        _products = [
          {
            "name": "Product 1",
            "image": "https://via.placeholder.com/150", // Placeholder image
          },
          {
            "name": "Product 2",
            "image": "https://via.placeholder.com/150",
          },
          {
            "name": "Product 3",
            "image": "invalid_url", // Invalid URL to simulate loading failure
          },
          {
            "name": "Product 4",
            "image": "https://via.placeholder.com/150",
          },
        ];
        _isLoading = false; // Set loading to false when data is fetched
      });
    } catch (e) {
      // Handle API errors (e.g., 504 Bad Gateway)
      setState(() {
        _isLoading = false; // Set loading to false even if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: AppColors.backgroundColor)),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen (not implemented)
            },
          ),
        ],
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: _isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading indicator
            : Padding(
          padding: EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75, // Adjust aspect ratio for better layout
            ),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
                  // );
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildImage(_products[index]['image'], _products[index]['name']),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          _products[index]['name'], // Show product name
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            // Stay on Home Screen
              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
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
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
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
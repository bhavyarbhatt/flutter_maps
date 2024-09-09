// lib/pages/product_details_screen.dart
import 'package:flutter/material.dart';
import '../common/app_color.dart';
import 'cart_screen.dart'; // Import the Cart Screen

class ProductDetailsScreen extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productDescription;
  final double productPrice;

  ProductDetailsScreen({
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.productPrice,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _buttonAnimation;

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

    _buttonAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details', style: TextStyle(color: AppColors.backgroundColor)),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.productImage,
                  fit: BoxFit.cover,
                  height: 300,
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
                    return Center(
                      child: Image.asset(
                        "assets/images/log.jpeg",
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  widget.productName,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.productDescription,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '\$${widget.productPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70, // Height of the bottom bar
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${widget.productPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            ScaleTransition(
              scale: _buttonAnimation,
              child: ElevatedButton(
                onPressed: () {
                  // Logic to add the product to the cart
                  // For now, just print a message
                  print("Added ${widget.productName} to the cart.");

                  // Navigate to Cart Screen after adding to cart
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
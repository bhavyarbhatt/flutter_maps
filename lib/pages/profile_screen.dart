// lib/pages/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_maps/pages/home_page.dart';
import '../common/app_color.dart';
import 'cart_screen.dart'; // Import the Cart Screen

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  String _name = "John Doe"; // Sample user name
  String _email = "johndoe@example.com"; // Sample user email

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
        title: Text('Profile', style: TextStyle(color: AppColors.backgroundColor)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Information',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 32.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _name),
                onChanged: (value) {
                  setState(() {
                    _name = value; // Update name
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _email),
                onChanged: (value) {
                  setState(() {
                    _email = value; // Update email
                  });
                },
              ),
              SizedBox(height: 32.0),

              ElevatedButton(
                onPressed: () {
                  // Logic to save profile information
                  // For now, just print the updated information
                  print("Name: $_name");
                  print("Email: $_email");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal:16.00 ),                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
            ],
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
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
              break;
            case 2:
            // Stay on Profile Screen
              break;
          }
        },
      ),
    );
  }
}
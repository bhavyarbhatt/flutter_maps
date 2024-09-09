import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Function onLogout;

  const CustomDrawer({Key? key, required this.onLogout}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // Animation duration
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(-1, 0), // Start position (off-screen)
      end: Offset.zero, // End position (on-screen)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation when the drawer is opened
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          color: Colors.white, // Background color
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300], // Background color while loading
                      child: ClipOval(
                        child: Image.network(
                          'https://via.placeholder.com/150', // Replace with your profile image URL
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image loaded
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/images/defualt_image.webp', // Replace with your default profile image path
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            );
                            // Navigate to notifications screen
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'johndoe@example.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.black),
                title: Text('Feed', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.of(context).pushNamed('/home');

                },
              ),
              ListTile(
                leading: Icon(Icons.search_rounded, color: Colors.black),
                title: Text('Explore', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.of(context).pushNamed('/explore');
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.black),
                title: Text('Notifications', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.of(context).pushNamed('/notifications');
                },
              ),
              Divider(color: Colors.black),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.black),
                title: Text('Logout', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.of(context).pushNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
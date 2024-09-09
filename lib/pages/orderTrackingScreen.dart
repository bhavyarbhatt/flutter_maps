// working code

// // lib/pages/order_tracking_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_maps/pages/home_page.dart';
// import '../common/app_color.dart';
//
// class OrderTrackingScreen extends StatefulWidget {
//   @override
//   _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
// }
//
// class _OrderTrackingScreenState extends State<OrderTrackingScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0.0, 1.0), // Start from below the screen
//       end: Offset.zero, // End at the original position
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//
//     _controller.forward(); // Start the animation
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Tracking', style: TextStyle(color: AppColors.backgroundColor)),
//         backgroundColor: AppColors.primaryColor,
//       ),
//       body: SlideTransition(
//         position: _slideAnimation,
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Order Status',
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'Your order is being prepared for delivery.',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: AppColors.textColor,
//                 ),
//               ),
//               SizedBox(height: 32.0),
//               Text(
//                 'Delivery Timeline',
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'Estimated delivery time: 2-3 business days',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: AppColors.textColor,
//                 ),
//               ),
//               SizedBox(height: 32.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate back to the Home Screen
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (context) => HomeScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//                 child: Text(
//                   'Back to Home',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: AppColors.backgroundColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// lib/pages/order_tracking_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingScreen extends StatefulWidget {
  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Order ID'),
                    subtitle: Text('123456'),
                  ),
                  ListTile(
                    title: Text('Status'),
                    subtitle: Text('In Transit'),
                  ),
                  ListTile(
                    title: Text('Estimated Delivery'),
                    subtitle: Text('June 1, 2023'),
                  ),
                  ListTile(
                    title: Text('Current Location'),
                    subtitle: Text('New York, NY'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
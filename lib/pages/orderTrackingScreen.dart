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



// import 'package:flutter/material.dart';
// import 'package:flutter_maps/env.dart';
// import 'package:ola_map_flutter/ola_map_flutter.dart';
// import 'dart:async';
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final Completer<OlaMapController> _controller = Completer<OlaMapController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           body: OlaMap(
//               showCurrentLocation: false,
//               showZoomControls: true,
//               showMyLocationButton: true,
//               apiKey: '${APIEnv.olaMapsApiKey}',
//               onPlatformViewCreated: (OlaMapController controller) {
//                 _controller.complete(controller);
//               })),
//     );
//   }
// }



import 'package:flutter_maps/env.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ola_map_flutter/ola_map_flutter.dart';


class MyMapWidget extends StatefulWidget {
  @override
  _MyMapWidgetState createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> {
  late OlaMapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = OlaMapController();

    // Load the API key from your .env file
    dotenv.load(); // Load the .env file
    final apiKey = APIEnv.olaMapsApiKey; // Assuming the API key is stored under the 'API_KEY' environment variable

    // Initialize Ola Maps with the API key
    OlaMaps.initialize(
      apiKey: apiKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OlaMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(21.1702, 72.8311), // Replace with your desired location
        zoom: 15.0,
      ),
      onMapCreated: (OlaMapController controller) {
        _mapController = controller;
      },
      markers: {
        Marker(
          markerId: MarkerId('marker_1'),
          position: LatLng(21.1702, 72.8311),
          infoWindow: InfoWindow(title: 'My Location', snippet: 'This is my location'),
        ),
      },
    );
  }
}
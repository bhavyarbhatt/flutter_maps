import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_maps/pages/onBorading_page.dart';
// import 'package:ola_map_flutter/ola_map_flutter.dart';

import 'common/app_color.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // // await OlaMaps.initialize(
  // //   apiKey: 'your_ola_maps_api_key', // Replace with your Ola Maps API key
  // // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveFrame(),
    );
  }
}

class ResponsiveFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    const double breakpoint = 600;

    return screenSize.width > breakpoint ? WebMobileFrame() : SplashScreen();
  }
}

class WebMobileFrame extends StatefulWidget {
  const WebMobileFrame({Key? key}) : super(key: key);

  @override
  _WebMobileFrameState createState() => _WebMobileFrameState();
}

class _WebMobileFrameState extends State<WebMobileFrame> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  bool _isSplashCompleted = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => _updateTime());
    _startSplashTimer(); // Start splash timer
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  void _startSplashTimer() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        _isSplashCompleted = true; // Mark splash as completed after 3 seconds
      });
    });
  }

  String _formatTime(BuildContext context) {
    return TimeOfDay.fromDateTime(_currentTime).format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 375, // iPhone X width
          height: 812, // iPhone X height
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.grey.shade800, width: 10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Column(
              children: [
                // Status bar
                Container(
                  height: 44,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          _formatTime(context),
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: [
                            Icon(Icons.signal_cellular_alt_2_bar_outlined,
                                color: Colors.black, size: 16),
                            SizedBox(width: 4),
                            Icon(Icons.wifi_lock_outlined,
                                color: Colors.black, size: 16),
                            SizedBox(width: 4),
                            Icon(Icons.battery_5_bar,
                                color: Colors.black, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Main content - Use a nested Navigator for all navigation
                Expanded(
                  child: Navigator(
                    onGenerateRoute: (settings) {
                      WidgetBuilder builder;
                      switch (settings.name) {
                        case '/':
                          builder = (BuildContext _) => _isSplashCompleted
                              ? OnboardingScreen()  // login here set
                              : SplashScreen();
                          break;


                        default:
                          throw Exception('Invalid route: ${settings.name}');
                      }
                      return MaterialPageRoute(
                          builder: builder, settings: settings);
                    },
                  ),
                ),
                // Home indicator
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    width: 135,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    // Navigate to Home Screen after the animation completes
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delivery_dining,
                size: 100,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to Delivery App',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
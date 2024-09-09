// import 'package:flutter/material.dart';
//
// class AppStyles {
//   static const TextStyle headline = TextStyle(
//     fontFamily: AppFonts.primaryFont,
//     fontSize: 24,
//     fontWeight: FontWeight.bold,
//     color: AppColors.text,
//   );
//
//   static const TextStyle bodyText = TextStyle(
//     fontFamily: AppFonts.primaryFont,
//     fontSize: 16,
//     color: AppColors.text,
//   );
//
//   static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
//     primary: AppColors.primary,
//     textStyle: bodyText,
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter_maps/common/Widgets/app_bar.dart';
import 'dart:async';
import 'package:get/get.dart';

import 'app_string.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: AppString.AppTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:Scaffold(
          body: Column(
            children: [


              CustomAppBar(
                title: "CozyApps",

              ),

              Expanded(child: WebMobileFrame()),



            ],
          ),
        )


    );
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

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => _updateTime());
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
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.grey.shade800, width: 10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 44,
              color: Colors.white,
              child: Column(
                children: [

                  /// Time Notch Tower,Wifi,Battery Icon

                  Row(
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
                        margin: EdgeInsets.only(top: Get.width * 0.005),
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: [
                            Icon(Icons.signal_cellular_alt_2_bar_sharp, color: Colors.black, size: 16),
                            SizedBox(width: 4),
                            Icon(Icons.network_wifi_3_bar, color: Colors.black, size: 16),
                            SizedBox(width: 4),
                            Icon(Icons.battery_5_bar_sharp, color: Colors.black, size: 16),
                          ],
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


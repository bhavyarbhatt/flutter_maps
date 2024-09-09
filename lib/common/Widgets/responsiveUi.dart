import 'package:flutter/material.dart';

class MyResponsiveWidget extends StatelessWidget {
  const MyResponsiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile layout
          return Center(
            child: Text("Mobile"),
          );
        } else if (constraints.maxWidth < 1024) {
          // Tablet layout
          return Center(
            child: Text("Tab"),
          );
        } else {
          // Desktop layout
          return Center(
            child: Text("Desktop"),
          );
        }
      },
    );
  }
}
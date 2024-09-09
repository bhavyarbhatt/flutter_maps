import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData? leadingIcon; // Optional leading icon
  final IconData? trailingIcon; // Optional trailing icon
  final VoidCallback? onLeadingPressed; // Optional leading icon action
  final VoidCallback? onTrailingPressed; // Optional trailing icon action
  final Color backgroundColor; // Customizable background color
  final Color iconColor; // Customizable icon color

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.onLeadingPressed,
    this.onTrailingPressed,
    this.backgroundColor = Colors.black87, // Default background color
    this.iconColor = Colors.white, // Default icon color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor, // Use the customizable background color
      height: 56, // Default AppBar height
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leadingIcon != null)
            IconButton(
              icon: Icon(leadingIcon, color: iconColor), // Use the customizable icon color
              onPressed: onLeadingPressed,
            ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: iconColor, fontSize: 20), // Use the customizable icon color for text
              ),
            ),
          ),
          if (trailingIcon != null)
            IconButton(
              icon: Icon(trailingIcon, color: iconColor), // Use the customizable icon color
              onPressed: onTrailingPressed,
            ),
        ],
      ),
    );
  }
}

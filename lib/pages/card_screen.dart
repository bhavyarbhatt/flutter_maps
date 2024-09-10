// lib/pages/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_maps/common/app_color.dart';
import 'package:flutter_maps/pages/orderTrackingScreen.dart';
import 'package:flutter_maps/pages/payment_success.dart';
import 'package:u_credit_card/u_credit_card.dart';



class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String cardHolderFullName = '';
  String cardNumber = '';
  String validFrom = '01/23'; // Default value
  String validThru = '01/28'; // Default value
  Color topLeftColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: AppColors.backgroundColor)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreditCardUi(
              cardHolderFullName: cardHolderFullName.isEmpty ? 'Card Holder' : cardHolderFullName,
              cardNumber: cardNumber.isEmpty ? 'XXXX XXXX XXXX XXXX' : cardNumber,
              validFrom: validFrom,
              validThru: validThru,
              topLeftColor: topLeftColor,
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  cardHolderFullName = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Card Holder Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                // Limit input to 12 digits and allow only numbers
                if (value.length <= 12 && RegExp(r'^[0-9]*$').hasMatch(value)) {
                  setState(() {
                    cardNumber = value;
                  });
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
                hintText: 'XXXX XXXX XXXX',
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          child: ElevatedButton(
            onPressed: () {
              // Process payment here
              // Navigator.of(context).pushReplacement(
                // MaterialPageRoute(builder: (context) => OrderTrackingScreen()),
                // MaterialPageRoute(builder: (context) => MyApp()),
              // );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              'Pay Now',
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.backgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
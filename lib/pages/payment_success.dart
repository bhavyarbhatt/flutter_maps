// // lib/pages/pay_mat.dart
// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
//
// // lib/payment_configurations.dart
// class PaymentConfigurations {
//   static const String defaultGooglePay = '''
//   {
//     "apiVersion": "2",
//     "apiVersionMinor": "0",
//     "allowedPaymentMethods": [
//       {
//         "type": "CARD",
//         "parameters": {
//           "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
//           "allowedCardNetworks": ["MASTERCARD", "VISA"]
//         },
//         "tokenizationSpecification": {
//           "type": "PAYMENT_GATEWAY",
//           "parameters": {
//             "gateway": "example",
//             "gatewayMerchantId": "exampleGatewayMerchantId"
//           }
//         }
//       }
//     ],
//     "merchantInfo": {
//       "merchantId": "BCR2DN6T7ZC6JFQX",
//       "merchantName": "Example Merchant"
//     },
//     "transactionInfo": {
//       "totalPriceStatus": "FINAL",
//       "totalPriceLabel": "Total",
//       "totalPrice": "99.99",
//       "currencyCode": "USD",
//       "countryCode": "US"
//     }
//   }
//   ''';
//
//   static const String defaultApplePay = '''
//   {
//     "merchantIdentifier": "merchant.com.example",
//     "countryCode": "US",
//     "currencyCode": "USD",
//     "supportedNetworks": ["visa", "masterCard", "amex"],
//     "merchantCapabilities": "capability3DS",
//     "transactionInfo": {
//       "totalAmount": "99.99",
//       "currencyCode": "USD",
//       "countryCode": "US"
//     }
//   }
//   ''';
// }
//
//
// class PayMat extends StatelessWidget {
//   const PayMat({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pay for Flutter Demo'),
//       ),
//       backgroundColor: Colors.white,
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         children: [
//           // Your product details here
//           // ...
//
//           // Google Pay Button
//           GooglePayButton(
//             paymentConfiguration: PaymentConfiguration.fromJsonString(
//               PaymentConfigurations.defaultGooglePay,
//             ),
//             paymentItems: const [
//               PaymentItem(
//                 label: 'Total',
//                 amount: '99.99',
//                 status: PaymentItemStatus.final_price,
//               ),
//             ],
//             type: GooglePayButtonType.buy,
//             margin: const EdgeInsets.only(top: 15.0),
//             onPaymentResult: (data) {
//               // Handle payment result
//               debugPrint(data.toString());
//             },
//             loadingIndicator: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//
//           const SizedBox(height: 15),
//
//           // Apple Pay Button
//           ApplePayButton(
//             paymentConfiguration: PaymentConfiguration.fromJsonString(
//               PaymentConfigurations.defaultApplePay,
//             ),
//             paymentItems: const [
//               PaymentItem(
//                 label: 'Total',
//                 amount: '99.99',
//                 status: PaymentItemStatus.final_price,
//               ),
//             ],
//             style: ApplePayButtonStyle.black,
//             type: ApplePayButtonType.buy,
//             margin: const EdgeInsets.only(top: 15.0),
//             onPaymentResult: (data) {
//               // Handle payment result
//               debugPrint(data.toString());
//             },
//             loadingIndicator: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//           const SizedBox(height: 15),
//         ],
//       ),
//     );
//   }
// }
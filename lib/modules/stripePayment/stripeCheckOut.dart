//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
//
// const kStripeHtmlPage = '''
// <!DOCTYPE html>
// <html>
// <script src="https://js.stripe.com/v3/"></script>
// <head><title>Stripe checkout</title></head>
// <body>
// Hello Webview
// </body>
// </html>
// ''';
//
// class CheckoutPage extends StatefulWidget {
//   final String sessionId;
//
//   const CheckoutPage({Key key, this.sessionId}) : super(key: key);
//
//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }
//
// class _CheckoutPageState extends State<CheckoutPage> {
//   // WebViewController _controller;
//   String get initialUrl =>
//       'data:text/html;base64,${base64Encode(Utf8Encoder().convert(kStripeHtmlPage))}';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: WebView(
//         initialUrl: initialUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (controller) => _controller = controller,
//         onPageFinished: (String url) {
//           if (url == initialUrl) {
//             _redirectToStripe();
//           }
//         },
//         navigationDelegate: (NavigationRequest request) {
//           if (request.url.startsWith('https://success.com')) {
//             Navigator.of(context).pop('success'); // <-- Handle success case
//           } else if (request.url.startsWith('https://cancel.com')) {
//             Navigator.of(context).pop('cancel'); // <-- Handle cancel case
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     );
//   }
//
//   void _redirectToStripe() { //<--- prepare the JS in a normal string
//     var apiKey = 'sk_test_51IMAfdHtqvCNmgZPQbgeJ8TKZHtZ2stloMzgKz3pDCxaIk1Vnx69v0owRJkCDqk4lu2FdiNABb6IyAZ2MR6AgD9000VioIao4w';
//     final redirectToCheckoutJs = '''
// var stripe = Stripe(\'$apiKey\');
//
// stripe.redirectToCheckout({
//   sessionId: '${widget.sessionId}'
// }).then(function (result) {
//   result.error.message = 'Error'
// });
// ''';
//     _controller.evaluateJavascript(redirectToCheckoutJs); //<--- call the JS function on controller
//   }
// }
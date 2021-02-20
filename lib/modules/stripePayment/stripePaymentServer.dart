import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class Server {

  var secretKey = 'sk_test_51IMAfdHtqvCNmgZPQbgeJ8TKZHtZ2stloMzgKz3pDCxaIk1Vnx69v0owRJkCDqk4lu2FdiNABb6IyAZ2MR6AgD9000VioIao4w';

  Future<String> createCheckout() async {
    final auth = 'Basic ' + base64Encode(utf8.encode('$secretKey:'));
    final body = {
      'payment_method_types': ['card'],
      'line_items': [
        {
          'price': 'nikesPriceId',
          'quantity': 1,
        }
      ],
      'mode': 'payment',
      'success_url': 'https://success.com/{CHECKOUT_SESSION_ID}',
      'cancel_url': 'https://cancel.com/',
    };

    try {
      final result = await Dio().post(
        "https://api.stripe.com/v1/checkout/sessions",
        data: body,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: auth},
          contentType: "application/x-www-form-urlencoded",
        ),
      );
      return result.data['id'];
    } on DioError catch (e, s) {
      print(e.response);
      throw e;
    }
  }
}
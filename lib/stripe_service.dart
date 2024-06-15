import 'dart:convert';
import 'package:http/http.dart' as http;

class StripeService {
  static const String _serverUrl = 'http://your-server-url:3000';

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      final response = await http.post(
        Uri.parse('$_serverUrl/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': amount, 'currency': currency}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to create payment intent: ${response.body}');
        return {};
      }
    } catch (err) {
      print('Error creating payment intent: $err');
      return {};
    }
  }
}

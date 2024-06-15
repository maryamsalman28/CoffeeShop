import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  final String baseUrl = 'https://api.quotable.io';

  Future<Quote> fetchQuote() async {
    final response = await http.get(Uri.parse('$baseUrl/random'));

    if (response.statusCode == 200) {
      return Quote.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load quote');
    }
  }
}

class Quote {
  final String content;
  final String author;

  Quote({required this.content, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      content: json['content'],
      author: json['author'],
    );
  }
}

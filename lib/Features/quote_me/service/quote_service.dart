import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/quote_exceptions.dart';
import '../model/qoute_model.dart';



class QuoteService {
  final String _apiUrl = 'https://dummyjson.com/quotes';
  final http.Client _client;

  QuoteService({http.Client? client}) : _client = client ?? http.Client();

  Future<QuoteResponse> fetchQuotes({int skip = 0, int limit = 30}) async {
  try {
    final response = await _client.get(Uri.parse('$_apiUrl?skip=$skip&limit=$limit'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return QuoteResponse.fromJson(data);
    } else {
      throw FetchDataException('${response.statusCode}: ${response.body}');
    }
  } catch (e) {
    rethrow;
  }
}
}
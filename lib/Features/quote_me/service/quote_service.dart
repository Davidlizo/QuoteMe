import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/quote_exceptions.dart';
import '../model/qoute_model.dart';



class QuoteService {
  final String _apiUrl = 'https://dummyjson.com/quotes';

  Future<QuoteResponse> fetchQuotes({int skip = 0, int limit = 30}) async {
    try {
      final response = await http.get(Uri.parse('$_apiUrl?skip=$skip&limit=$limit'));
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
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quote_me/Features/quote_me/controllers/quote_contoller.dart';
import 'package:quote_me/Features/quote_me/service/quote_service.dart';
import 'package:quote_me/utils/quote_exceptions.dart';

void main() {
  late QuoteService quoteService;
  late QuoteController quoteController;

  setUp(() {
    quoteService = QuoteService();
    quoteController = QuoteController();
  });

  tearDown(() {
    quoteController.dispose();
  });

  group('Quote me tests', () {
    test('Fetch quotes successfully', () async {
      // Mock HTTP client
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'quotes': List.generate(30, (index) => {
              'id': 1,
              'quote': 'Test quote',
              'author': 'Test author',
            }),
            'total': 1454,
            'skip': 0,
            'limit': 30,
          }),
          200,
        );
      });

      // Set up service with mock client
      quoteService = QuoteService(client: client);

      // Fetch quotes
      final response = await quoteService.fetchQuotes();

      // Verify response
      expect(response.quotes.length, 30);
      expect(response.total, 1454);
      expect(response.skip, 0);
      expect(response.limit, 30);
    });

    test('Fetch quotes with error', () async {
      // Mock HTTP client with error
      final client = MockClient((request) async {
        return http.Response('Error message', 500);
      });

      // Set up service with mock client
      quoteService = QuoteService(client: client);

      // Fetch quotes
      expect(
        () async => await quoteService.fetchQuotes(),
        throwsA(isInstanceOf<FetchDataException>()),
      );
    });

    test('Search functionality', () async {
      // Fetch quotes
      await quoteController.fetchQuotes();

      // Set search query
      quoteController.setSearchQuery('test');

      // Check if quotes are updated
      expect(quoteController.quotes, isNotEmpty);

      // Clear search query
      quoteController.setSearchQuery('');

      // Check if all quotes are shown
      expect(quoteController.quotes, isNotEmpty);
    });

    test('Pagination', () async {
      // Initialize skip value
      quoteController.skip = 30;

      // Load more quotes
      await quoteController.loadMoreQuotes();

      // Check if skip value is updated
      expect(quoteController.skip, quoteController.limit);

      // Load previous quotes
      await quoteController.loadPreviousQuotes();

      // Check if skip value is updated
      expect(quoteController.skip, 0);
    });
  });
}
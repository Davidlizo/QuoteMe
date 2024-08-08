
import '../../model/qoute_model.dart';
import '../quote_service.dart';

class QuoteRepository {
  final QuoteService _quoteService = QuoteService();

  Future<QuoteResponse> fetchQuotes({int skip = 0, int limit = 30}) async {
    return await _quoteService.fetchQuotes(skip: skip, limit: limit);
  }
}
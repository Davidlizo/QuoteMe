import 'package:get/get.dart';
import '../model/qoute_model.dart';
import '../service/repositories/quote_repositories.dart';

class QuoteController extends GetxController {
  final _quoteRepository = QuoteRepository();

  final _quotes = <Quote>[].obs;
  final _filteredQuotes = <Quote>[].obs; // Observable for filtered quotes
  final _total = 0.obs;
  final _skip = 0.obs;
  final _limit = 30.obs;
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _searchQuery = ''.obs; // Observable for search query

  // ignore: invalid_use_of_protected_member
  List<Quote> get quotes => _filteredQuotes.value; // Expose filtered quotes
  int get total => _total.value;
  int get skip => _skip.value;
  set skip(int value) => _skip.value = value;
  int get limit => _limit.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  String get searchQuery => _searchQuery.value;

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
  }

  Future<void> fetchQuotes({int? newSkip}) async {
    try {
      _isLoading(true);
      final response = await _quoteRepository.fetchQuotes(skip: newSkip ?? _skip.value, limit: _limit.value);
      _quotes.value = response.quotes;
      _total.value = response.total;
      _skip.value = response.skip;
      _limit.value = response.limit;
      _applySearchFilter(); // Apply filter whenever quotes are fetched
    } on Exception catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading(false);
    }
  }

Future<void> loadPreviousQuotes() async {
  if (_skip.value > 0) {
    _skip.value = _skip.value - _limit.value;
    await fetchQuotes();
  }
}

Future<void> loadMoreQuotes() async {
  if (_quotes.length < _total.value) {
    _skip.value = _skip.value + _limit.value;
    await fetchQuotes();
  }
}

  void setSearchQuery(String query) {
    _searchQuery.value = query;
    _applySearchFilter();
  }

  void _applySearchFilter() {
    if (_searchQuery.value.isEmpty) {
      _filteredQuotes.value = _quotes; // Show all quotes if no search query
    } else {
      _filteredQuotes.value = _quotes.where((quote) {
        return quote.quote.toLowerCase().contains(_searchQuery.value.toLowerCase()) ||
               quote.author.toLowerCase().contains(_searchQuery.value.toLowerCase());
      }).toList();
    }
  }
}

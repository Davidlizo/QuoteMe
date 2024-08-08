class Quote {
  int id;
  String quote;
  String author;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] ?? 0,
      quote: json['quote'] ?? 'No quote available',
      author: json['author'] ?? 'Unknown author',
    );
  }
}

class QuoteResponse {
  final List<Quote> quotes;
  final int total;
  final int skip;
  final int limit;

  QuoteResponse({
    required this.quotes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) {
    final quotesJson = json['quotes'] as List<dynamic>;
    final quotes = quotesJson.map((e) => Quote.fromJson(e)).toList();
    return QuoteResponse(
      quotes: quotes,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
import 'package:flutter/material.dart';

import '../model/qoute_model.dart';

class QuoteListView extends StatefulWidget {
  final List<Quote> quotes;
  final int total;
  final int skip;
  final int limit;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const QuoteListView({
    super.key,
    required this.quotes,
    required this.total,
    required this.skip,
    required this.limit,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  _QuoteListViewState createState() => _QuoteListViewState();
}

class _QuoteListViewState extends State<QuoteListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      child: Column(
        children: [
          // List of quotes
          ...widget.quotes.map((quote) => ListTile(
                title: Text(quote.quote),
                subtitle: Text(quote.author),
              )),

          // Pagination controls
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: widget.skip > 0 ? widget.onPrevious : null,
                  icon: const Icon(Icons.arrow_back),
                  disabledColor: Colors.grey,
                ),
                const SizedBox(width: 16.0),
                Text('${widget.skip} - ${widget.skip + widget.quotes.length} of ${widget.total}'),
                const SizedBox(width: 16.0),
                IconButton(
                  onPressed: (widget.skip + widget.limit) < widget.total ? widget.onNext : null,
                  icon: const Icon(Icons.arrow_forward),
                  disabledColor: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

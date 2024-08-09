import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/qoute_model.dart';
import '../pages/quote_detail_screen.dart';

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
  State<QuoteListView> createState() => _QuoteListViewState();
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
          ...widget.quotes.map((quote) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => QuoteDetailScreen(quote: quote));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey.shade200),
                    child: ListTile(
                      leading: IconButton(
                        onPressed: () {
                          // Copy the quote text to the clipboard
                          Clipboard.setData(ClipboardData(text: quote.quote));
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Color.fromARGB(167, 23, 76, 25),
                        ),
                      ),
                      title: Text(
                        quote.quote,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      subtitle: Text(
                        quote.author,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(167, 23, 76, 25),
                        ),
                      ),
                    ),
                  ),
                ),
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
                Text(
                    '${widget.skip} - ${widget.skip + widget.quotes.length} of ${widget.total}'),
                const SizedBox(width: 16.0),
                IconButton(
                  onPressed: (widget.skip + widget.limit) < widget.total
                      ? widget.onNext
                      : null,
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

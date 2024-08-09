import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/quote_contoller.dart';
import '../widgets/quote_list.dart';

class QuoteMeScreen extends StatefulWidget {
  const QuoteMeScreen({super.key});

  @override
  State<QuoteMeScreen> createState() => _QuoteMeScreenState();
}

class _QuoteMeScreenState extends State<QuoteMeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final QuoteController _controller = Get.put(QuoteController());

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _controller.setSearchQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quotes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff005151),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              enableSuggestions: true,
              autocorrect: true,
              style: TextStyle(color: Colors.black.withOpacity(0.9)),
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: GoogleFonts.aBeeZee(
                    fontSize: 18, fontWeight: FontWeight.w400),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      width: 1, color: Color(0xff005151)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      width: 1, color: Color(0xff005151)),
                ),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),

          // Quote list or fallback message
          Expanded(
            child: Obx(() {
              if (_controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (_controller.errorMessage.isNotEmpty) {
                return Center(child: Text('Error: ${_controller.errorMessage}'));
              } else if (_controller.quotes.isEmpty && _searchController.text.isNotEmpty) {
                return Center(
                  child: Text(
                    'No quotes found for "${_searchController.text}". Try a different search.',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                return QuoteListView(
                  quotes: _controller.quotes,
                  total: _controller.total,
                  skip: _controller.skip,
                  limit: _controller.limit,
                  onPrevious: _controller.loadPreviousQuotes,
                  onNext: _controller.loadMoreQuotes,
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

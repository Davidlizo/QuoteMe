import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quote_contoller.dart';
import '../widgets/quote_list.dart';

class QuoteMeScreen extends StatefulWidget {
  const QuoteMeScreen({super.key});

  @override
  State<QuoteMeScreen> createState() => _QuoteMeScreenState();
}

class _QuoteMeScreenState extends State<QuoteMeScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuoteController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Quotes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff005151),
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage}'));
        } else {
          return QuoteListView(
            quotes: controller.quotes,
            total: controller.total,
            skip: controller.skip,
            limit: controller.limit,
            onPrevious: controller.loadPreviousQuotes,
            onNext: controller.loadMoreQuotes,
          );
        }
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/favourite_controller.dart';
import '../model/qoute_model.dart'; // Ensure this is the correct import path

class QuoteDetailScreen extends StatelessWidget {
  final Quote quote;
  final FavoritesController favoritesController = Get.find<FavoritesController>();

  QuoteDetailScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Quote Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(167, 23, 76, 25),
              Color(0xff005151),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quote.quote,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '- ${quote.author}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    bool isFavorite = favoritesController.favorites.contains(quote);
                    return  IconButton(
                      onPressed: () {
                        if (isFavorite) {
                          favoritesController.removeFavorite(quote);
                          Get.snackbar(
                            'Favorite',
                            'Removed from favorites!',
                            backgroundColor: const Color.fromARGB(167, 23, 76, 25),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 1),
                          );
                        } else {
                          favoritesController.addFavorite(quote);
                          Get.snackbar(
                            'Favorite',
                            'Added to favorites!',
                            backgroundColor: const Color.fromARGB(167, 23, 76, 25),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 1),
                          );
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorite ? Colors.pinkAccent : Colors.white,
                        size: 30,
                      ),
                    );
                  }),
                  const SizedBox(width: 60),
                  IconButton(
                     onPressed: () {
                          // Copy the quote text to the clipboard
                          Clipboard.setData(ClipboardData(text: quote.quote));
                        },
                    icon: const Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

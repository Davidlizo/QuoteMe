import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/favourite_controller.dart';
import 'quote_detail_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController =
        Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xff005151),
      ),
      body: Obx(() {
        if (favoritesController.favorites.isEmpty) {
          return Center(
              child: Text(
            'No favorites yet!',
            style: GoogleFonts.aBeeZee(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ));
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: favoritesController.favorites.length,
            itemBuilder: (context, index) {
              final quote = favoritesController.favorites[index];
              return Padding(
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
              );
            },
          );
        }
      }),
    );
  }
}

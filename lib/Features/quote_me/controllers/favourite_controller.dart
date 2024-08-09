import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/qoute_model.dart';

class FavoritesController extends GetxController {
  final _favorites = <Quote>[].obs;

  List<Quote> get favorites => _favorites;

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
  }

  void addFavorite(Quote quote) {
    if (!_favorites.contains(quote)) {
      _favorites.add(quote);
      _saveFavorites();
    }
  }

  void removeFavorite(Quote quote) {
    _favorites.remove(quote);
    _saveFavorites();
  }

  // Load favorites from SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites');
    if (favoritesJson != null) {
      final List<dynamic> decodedFavorites = jsonDecode(favoritesJson);
      _favorites.value = decodedFavorites.map((json) => Quote.fromJson(json)).toList();
    }
  }

  // Save favorites to SharedPreferences
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String favoritesJson = jsonEncode(_favorites.map((quote) => quote.toJson()).toList());
    await prefs.setString('favorites', favoritesJson);
  }
}

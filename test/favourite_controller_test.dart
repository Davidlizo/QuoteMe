import 'package:flutter_test/flutter_test.dart';
import 'package:quote_me/Features/quote_me/controllers/favourite_controller.dart';
import 'package:quote_me/Features/quote_me/model/qoute_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FavoritesController favoritesController;

  setUp(() {
    favoritesController = FavoritesController();
  });

  group('Favorite tests', () {
    test('Add favorite', () {
      // Create a quote
      final quote = Quote(
        id: 1,
        quote: 'Test quote',
        author: 'Test author',
      );

      // Add favorite
      favoritesController.addFavorite(quote);

      // Verify favorite is added
      expect(favoritesController.favorites, [quote]);
    });

    test('Remove favorite', () {
      // Create a quote
      final quote = Quote(
        id: 1,
        quote: 'Test quote',
        author: 'Test author',
      );

      // Add favorite
      favoritesController.addFavorite(quote);

      // Remove favorite
      favoritesController.removeFavorite(quote);

      // Verify favorite is removed
      expect(favoritesController.favorites, []);
    });

    test('Add duplicate favorite', () {
      // Create a quote
      final quote = Quote(
        id: 1,
        quote: 'Test quote',
        author: 'Test author',
      );

      // Add favorite
      favoritesController.addFavorite(quote);

      // Try to add duplicate favorite
      favoritesController.addFavorite(quote);

      // Verify favorite is not added again
      expect(favoritesController.favorites, [quote]);
    });
  });
}
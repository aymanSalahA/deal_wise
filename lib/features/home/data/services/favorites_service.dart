import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_product_ids';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<Set<String>> _loadIds() async {
    final prefs = await _prefs;
    final list = prefs.getStringList(_favoritesKey) ?? const <String>[];
    return list.toSet();
  }

  Future<void> _saveIds(Set<String> ids) async {
    final prefs = await _prefs;
    await prefs.setStringList(_favoritesKey, ids.toList());
  }

  Future<bool> isFavorite(String productId) async {
    final ids = await _loadIds();
    return ids.contains(productId);
  }

  Future<void> add(String productId) async {
    final ids = await _loadIds();
    if (ids.add(productId)) {
      await _saveIds(ids);
    }
  }

  Future<void> remove(String productId) async {
    final ids = await _loadIds();
    if (ids.remove(productId)) {
      await _saveIds(ids);
    }
  }

  Future<void> toggle(String productId) async {
    final ids = await _loadIds();
    if (ids.contains(productId)) {
      ids.remove(productId);
    } else {
      ids.add(productId);
    }
    await _saveIds(ids);
  }

  Future<List<String>> getAll() async {
    final ids = await _loadIds();
    return ids.toList();
  }
}

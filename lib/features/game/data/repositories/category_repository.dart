import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/category.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository();
});

class CategoryRepository {
  Future<List<Category>> loadCategories() async {
    try {
      final String response = await rootBundle.loadString(
        AppConstants.categoriesJsonPath,
      );
      final Map<String, dynamic> data = json.decode(response) as Map<String, dynamic>;
      final List<dynamic> categoriesJson = data['categories'] as List<dynamic>;

      return categoriesJson
          .map((json) => Category.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<Category?> getCategoryById(String id) async {
    try {
      final categories = await loadCategories();
      return categories.firstWhere(
        (category) => category.id == id,
        orElse: () => throw Exception('Category not found'),
      );
    } catch (e) {
      return null;
    }
  }
}

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return await repository.loadCategories();
});

final categoryByIdProvider = FutureProvider.family<Category?, String>(
  (ref, categoryId) async {
    final repository = ref.watch(categoryRepositoryProvider);
    return await repository.getCategoryById(categoryId);
  },
);

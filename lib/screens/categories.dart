import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.filteredMeals,
  });

  final List<Meal> filteredMeals;

  void _selectCategory(BuildContext context, Category category) {
    final newList = filteredMeals
        .where(
          (element) => element.categories.contains(category.id),
        )
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((ctx) => MealsScreen(
              title: category.title,
              meals: newList,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final e in availableCategories)
          CategoryGridItem(
            category: e,
            onCategory: _selectCategory,
          ),
      ],
    );
  }
}
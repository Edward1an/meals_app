import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final filters = ref.watch(filtersProvider);
  final meals = ref.watch(mealsProvider);
  return meals.where((e) {
    if (filters[Filter.glutenFree]! && !e.isGlutenFree) {
      return false;
    }
    if (filters[Filter.vegan]! && !e.isVegan) {
      return false;
    }
    if (filters[Filter.vegetarian]! && !e.isVegetarian) {
      return false;
    }
    if (filters[Filter.lactoseFree]! && !e.isLactoseFree) {
      return false;
    }
    return true;
  }).toList();
});

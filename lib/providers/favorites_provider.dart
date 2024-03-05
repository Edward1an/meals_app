import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavotiteMealsNotifier extends StateNotifier<List<Meal>> {
  FavotiteMealsNotifier() : super(<Meal>[]);

  bool toggleMealFavoriteStatus(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavotiteMealsNotifier, List<Meal>>(
        (ref) => FavotiteMealsNotifier());

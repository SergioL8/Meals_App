import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavoriteMealsNotifier() : super([]); // set the constructors and set the initial list of favorites to empty

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealsIsFavorite = state.contains(meal);
    if(mealsIsFavorite) { // this first part of the if statement removes the meal if it's in the list
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];// the ...meal operator pulls all the object in state and adds the new meal
      return true; 
    } // all this is necessary because you NEVER EVER can edit the object declared in super
    
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
}); 

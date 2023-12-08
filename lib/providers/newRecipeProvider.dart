import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/category.dart';

/*
* This provider is used to leep track of the categories selecetd when creating a new recipe
*/
class NewRecipeNotifier extends StateNotifier<List<Category>> {
  NewRecipeNotifier() : super([]); // set constructor and set the initial seleceted categories to none

  bool toggleCategoryCheck(Category category) {
    final isCategorySelected = state.contains(category); // check if the category is seleceted
    if (isCategorySelected) { // if the category is selected we want to take it of
      state = state.where((c) => c.id != category.id).toList(); // this line updates the state of the selected categories excluding the category passed to the method
      return false;
    } else { // else we want to add it
      state = [...state, category];
      return true;
    }
  }
}

final selectedCategoriesProvider = StateNotifierProvider<NewRecipeNotifier, List<Category>>((ref) {
  return NewRecipeNotifier();
});


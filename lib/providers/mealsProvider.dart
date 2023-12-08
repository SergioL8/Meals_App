import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';

/*
* this provider is used to add a meal to the dummymeals list
*/
class UpdateMealsNotifier extends StateNotifier<List<Meal>> {
  UpdateMealsNotifier() : super(dummyMeals); // create the constructor and pass as initial values the dummymeals

  // add meals to array
  bool addMealToArray(Meal newMeal) {
    state = [...state, newMeal]; // this has to be done like this because you cannot modify the state, you have to copy it with a new value
    return true;
  }
}

// set the meals provider so that it can be called by the program
final mealsProvider = StateNotifierProvider<UpdateMealsNotifier, List<Meal>>((ref) {
  return UpdateMealsNotifier();
});

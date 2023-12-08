import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';
import 'package:meals/screens/mealDetailsScreen.dart';

/*
* This class presents all the preview recipes inside a category
*/
class MealsScreen extends StatelessWidget {

  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List <Meal> meals;

  /*
  * this function pushes the meal detail screen when triggered.
  */
  void _selectMeal(BuildContext context, Meal meal) {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => 
        MealDetailsScreen(
          meal: meal, 
      ),
    ));
  }


  @override
  Widget build(context) {

    // this listview prints all the meal items inside a category
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: ((context, index) => 
        MealItem(
          meal: meals[index],
          onselectMeal: (meal) {  // when tap a meal _select meal is triggered
            _selectMeal(context, meal); 
          }
        )
      )
    );

    if (meals.isEmpty) { // if there are no meals avaiable for the selecetd category print a message informing the user
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Uh oh ... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            Text('Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
       ),
      body: content,
    );
  }
}
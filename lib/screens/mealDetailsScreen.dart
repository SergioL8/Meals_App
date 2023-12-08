import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favoritesProvider.dart';


/*
* this screen presents all the information of a recipe
*/
class MealDetailsScreen extends ConsumerWidget {

  const MealDetailsScreen({super.key, required this.meal });
  
  final Meal meal; 
  

  @override
  Widget build (context, WidgetRef ref) {

    // get the favorire meals from the provider
    final favoriteMeals = ref.watch(favoriteMealsProvider); 
    // find out if the meal that we are on is favorite or not
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton( // this is the start icon on the top right
            onPressed: () {
              // find out if the meal was already a favorite meal and it's being removed or otherwise
              final wasAdded =  ref.read(favoriteMealsProvider.notifier).toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded ? 'Meal added as favorite.'
                                : 'Meal removed from favorites.')
                )
              );
            },
            icon: AnimatedSwitcher( // animate the start when clicked
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(isFavorite ? Icons.star : Icons.star_border, key: ValueKey(isFavorite),),
            ))
        ],
      ),
      body: SingleChildScrollView( // make the column scrollable in case all the information doesn't fit the screen
        child: Column(
          children: [
            Hero( // this is used to animate the image between the meals screen(meal item) and this screen
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
      
      
            const SizedBox(height: 14,),
      
      
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),
            ),
            for (final ingredient in meal.ingredients) // loop trough the ingredients and display them
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground),
              ),
      
      
            const SizedBox(height: 24,),
      
      
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),
            ),
            for (final steps in meal.steps) // loop trough the steps and display them 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  steps,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
          ],
        ),
      ),
      
    );
    
  }
}
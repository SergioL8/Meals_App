import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/mealsScren.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

/*
* This class displays the grid in which all the categories are organized
*/
class CategoriesScreen extends StatefulWidget {

  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {


  late AnimationController _animationController; // this animation controller is set up for the grid to appear from the bottom
  
  @override
  void initState() { 
    super.initState(); // set the animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() { // the dispose is important to get rid of the animation and be able to optimize storage
    _animationController.dispose();
    super.dispose();
  }

  /*
  * This function is triggered when a category is selected by the user
  */
  void _selectCategory(BuildContext context, Category category) {
    // filter the meals with the selected category
    final filteredMeals = widget.availableMeals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.push(context, MaterialPageRoute( // push the meals screen 
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: filteredMeals,
        )
      )
    );
  }

  @override
  Widget build (context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => SlideTransition(
        position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0) ,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.decelerate)
        ),
        child: child,
      ),
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),

        children: [
          for(final category in availableCategories) // loop through the categories displaying them with the category grid item
            CategoryGridItem(
              category: category,
              onselectCategory: () {
                _selectCategory(context, category);
              }
            ),
        ],
    ),
  );
    
    
  }
}
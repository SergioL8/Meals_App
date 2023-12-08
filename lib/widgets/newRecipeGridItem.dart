import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favoritesProvider.dart';
import 'package:meals/providers/newRecipeProvider.dart';


/*
* This class creates an item consisting of a checkbox for a specific category
*/
class NewRecipeGridItem extends ConsumerWidget {

  NewRecipeGridItem({super.key, required this.category});
  final Category category;
  
  @override
  Widget build(context, WidgetRef ref) {

    // this variable stores the categories that have been selected by the userxs
    final selectedCategories = ref.watch(selectedCategoriesProvider); 
    bool isChecked = selectedCategories.contains(category); // this variable is necessar to manage the state of the UI and to set the checked button to true of false

    return SizedBox(
      width: 10,
      height: 0,
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (clicked) {
                // on changed we call the toggleCategoryCheck which is a function in the provider file
                // this fucntion adds the category to a list
                ref.read(selectedCategoriesProvider.notifier).toggleCategoryCheck(category);
            },
            shape: const CircleBorder(),
            ),
          
          Text(category.title,
          style: const TextStyle(color: Colors.white),),
          
        ],
      ),
    );
  }
}
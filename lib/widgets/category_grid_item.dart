import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

/*
* This class provides an item for the grid which displais the different categories in the categories page
*/
class CategoryGridItem extends StatelessWidget {

  const CategoryGridItem({super.key, required this.category, required this.onselectCategory});
  final Category category;
  final void Function() onselectCategory;

  @override
  Widget build(context) {
    return InkWell( // used to make the widget tappable
      onTap: onselectCategory, // provided in the constructor and used to change between screens
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
         child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground
          ),
        ),
      ),
    );
  }
}
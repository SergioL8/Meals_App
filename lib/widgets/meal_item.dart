import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

/*
* this class is used to create a widget to display a previous for each meal
*/
class  MealItem extends StatelessWidget {
  
  const MealItem({super.key, required this.meal, required this.onselectMeal});

  final Meal meal;
  final void Function(Meal meal) onselectMeal;

// this two getters are used to display beatuifully the complexity and affordability variable 
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }
  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }


  @override
  Widget build (context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge, // this gives the borders a nice, curved look
      elevation: 2, // this gives a bit of elevation to the card with respect the background (shadow of the card)
      child: InkWell( // inkwell is a widget that makes all widgets tapable
        onTap: () { onselectMeal(meal); }, // on tap we call this function which is received in the constructor and changes the screen to the meal details screen
        child: Stack( // the stack widget is used to stack one widget on top of another, in this case we are using it to add a layer on the card to display some information
          children: [
            Hero( // the hero widget is used for animation, in this case we are using it to make the transition between the preview and the details smooth with the picture
              tag: meal.id, // needed to know what widgets are we using
              child: FadeInImage( // the fade in image is used because it takes some time for the image to load, and we want a smooth aparition
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover, // make sure that the image is properly fittet
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned( // this widget is use to locate it's child inside another widget
              bottom: 0,
              left: 0,
              right: 0,
              child: Container( // this container shows the preview information (how had and expensie the recipe is) 
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(icon: Icons.schedule, label: '${meal.duration} min'),
                        const SizedBox(width: 8,),
                        MealItemTrait(icon: Icons.work, label: complexityText,),
                        const SizedBox(width: 8,),
                        MealItemTrait(icon: Icons.attach_money, label: affordabilityText)
                      ],
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
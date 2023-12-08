import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:meals/providers/mealsProvider.dart';
import 'package:meals/widgets/mainDrawer.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/newRecipeGridItem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:meals/providers/newRecipeProvider.dart';

class NewRecipeScreen extends ConsumerStatefulWidget {

  NewRecipeScreen({super.key, required this.onSelectScreen, required this.dummyData});
  List<Meal> dummyData;
  void Function(String identifier) onSelectScreen;

  @override
  ConsumerState<NewRecipeScreen> createState() {
    return _NewRecipeScreenState();
  }
}

class _NewRecipeScreenState extends ConsumerState<NewRecipeScreen> {
  

  // variable declaration to store user inputs
  final _titleControler = TextEditingController();
  Affordability _selectedAffordability = Affordability.affordable;
  Complexity _selectedComplexity = Complexity.simple;
  int _duration = 30;
  final _imageURLControler = TextEditingController();
  final _ingredientsControler = TextEditingController();
  final _stepsControler = TextEditingController();

  
  // this is used to conver the input of the steps and ingredients from a string to an array
  List<String> convertToArray (String input) {
    LineSplitter ls = const LineSplitter();
    List<String> returnArray = ls.convert(input);
    return returnArray;
  }



  @override
  Widget build (context) {

  final selectedCategories = ref.watch(selectedCategoriesProvider);
  final selectedCategoriesID = selectedCategories.map((e) => e.id);
  
  /*
  * This function is triggered when the save button is tapped
  */
  void submitNewRecipe () {
    // this if statement checks that all the fields have been completed
    if (_titleControler.text.trim().isEmpty ||
        _imageURLControler.text.trim().isEmpty ||
        _ingredientsControler.text.trim().isEmpty ||
        _stepsControler.text.trim().isEmpty) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Invalid input'),
              content: const Text('Please make sure valid inputs were entered.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Ok'))
              ],
            )
          );
          return;
    }
    Meal newMeal = Meal(
      id: 'm18',
      categories: selectedCategoriesID.toList(),
      title: _titleControler.text,
      imageUrl: _imageURLControler.text,
      ingredients: convertToArray(_ingredientsControler.text),
      steps: convertToArray(_stepsControler.text),
      duration: _duration,
      complexity: _selectedComplexity,
      affordability: _selectedAffordability,
      isGlutenFree: false,
      isLactoseFree: false,
      isVegan: false,
      isVegetarian: false);
    ref.read(mealsProvider.notifier).addMealToArray(newMeal);
    Navigator.pop(context);
  }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submitNewRecipe,
            child: const Text('Save'),
          )
        ],
        title: Text(
          'Add New Recipe',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ) ,
      ),
      drawer: MainDrawer(onSelectScreen: widget.onSelectScreen), // the drawer is provided in case you want to return to a previous screen
      body: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: 
          SingleChildScrollView( // make the column scrolable because not everything fits the screen
            child: Column(
              children: [
                TextField( // text field for the URL
                  style: const TextStyle(color: Colors.white),
                  controller: _imageURLControler,
                  decoration: const InputDecoration(
                    label: Text('URL:'),
                  ),
                ),
                TextField( // text field for the recipe name
                  style: const TextStyle(color: Colors.white),
                  controller: _titleControler,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Recipe name'),
                  ),
                ),
                Row( // this row displays dropdown buttons for the complexity and cost of the recipe
                  children: [
                    DropdownButton(
                      value: _selectedComplexity,
                      items: Complexity.values.map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          _selectedComplexity = value;
                        });
                      }
                    ),
                    const SizedBox(width: 40,),
                    DropdownButton(
                      value: _selectedAffordability,
                      items: Affordability.values.map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          _selectedAffordability = value;
                        });
                      }
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox( // this widget shows the grid with all the category options
                  height: 185,
                  width: double.infinity,
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(), // make the grid unscrolable
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // set the form of the grid
                      crossAxisCount: 2,
                      childAspectRatio: 10/2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    children: [
                      for(final category in availableCategories) // loop through the categories printing them in the form of a checkbox
                        NewRecipeGridItem(category: category)
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox( // duration
                  height: 50,
                  width: double.infinity,
                  child: NumberPicker(
                    step: 5,
                    minValue: 0,
                    maxValue: 300, 
                    value: _duration, 
                    axis: Axis.horizontal,
                    itemWidth: 50,
                    itemHeight: 50,
                    itemCount: 7,
                    textStyle: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        _duration = value;
                      });
                    }
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox( // ingredients
                  height: 200,
                  child: 
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.multiline,
                    controller: _ingredientsControler,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      label: Text('Enter ingredients divided by returns'),
                      filled: true,
                      fillColor: Color.fromARGB(15, 250, 250, 250))
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox( // steps
                  height: 200,
                  child: 
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.multiline,
                    controller: _stepsControler,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      label: Text('Enter steps divided by returns'),
                      filled: true,
                      fillColor: Color.fromARGB(15, 250, 250, 250))
                  ),
                ),
                const SizedBox(height: 20,),
                
              ],
            ),
          ),
        ),
      )
    );
  } 
}
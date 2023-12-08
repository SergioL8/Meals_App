import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categoriesScreen.dart';
import 'package:meals/screens/fltersScreen.dart';
import 'package:meals/screens/mealsScren.dart';
import 'package:meals/screens/newReceiptScreen.dart';
import 'package:meals/widgets/mainDrawer.dart';
import 'package:meals/providers/favoritesProvider.dart';
import 'package:meals/providers/filtersProvider.dart';

const kInititalFilters = {
    Filter.gluttenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

class TasbsScreen extends ConsumerStatefulWidget {

  const TasbsScreen({super.key});

  @override
  ConsumerState<TasbsScreen> createState(){
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TasbsScreen> {

  int selectedPageIndex = 0;

/*
* This function manages the state of the screens
* It is called when using the main drawer in which you can switch between the filters, meals and new meal screens
*/
  void _setScreen(String identifier) async {

    Navigator.of(context).pop(); // this pops the main drawer
    if (identifier == 'filters') {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: ((ctx) => const FiltersScreen())
        )
      ); 
    } else if(identifier == 'newReceipe') {
        Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => NewRecipeScreen(onSelectScreen: _setScreen, dummyData: dummyMeals,)
        )
      );
    } else { 
      Navigator.pop(context);
    }
  }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);
  //   if (isExisting == true) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal removed from messages');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //     });
  //     _showInfoMessage('Marked as favorite');
  //   }
  // }

  void _selectedPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override 
  Widget build(context) {

    // this variable stores the meals which are processed by the provider
    final availableMeals = ref.watch(filteredMealsProvider);

    // this active page corresponds to ether the categories screen or the favorites screen
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,);

    String activePageTitle = 'Categories'; // this variable is used as a reference

    // if the selected page index == 1 it means that the selected page index is the favorites screen
    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider); // get the favorite meals from the providers
      setState(() {
        activePage =  MealsScreen( // call the meals screen passing only the favorites screen
          meals: favoriteMeals,
          );
        activePageTitle = 'Favorites';
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      // this widget provides a bottom bar with a couple of buttoms to switch between screens
      bottomNavigationBar: BottomNavigationBar(
        onTap: (selectedPageIndex) { _selectedPage(selectedPageIndex); },
        currentIndex:  selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen), // this is were I call the drawer
      body: activePage,
    );
  }
}
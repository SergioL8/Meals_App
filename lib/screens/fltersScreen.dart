import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filtersProvider.dart';



/*
* This screen presents the filters that can be applied to the recipes
*/
class FiltersScreen extends ConsumerWidget{

  const FiltersScreen({super.key});

  @override
  Widget build(context, WidgetRef ref) {

    final activeFilters = ref.watch(filtersProvider); // get the active filters from the provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: Column(
          children: [
            SwitchListTile( // this widget is great for settings because it includes the button
              value: activeFilters[Filter.gluttenFree]!, // find out if the filter is activeted or not
              onChanged: (isCheked) { // when activating it use the provider to change its value
                ref.read(filtersProvider.notifier).setFilter(Filter.gluttenFree, isCheked);
              },
              title: Text(
                'Gluten free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Only include glutten free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                )
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: activeFilters[Filter.lactoseFree]!,
              onChanged: (isCheked) {
                ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, isCheked);
              },
              title: Text(
                'Lactose free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Only include lactose free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                )
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: activeFilters[Filter.vegetarian]!,
              onChanged: (isCheked) {
                ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, isCheked);
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Only include vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                )
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: activeFilters[Filter.vegan]!,
              onChanged: (isCheked) {
                ref.read(filtersProvider.notifier).setFilter(Filter.vegan, isCheked);
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Only include vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                )
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:recipe/shared/styles/icon_broken.dart';

import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../meal/meal_screen.dart';

class SearchScreen extends StatelessWidget {
  final FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: FloatingSearchBar(
              controller: floatingSearchBarController,
              accentColor: defaultColor,
              borderRadius: BorderRadius.circular(5),
              backdropColor: Colors.red.withOpacity(0),
              margins: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              automaticallyImplyDrawerHamburger: false,
              automaticallyImplyBackButton: false,
              elevation: 8,
              actions: const [],
              leadingActions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {},
                  ),
                ),
                FloatingSearchBarAction.back(
                  showIfClosed: false,
                ),
              ],
              onQueryChanged: (value) {
                if(value.isEmpty){
                  cubit.clearSearchModel();
                } else {
                  cubit.getSearchData(value);
                }
              },
              body: cubit.searchModel == null ? Center(
                child: Text('Search For Meal',
                style: Theme.of(context).textTheme.bodyText1,
                ),
              ) : Container(),
              onSubmitted: (value) {},
              physics: BouncingScrollPhysics(),
              height: 50,
              hint: 'Search',
              hintStyle: const TextStyle(fontSize: 20),
              queryStyle: const TextStyle(color: Colors.black, fontSize: 20),
              builder: (BuildContext context, Animation<double> transition) {
                return state is RecipesLoadingGetSearchDataState ? LinearProgressIndicator(color: defaultColor,) : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: isDark ? Colors.white.withOpacity(0) : null,
                    elevation: 4.0,
                    child: cubit.searchModel != null? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildMealCard(
                        context: context,
                        image: cubit.searchModel!.meals[index].strMealThumb!,
                        meal: cubit.searchModel!.meals[index].strMeal!,
                        mealId: cubit.searchModel!.meals[index].idMeal!,
                        function: (){
                          cubit.getMealDetailsData(cubit.searchModel!.meals[index].idMeal!);
                          navigateTo(context, MealScreen());
                        },
                      ),
                      separatorBuilder: (context, index) => const SizedBox(height: 20,),
                      itemCount: cubit.searchModel!.meals.length,
                    ) : Container(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

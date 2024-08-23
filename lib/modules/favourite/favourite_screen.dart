import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';

import '../daily_meal/daily_meal_screen.dart';
import '../meal/meal_screen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);
        return Scaffold(
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildMealCard(
                    context: context,
                    image: cubit.favouriteMeals[index].meals[0].strMealThumb!,
                    meal: cubit.favouriteMeals[index].meals[0].strMeal!,
                    mealId: cubit.favouriteMeals[index].meals[0].idMeal!,
                    function: () {
                      cubit.getMealDetailsData(
                          cubit.favouriteMeals[index].meals[0].idMeal!);
                      navigateTo(context, MealScreen());
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: cubit.favouriteMeals.length,
              ),
              const SizedBox(height: 10,),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildMealCard(
                    context: context,
                    image: cubit.favouriteDailyMealsList[index].image!,
                    meal: cubit.favouriteDailyMealsList[index].title!,
                    mealId: cubit.favouriteDailyMealsList[index].id.toString(),
                    fromDailyPlan: true,
                    function: (){
                      navigateTo(context, DailyMealScreen(cubit.favouriteDailyMealsList[index]));
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 10,),
                itemCount: cubit.favouriteDailyMealsList.length,
              ),
            ],
          ),
        );
      },
    );
  }
}

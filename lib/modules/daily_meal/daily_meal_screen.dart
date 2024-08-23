import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:recipe/shared/network/local/cache_helper.dart';

import '../../models/daily_data_model.dart';
import '../../shared/styles/icon_broken.dart';

class DailyMealScreen extends StatelessWidget {
  final DailyDataModel dailyDataModel;

  const DailyMealScreen(this.dailyDataModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);
        int stepsLen = 0;
        for (var element in dailyDataModel.analyzedInstructions) {
          stepsLen += element.steps.length;
        }
        List<String> instructions = [];
        for (var element in dailyDataModel.analyzedInstructions) {
          if(element.name!.isNotEmpty){
            instructions.add(element.name!);
          }
          for (var ele in element.steps) {
            instructions.add(ele.step!);
          }
        }

        List<String> ingredients = [];
        for (var element in dailyDataModel.extendedIngredients) {
          ingredients.add(element.original!);
        }

        cubit.clearIngredientsList();
        if (CacheHelper.getData(key: dailyDataModel.title!) == null) {
          for (int i = 0; i < ingredients.length; i++) {
            cubit.addToIngredientsList('false');
          }
          CacheHelper.saveData(key: dailyDataModel.title!, value: cubit.ingredientsList);
        } else {
          List ls = CacheHelper.getData(key: dailyDataModel.title!);
          for (var element in ls) {
            cubit.addToIngredientsList(element.toString());
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              dailyDataModel.title!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 20),
            physics: const BouncingScrollPhysics(),
            children: [
              buildMealPicCard(
                context: context,
                image: dailyDataModel.image!,
                meal: dailyDataModel.title!,
              ),
              const SizedBox(
                height: 15,
              ),
              buildHeaderCard(
                context: context,
                title: 'Ready In',
                subTitle:
                '${dailyDataModel.readyInMinutes} Minutes',
                icon: IconBroken.Time_Circle,
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(dailyDataModel.preparationMinutes! != 'null')
                    Text(
                      '- Preparation Time : ${dailyDataModel.preparationMinutes!} Minutes',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if(dailyDataModel.cookingMinutes! != 'null')
                    Text(
                      '- Cooking Time : ${dailyDataModel.cookingMinutes!} Minutes',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              buildHeaderCard(
                context: context,
                title: 'Ingredients Required',
                subTitle:
                '${dailyDataModel.extendedIngredients.length} Items',
                icon: IconBroken.Document,
              ),
              const SizedBox(
                height: 15,
              ),
              buildMealItem(
                context: context,
                texts: ingredients,
                mealId: dailyDataModel.id.toString(),
                mealName: dailyDataModel.title!,
                showIconButton: true,
              ),
              const SizedBox(
                height: 15,
              ),
              buildHeaderCard(
                context: context,
                title: 'Direction to Prepare',
                subTitle:
                '$stepsLen Steps',
                icon: IconBroken.Arrow___Down_Circle,
              ),
              const SizedBox(
                height: 15,
              ),
              buildMealItem(
                context: context,
                texts: instructions,
                mealId: dailyDataModel.id.toString(),
                mealName: dailyDataModel.title!,
                showIconButton: false,
              ),
            ],
          ),
        );
      },
    );
  }
}

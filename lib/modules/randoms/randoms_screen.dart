import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';

import '../../shared/styles/colors.dart';

class RandomsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(title: 'Random 10 Meals', context: context),
          body: state is RecipesLoadingGetRandomMealsState || cubit.randomMealsList.isEmpty ? Center(
            child: CircularProgressIndicator(color: defaultColor,),
          ) : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            itemBuilder: (context, index) {
              return cubit.randomMealsList[index];
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: cubit.randomMealsList.length,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/modules/filter_by_area/filter_by_area_screen.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';

class AreasScreen extends StatelessWidget {
  const AreasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);
        return Scaffold(
        appBar: defaultAppBar(title: 'Areas', context: context),
        body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          itemBuilder: (context, index) => buildLayOutCard(
            context: context,
            image: RecipesCubit.get(context).areasModel!.meals[index].image!,
            text:  '${RecipesCubit.get(context).areasModel!.meals[index].strArea!} Recipes',
            networkImage: false,
            function: () {
              cubit.getFilterByAreaData(cubit.areasModel!.meals[index].strArea!);
              navigateTo(context, FilterByAreaScreen(title : cubit.areasModel!.meals[index].strArea!));
            },
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: RecipesCubit.get(context).areasModel!.meals.length,
        ),
      );
      },
    );
  }
}

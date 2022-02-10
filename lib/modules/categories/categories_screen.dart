import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/modules/filter_by_category/filter_by_category_screen.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);
        return Scaffold(
        appBar: defaultAppBar(title: 'Categories', context: context),
        body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          itemBuilder: (context, index) => buildLayOutCard(
            context: context,
            image: cubit.categoriesModel!.meals[index].image!,
            text:  '${cubit.categoriesModel!.meals[index].strCategory!} Recipes',
            networkImage: false,
            function: () {
              cubit.getFilterByCategoryData(cubit.categoriesModel!.meals[index].strCategory!);
              navigateTo(context, FilterByCategoryScreen(title : cubit.categoriesModel!.meals[index].strCategory!));
            },
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: cubit.categoriesModel!.meals.length,
        ),
      );
      },
    );
  }
}

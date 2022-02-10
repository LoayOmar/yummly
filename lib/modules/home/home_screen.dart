import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/modules/areas/areas_screen.dart';
import 'package:recipe/modules/categories/categories_screen.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';

import '../latest/latest_screen.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  buildLayOutCard(
                    context: context,
                    image: 'assets/images/category.webp',
                    text: 'Categories',
                    networkImage: false,
                    function: () {
                      navigateTo(context, CategoriesScreen());
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildLayOutCard(
                    context: context,
                    image: 'assets/images/area.jpg',
                    text: 'Area',
                    networkImage: false,
                    function: () {
                      navigateTo(context, AreasScreen());
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildLayOutCard(
                    context: context,
                    image: 'assets/images/latest.webp',
                    text: 'Latest Meals',
                    networkImage: false,
                    function: () {
                      RecipesCubit.get(context).addLatestToList(context: context);
                      navigateTo(context, LatestScreen());
                    },
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }
}

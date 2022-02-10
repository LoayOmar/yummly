import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/modules/daily_meal/daily_meal_screen.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:recipe/shared/network/local/cache_helper.dart';
import 'package:recipe/shared/styles/colors.dart';



class DailyScreen extends StatelessWidget {
  const DailyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'Daily Plan',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
            ),
          ),
          body: cubit.dailyDataModelList.length < 3 ? Center(
            child: CircularProgressIndicator(color: defaultColor,),
          ) : ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return buildMealCard(
                    context: context,
                    image: cubit.dailyDataModelList[index].image!,
                    meal: cubit.dailyDataModelList[index].title!,
                    mealId: cubit.dailyDataModelList[index].id.toString(),
                    fromDailyPlan: true,
                    function: (){
                      navigateTo(context, DailyMealScreen(cubit.dailyDataModelList[index]));
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: cubit.dailyDataModelList.length,
              ),
              const SizedBox(
                height: 15,
              ),
              buildHeaderCard(
                context: context,
                title: 'Calories',
                subTitle:
                '${cubit.dailyModel == null ? CacheHelper.getData(key: 'calories') : cubit.dailyModel!.nutrients!.calories}',
                icon: Icons.local_fire_department_rounded,
              ),
              const SizedBox(
                height: 15,
              ),
              buildHeaderCard(
                context: context,
                title: 'Protein',
                subTitle:
                '${cubit.dailyModel == null ? CacheHelper.getData(key: 'protein') : cubit.dailyModel!.nutrients!.protein}',
                icon: Icons.food_bank_outlined,
              ),
              const SizedBox(
                height: 15,
              ),
              buildHeaderCard(
                context: context,
                title: 'Fat',
                subTitle:
                '${cubit.dailyModel == null ? CacheHelper.getData(key: 'fat') : cubit.dailyModel!.nutrients!.fat}',
                icon: Icons.food_bank_outlined,
              ),
              const SizedBox(
                height: 15,
              ),
              buildHeaderCard(
                context: context,
                title: 'Carbohydrates',
                subTitle:
                '${cubit.dailyModel == null ? CacheHelper.getData(key: 'carbohydrates') : cubit.dailyModel!.nutrients!.carbohydrates}',
                icon: Icons.food_bank_outlined,
              ),
            ],
          ),
        );
      },
    );
  }
}

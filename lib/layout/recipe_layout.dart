import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/modules/daily/daily_screen.dart';
import 'package:recipe/modules/randoms/randoms_screen.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:recipe/shared/network/local/cache_helper.dart';
import 'package:recipe/shared/styles/colors.dart';
import 'package:recipe/shared/styles/icon_broken.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../modules/meal/meal_screen.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';

class RecipeLayOut extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController answerController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {
        if(state is RecipesSuccessGetAnswerDataState){
          AwesomeDialog(
              context: context,
              dialogType: DialogType.NO_HEADER,
              dismissOnTouchOutside: false,
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image(
                          image: NetworkImage(
                            RecipesCubit.get(context).answerModel!.image!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      RecipesCubit.get(context).answerModel!.answer!,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      'Type : ${RecipesCubit.get(context).answerModel!.type!}',
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        defaultButton(
                          function: () {
                            Navigator.pop(context);
                          },
                          text: 'Close',
                          context: context,
                          background: defaultColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              )
          ).show();
        }
        if(state is RecipesSuccessGetDailyDataState){
          RecipesCubit.get(context).dailyModel!.meals.forEach((element) {
            RecipesCubit.get(context).getDailyMealsData(element.id!);
          });
          navigateTo(context, DailyScreen());
        }
      },
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: defaultAppBar(
            title: cubit.titles[cubit.currentIndex],
            context: context,
          ),
          body: cubit.screens[cubit.currentIndex],
          drawer: SafeArea(
            child: Drawer(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          IconBroken.Close_Square,
                          color: defaultColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildDrawerItem(
                    context: context,
                    icon: Icons.fastfood_rounded,
                    title: 'Random Meal',
                    function: () {
                      cubit.getRandomMealData();
                      navigateTo(context, MealScreen());
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildDrawerItem(
                    context: context,
                    icon: Icons.fastfood_rounded,
                    title: 'Random 10 Meals',
                    function: () {
                      cubit.getRandomMealsData(context);
                      navigateTo(context, RandomsScreen());
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildDrawerItem(
                    context: context,
                    icon: Icons.color_lens_outlined,
                    title: 'Change App Color',
                    function: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.NO_HEADER,
                        body: Column(
                          children: [
                            ColorPicker(
                              pickerColor: defaultColor,
                              enableAlpha: false,
                              onColorChanged: (Color value) {
                                cubit.color = value;
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  defaultButton(
                                    function: () {
                                      cubit.changeDefaultColor();
                                      Navigator.pop(context);
                                    },
                                    text: 'Save',
                                    context: context,
                                    background: defaultColor,
                                    textColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  defaultButton(
                                    function: () {
                                      Navigator.pop(context);
                                    },
                                    text: 'Cancel',
                                    context: context,
                                    background: defaultColor,
                                    textColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).show();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildDrawerItem(
                    context: context,
                    icon: isDark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_outlined,
                    title: isDark ? 'Light Mode' : 'Dark Mode',
                    function: () {
                      cubit.changeAppMode();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildDrawerItem(
                    context: context,
                    icon: Icons.question_answer_outlined,
                    title: 'Quick Answer',
                    function: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.NO_HEADER,
                        body: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              defaultTextFormField(
                                controller: answerController,
                                type: TextInputType.text,
                                validate: (value){},
                                label: 'Ask Now',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    defaultButton(
                                      function: () {
                                        if(answerController.text.isNotEmpty){
                                          cubit.getAnswerData(answerController.text);
                                          answerController.clear();
                                          Navigator.pop(context);
                                        } else {
                                          showToast(text: 'Enter Question', state: ToastStates.ERROR);
                                        }
                                      },
                                      text: 'Ask',
                                      context: context,
                                      background: defaultColor,
                                      textColor: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    defaultButton(
                                      function: () {
                                        Navigator.pop(context);
                                      },
                                      text: 'Cancel',
                                      context: context,
                                      background: defaultColor,
                                      textColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
                      ).show();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildDrawerItem(
                    context: context,
                    icon: Icons.set_meal_rounded,
                    title: 'Daily Meal Plan',
                    function: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.NO_HEADER,
                        body: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                defaultTextFormField(
                                  controller: caloriesController,
                                  type: TextInputType.text,
                                  validate: (value){},
                                  label: 'Target Calories',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if(cubit.dailyDataModelList.isNotEmpty)
                                        Expanded(
                                        child: defaultButton(
                                          function: () {
                                            navigateTo(context, DailyScreen());
                                          },
                                          text: 'Last Plan',
                                          context: context,
                                          background: defaultColor,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                      if(cubit.dailyDataModelList.isNotEmpty)
                                        const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: defaultButton(
                                          function: () {
                                            if(caloriesController.text.isNotEmpty){
                                              cubit.getDailyData(double.parse(caloriesController.text));
                                              caloriesController.clear();
                                              Navigator.pop(context);
                                            } else {
                                              showToast(text: 'Enter Target Calories', state: ToastStates.ERROR);
                                            }
                                          },
                                          text: 'Confirm',
                                          context: context,
                                          background: defaultColor,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: defaultButton(
                                          function: () {
                                            Navigator.pop(context);
                                          },
                                          text: 'Cancel',
                                          context: context,
                                          background: defaultColor,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      ).show();
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}

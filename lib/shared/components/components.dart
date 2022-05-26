import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe/modules/search/search_screen.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:recipe/shared/network/local/cache_helper.dart';

import '../styles/colors.dart';
import '../styles/icon_broken.dart';

Widget defaultButton({
  double width = double.infinity,
  double elevation = 10,
  Color? background,
  double radius = 10.0,
  double textSize = 12.0,
  required var function,
  required String text,
  Color textColor = Colors.black,
  required BuildContext context,
  LinearGradient? gradient,
  bool buttonEnable = true,
}) =>
    Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          color: background,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 10),
          onPressed: function,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: textColor,
                  fontSize: textSize,
                ),
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  var onSubmit,
  var onTap,
  var onChanged,
  var suffixPressed,
  required var validate,
  required String? label,
  String? hintText,
  IconData? prefix,
  bool isClickable = true,
  IconData? suffix,
  bool showUnderLine = true,
}) =>
    TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: showUnderLine
              ? BorderSide(color: defaultColor)
              : BorderSide(color: defaultColor.withOpacity(0)),
        ),
        labelText: label,
        labelStyle: TextStyle(color: defaultColor.withOpacity(0.6)),
        hintText: hintText ?? '',
        prefixIcon: prefix != null
            ? Icon(
                prefix,
              )
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                  color: defaultColor,
                ),
                onPressed: suffixPressed,
              )
            : null,
        border: null,
      ),
      onTap: onTap,
      enabled: isClickable,
      validator: validate,
      onChanged: onChanged,
      keyboardType: type,
      controller: controller,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.center,
        duration: Duration(seconds: 1),
        child: widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.center,
        duration: Duration(seconds: 1),
        child: widget,
      ),
      (route) => false,
    );

Widget buildLayOutCard({
  required BuildContext context,
  required String image,
  required String text,
  required var function,
  bool networkImage = true,
}) =>
    InkWell(
      onTap: function,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: networkImage
                  ? NetworkImage(image) as ImageProvider
                  : AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                color: Colors.black.withOpacity(0.4),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

AppBar defaultAppBar({
  required String title,
  required BuildContext context,
}) =>
    AppBar(
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
      ),
      actions: [
        IconButton(
          onPressed: () {
            RecipesCubit.get(context).clearSearchModel();
            navigateTo(context, SearchScreen());
          },
          icon: const Icon(
            IconBroken.Search,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );

Widget buildMealCard({
  required BuildContext context,
  required String image,
  required String meal,
  required String mealId,
  required var function,
  bool fromDailyPlan = false,
}) =>
    BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) => InkWell(
        onTap: function,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            meal,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if(fromDailyPlan){
                              if (RecipesCubit.get(context)
                                  .favouritesDailyMeals
                                  .contains(mealId)) {
                                RecipesCubit.get(context)
                                    .removeFromFavouriteDailyMeals(mealId);
                              }else {
                                RecipesCubit.get(context).addToFavouriteDailyMeals(mealId);
                              }
                              CacheHelper.saveData(
                                  key: 'favouritesDailyMeals',
                                  value: RecipesCubit.get(context).favouritesDailyMeals);

                            } else {
                              if (RecipesCubit.get(context)
                                  .favourites
                                  .contains(mealId)) {
                                RecipesCubit.get(context)
                                    .removeFromFavourite(mealId);
                              } else {
                                RecipesCubit.get(context).addToFavourite(mealId);
                              }
                              CacheHelper.saveData(
                                  key: 'favourite',
                                  value: RecipesCubit.get(context).favourites);
                            }
                          },
                          icon: Icon(
                            IconBroken.Heart,
                            color: RecipesCubit.get(context)
                                    .favourites
                                    .contains(mealId) || RecipesCubit.get(context).favouritesDailyMeals.contains(mealId)
                                ? Colors.red
                                : Colors.black,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget buildMealPicCard({
  required BuildContext context,
  required String image,
  required String meal,
}) =>
    Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    meal,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 25,
                      color: Colors.black,
                        ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildHeaderCard({
  required BuildContext context,
  required String title,
  required String subTitle,
  required IconData icon,
}) =>
    Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.67,
              height: 50,
              decoration: BoxDecoration(
                color: defaultColor.shade500,
                borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(25),
                    bottomEnd: Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    subTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: defaultColor, fontSize: 12),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget buildMealItem({
  required BuildContext context,
  required List<String> texts,
  required String mealId,
  required String mealName,
  bool showIconButton = false,
}) {
  return BlocConsumer<RecipesCubit, RecipesStates>(
    listener: (context, state) {},
    builder: (context, state) {
      var cubit = RecipesCubit.get(context);
      cubit.clearIngredientsList();
      if (CacheHelper.getData(key: mealName) == null) {
        for (int i = 0; i < cubit.ingredients.length; i++) {
          cubit.addToIngredientsList('false');
        }
        CacheHelper.saveData(key: mealName, value: cubit.ingredientsList);
      } else {
        List ls = CacheHelper.getData(key: mealName);
        ls.forEach((element) {
          cubit.addToIngredientsList(element.toString());
        });
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: showIconButton
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (cubit.ingredientsList[index] == 'false') {
                            cubit.changeIngredientItem('true', index);
                            cubit.addToShopping(
                              item: texts[index],
                              mealName: mealName,
                              index: index,
                              len: texts.length,
                            );
                          } else {
                            cubit.changeIngredientItem('false', index);
                            cubit.removeFromShopping(
                              item: texts[index],
                              mealName: mealName,
                              index: index,
                              len: texts.length,
                            );
                          }
                          CacheHelper.removeData(key: mealName);
                          CacheHelper.saveData(
                              key: mealName, value: cubit.ingredientsList);
                        },
                        icon: Icon(
                          cubit.ingredientsList[index] == 'false'
                              ? IconBroken.Plus
                              : IconBroken.Bookmark,
                          color: defaultColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${texts[index]}.',
                          style: Theme.of(context).textTheme.bodyText1,
                          softWrap: true,
                        ),
                      ),
                    ],
                  )
                : Text(
                    '${texts[index]}${texts[index].isNotEmpty ? '.' : ''}',
                    style: Theme.of(context).textTheme.bodyText1,
                    softWrap: true,
                    textAlign: TextAlign.justify,
                  ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(),
        itemCount: texts.length,
      );
    },
  );
}

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: '${text}',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      webPosition: 'center',
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}

Widget buildDrawerItem({
  required BuildContext context,
  required IconData icon,
  required String title,
  required var function,
}) =>
    InkWell(
      onTap: function,
      child: Card(
        elevation: 3,
        child: Container(
          height: 50,
          color: defaultColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/models/area_model.dart';
import 'package:recipe/models/categories_model.dart';
import 'package:recipe/models/daily_data_model.dart';
import 'package:recipe/models/daily_model.dart';
import 'package:recipe/models/latest_model.dart';
import 'package:recipe/models/meal_model.dart';
import 'package:recipe/models/question_model.dart';
import 'package:recipe/modules/favourite/favourite_screen.dart';
import 'package:recipe/modules/home/home_screen.dart';
import 'package:recipe/modules/shopping/shopping_screen.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:recipe/shared/network/end_point.dart';
import 'package:recipe/shared/network/local/cache_helper.dart';
import 'package:recipe/shared/styles/colors.dart';
import 'package:recipe/shared/styles/icon_broken.dart';

import '../../modules/meal/meal_screen.dart';
import '../components/components.dart';
import '../components/constants.dart';
import '../network/remote/dio_helper.dart';

class RecipesCubit extends Cubit<RecipesStates> {
  RecipesCubit() : super(RecipesInitialState());

  static RecipesCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Heart,
      ),
      label: 'Favourite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Bag,
      ),
      label: 'Shopping',
    ),
  ];

  List<Widget> screens = [
    HomeScreen(),
    FavouriteScreen(),
    ShoppingScreen(),
  ];

  List<String> titles = [
    'Yummly',
    'Favourite',
    'Shopping',
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(RecipesBottomNavState());
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(RecipesLoadingGetCategoriesState());

    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(RecipesSuccessGetCategoriesState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetCategoriesState(error.toString()));
    });
  }

  AreasModel? areasModel;

  void getAreasData() {
    emit(RecipesLoadingGetAreasState());

    DioHelper.getData(
      url: AREAS,
    ).then((value) {
      areasModel = AreasModel.fromJson(value.data);
      emit(RecipesSuccessGetAreasState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetAreasState(error.toString()));
    });
  }

  LatestModel? latestModel;

  void getLatestData() {
    emit(RecipesLoadingGetLatestState());

    DioHelper.getData(
      url: LATEST,
    ).then((value) {
      latestModel = LatestModel.fromJson(value.data);
      emit(RecipesSuccessGetLatestState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetLatestState(error.toString()));
    });
  }

  LatestModel? filterByCategoryModel;

  void getFilterByCategoryData(String url) {
    emit(RecipesLoadingGetFilterByCategoryState());

    DioHelper.getData(
      url: '$FILTERBYCATEGORY$url',
    ).then((value) {
      filterByCategoryModel = LatestModel.fromJson(value.data);
      emit(RecipesSuccessGetFilterByCategoryState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetFilterByCategoryState(error.toString()));
    });
  }

  LatestModel? filterByAreaModel;

  void getFilterByAreaData(String url) {
    emit(RecipesLoadingGetFilterByAreaState());

    DioHelper.getData(
      url: '$FILTERBYAREA$url',
    ).then((value) {
      filterByAreaModel = LatestModel.fromJson(value.data);
      emit(RecipesSuccessGetFilterByAreaState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetFilterByAreaState(error.toString()));
    });
  }

  MealModel? mealModel;
  List<String> instructions = [];
  List<String> ingredients = [];

  void getMealDetailsData(String url) {
    emit(RecipesLoadingGetMealDetailsState());

    DioHelper.getData(
      url: '$MEALDETAILS$url',
    ).then((value) {
      mealModel = MealModel.fromJson(value.data);
      instructions = mealModel!.meals[0].strInstructions!.split('.');
      ingredients = [];
      for (int i = 0; i < mealModel!.meals[0].ingredients.length; i++) {
        ingredients.add(
            '${mealModel!.meals[0].measures[i]} ${mealModel!.meals[0].ingredients[i]}');
      }
      emit(RecipesSuccessGetMealDetailsState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetMealDetailsState(error.toString()));
    });
  }

  List<Widget> latestList = [];
  List<Widget> areaList = [];
  List<Widget> categoryList = [];

  void addLatestToList({
    required BuildContext context,
  }) {
    latestList = [];
    int len = latestModel!.meals.length % 2 == 0
        ? latestModel!.meals.length
        : latestModel!.meals.length - 1;
    for (int i = 0; i < len; i++) {
      latestList.add(Row(
        children: [
          Expanded(
            child: buildMealCard(
              context: context,
              image: latestModel!.meals[i].strMealThumb!,
              meal: latestModel!.meals[i].strMeal!,
              mealId: latestModel!.meals[i].idMeal!,
              function: () {
                getMealDetailsData(latestModel!.meals[i - 1].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
          Expanded(
            child: buildMealCard(
              context: context,
              image: latestModel!.meals[i + 1].strMealThumb!,
              meal: latestModel!.meals[i + 1].strMeal!,
              mealId: latestModel!.meals[i + 1].idMeal!,
              function: () {
                getMealDetailsData(latestModel!.meals[i].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
        ],
      ));
      i += 1;
    }
    if (latestModel!.meals.length % 2 == 1) {
      latestList.add(Row(
        children: [
          Expanded(
            child: buildMealCard(
              context: context,
              image: latestModel!
                  .meals[latestModel!.meals.length - 1].strMealThumb!,
              meal: latestModel!.meals[latestModel!.meals.length - 1].strMeal!,
              mealId: latestModel!.meals[latestModel!.meals.length - 1].idMeal!,
              function: () {
                getMealDetailsData(
                    latestModel!.meals[latestModel!.meals.length - 2].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
        ],
      ));
    }
    emit(RecipesSuccessAddLatestToListState());
  }

  void addAreaToList({
    required BuildContext context,
  }) {
    areaList = [];
    int len = filterByAreaModel!.meals.length % 2 == 0
        ? filterByAreaModel!.meals.length
        : filterByAreaModel!.meals.length - 1;
    for (int i = 0; i < len; i++) {
      areaList.add(Row(
        children: [
          Expanded(
            child: buildMealCard(
              context: context,
              image: filterByAreaModel!.meals[i].strMealThumb!,
              meal: filterByAreaModel!.meals[i].strMeal!,
              mealId: filterByAreaModel!.meals[i].idMeal!,
              function: () {
                getMealDetailsData(filterByAreaModel!.meals[i - 1].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
          Expanded(
            child: buildMealCard(
              context: context,
              image: filterByAreaModel!.meals[i + 1].strMealThumb!,
              meal: filterByAreaModel!.meals[i + 1].strMeal!,
              mealId: filterByAreaModel!.meals[i + 1].idMeal!,
              function: () {
                getMealDetailsData(filterByAreaModel!.meals[i].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
        ],
      ));
      i += 1;
    }
    if (filterByAreaModel!.meals.length % 2 == 1) {
      areaList.add(Row(
        children: [
          Expanded(
            child: buildMealCard(
              context: context,
              image: filterByAreaModel!
                  .meals[filterByAreaModel!.meals.length - 1].strMealThumb!,
              meal: filterByAreaModel!
                  .meals[filterByAreaModel!.meals.length - 1].strMeal!,
              mealId: filterByAreaModel!
                  .meals[filterByAreaModel!.meals.length - 1].idMeal!,
              function: () {
                getMealDetailsData(filterByAreaModel!
                    .meals[filterByAreaModel!.meals.length - 2].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
        ],
      ));
    }
    emit(RecipesSuccessAddAreaToListState());
  }

  void addCategoryToList({
    required BuildContext context,
  }) {
    categoryList = [];
    int len = filterByCategoryModel!.meals.length % 2 == 0
        ? filterByCategoryModel!.meals.length
        : filterByCategoryModel!.meals.length - 1;
    for (int i = 0; i < len; i++) {
      categoryList.add(Row(
        children: [
          Expanded(
            child: buildMealCard(
              context: context,
              image: filterByCategoryModel!.meals[i].strMealThumb!,
              meal: filterByCategoryModel!.meals[i].strMeal!,
              mealId: filterByCategoryModel!.meals[i].idMeal!,
              function: () {
                getMealDetailsData(filterByCategoryModel!.meals[i - 1].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
          Expanded(
            child: buildMealCard(
              context: context,
              image: filterByCategoryModel!.meals[i + 1].strMealThumb!,
              meal: filterByCategoryModel!.meals[i + 1].strMeal!,
              mealId: filterByCategoryModel!.meals[i + 1].idMeal!,
              function: () {
                getMealDetailsData(filterByCategoryModel!.meals[i].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
        ],
      ));
      i += 1;
    }
    if (filterByCategoryModel!.meals.length % 2 == 1) {
      categoryList.add(Row(
        children: [
          Expanded(
            child: buildMealCard(
              context: context,
              image: filterByCategoryModel!
                  .meals[filterByCategoryModel!.meals.length - 1].strMealThumb!,
              meal: filterByCategoryModel!
                  .meals[filterByCategoryModel!.meals.length - 1].strMeal!,
              mealId: filterByCategoryModel!
                  .meals[filterByCategoryModel!.meals.length - 1].idMeal!,
              function: () {
                getMealDetailsData(filterByCategoryModel!
                    .meals[filterByCategoryModel!.meals.length - 2].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
        ],
      ));
    }
    emit(RecipesSuccessAddCategoryToListState());
  }

  List<String> favourites = [];

  void getFavourites() {
    favourites = [];
    favouriteMeals = [];
    List list = [];
    if (CacheHelper.getData(key: 'favourite') != null) {
      list = CacheHelper.getData(key: 'favourite');
    }
    list.forEach((element) {
      favourites.add(element.toString());
      getFavouriteMealsData(element.toString());
    });
    emit(RecipesGetFavouriteState());
  }

  void addToFavourite(String mealId) {
    favourites.add(mealId);
    getFavouriteMealsData(mealId);
    emit(RecipesAddToFavouriteState());
  }

  void removeFromFavourite(String mealId) {
    favourites.remove(mealId);
    favouriteMeals.removeWhere((element) => element.meals[0].idMeal == mealId);
    emit(RecipesRemoveFromFavouriteState());
  }

  LatestModel? favouriteModel;
  List<LatestModel> favouriteMeals = [];

  void getFavouriteMealsData(String url) {
    emit(RecipesLoadingGetFavouriteMealsDataState());

    DioHelper.getData(
      url: '$MEALDETAILS$url',
    ).then((value) {
      favouriteModel = LatestModel.fromJson(value.data);
      favouriteMeals.add(favouriteModel!);
      emit(RecipesSuccessGetFavouriteMealsDataState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetFavouriteMealsDataState(error.toString()));
    });
  }

  List<String> ingredientsList = [];

  void addToIngredientsList(String ingredientsItem) {
    ingredientsList.add(ingredientsItem);
    //emit(RecipesAddToIngredientsListState());
  }

  void changeIngredientItem(String newValue, int index) {
    ingredientsList[index] = newValue;
    emit(RecipesChangeIngredientItemState());
  }

  void clearIngredientsList() {
    ingredientsList = [];
    //emit(RecipesClearIngredientsListState());
  }

  Map<String, List<String>> shoppingItems = {};

  void addToShopping({
    required String item,
    required String mealName,
    int? index,
    int? len,
    bool isPersonal = false,
  }) {
    if(isPersonal){
      if(shoppingItems[mealName] != null){
        shoppingItems[mealName]!.add(item);
      } else{
        shoppingItems.addAll({mealName: []});
        shoppingItems[mealName]!.add(item);
      }
    } else {
      if (shoppingItems[mealName] != null) {
        shoppingItems[mealName]![index!] = item;
      } else {
        shoppingItems.addAll({mealName: []});
        for (int i = 0; i < len!; i++) {
          shoppingItems[mealName]!.add('false');
        }
        shoppingItems[mealName]![index!] = item;
      }
    }
    saveShoppingList();
  }

  void removeFromShopping({
    required String item,
    required String mealName,
    int? index,
    int? len,
    bool isPersonal = false,
}) {
    if(isPersonal){
      shoppingItems[mealName]!.remove(item);
      if(shoppingItems[mealName]!.isEmpty){
        removeMealFromShopping(mealName);
      }
    } else {
      shoppingItems[mealName]![index!] = 'false';
      int count = 0;
      for (int i = 0; i < len!; i++) {
        if (shoppingItems[mealName]![i] != 'false') {
          count++;
        }
      }
      if (count == 0) {
        removeMealFromShopping(mealName);
      }
    }
    saveShoppingList();
  }

  void removeMealFromShopping(String mealName) {
    shoppingItems.removeWhere((key, value) => key == mealName);
    emit(RecipesRemoveMealFromShoppingState());
  }

  void getShoppingList() {
    shoppingItems = {};
    if (CacheHelper.getData(key: 'shoppingList') != null) {
      List list = CacheHelper.getData(key: 'shoppingList');
      bool isMeal = false;
      String? mealId;
      list.forEach((element) {
        if (element.toString() == 'mealName') {
          isMeal = true;
        }
        if (isMeal && element.toString() != 'mealName') {
          isMeal = false;
          mealId = element.toString();
          shoppingItems.addAll({element.toString(): []});
        }
        if (!isMeal && element.toString() != mealId) {
          shoppingItems[mealId]!.add(element.toString());
        }
      });
    }
    emit(RecipesGetShoppingState());
  }

  void saveShoppingList() {
    List<String> list = [];
    shoppingItems.forEach((key, value) {
      list.add('mealName');
      list.add(key);
      value.forEach((element) {
        list.add(element.toString());
      });
    });
    CacheHelper.removeData(key: 'shoppingList');
    CacheHelper.saveData(key: 'shoppingList', value: list);
    emit(RecipesSaveShoppingState());
  }

  LatestModel? searchModel;

  void getSearchData(String url) {
    emit(RecipesLoadingGetSearchDataState());

    DioHelper.getData(
      url: '$SEARCH$url',
    ).then((value) {
      searchModel = LatestModel.fromJson(value.data);
      emit(RecipesSuccessGetSearchDataState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetSearchDataState(error.toString()));
    });
  }

  void clearSearchModel () {
    searchModel = null;
    emit(RecipesClearSearchModelState());
  }

  void getRandomMealData() {
    emit(RecipesLoadingGetRandomMealState());

    DioHelper.getData(
      url: RANDOM,
    ).then((value) {
      mealModel = MealModel.fromJson(value.data);
      instructions = mealModel!.meals[0].strInstructions!.split('.');
      ingredients = [];
      for (int i = 0; i < mealModel!.meals[0].ingredients.length; i++) {
        ingredients.add(
            '${mealModel!.meals[0].measures[i]} ${mealModel!.meals[0].ingredients[i]}');
      }
      emit(RecipesSuccessGetRandomMealState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetRandomMealState(error.toString()));
    });
  }

  LatestModel? randomMealsModel;

  void getRandomMealsData(BuildContext context) {
    emit(RecipesLoadingGetRandomMealsState());

    DioHelper.getData(
      url: RANDOMS,
    ).then((value) {
      randomMealsModel = LatestModel.fromJson(value.data);
      addRandomToList(context: context);
      emit(RecipesSuccessGetRandomMealsState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetRandomMealsState(error.toString()));
    });
  }

  List<Widget> randomMealsList = [];

  void addRandomToList({
    required BuildContext context,
  }) {
    randomMealsList = [];
    int len = randomMealsModel!.meals.length % 2 == 0
        ? randomMealsModel!.meals.length
        : randomMealsModel!.meals.length - 1;
    for (int i = 0; i < len; i++) {
      randomMealsList.add(Row(
        children: [
          Expanded(
            child: buildMealCard(
              context: context,
              image: randomMealsModel!.meals[i].strMealThumb!,
              meal: randomMealsModel!.meals[i].strMeal!,
              mealId: randomMealsModel!.meals[i].idMeal!,
              function: () {
                getMealDetailsData(randomMealsModel!.meals[i - 1].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
          Expanded(
            child: buildMealCard(
              context: context,
              image: randomMealsModel!.meals[i + 1].strMealThumb!,
              meal: randomMealsModel!.meals[i + 1].strMeal!,
              mealId: randomMealsModel!.meals[i + 1].idMeal!,
              function: () {
                getMealDetailsData(randomMealsModel!.meals[i].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
        ],
      ));
      i += 1;
    }
    if (randomMealsModel!.meals.length % 2 == 1) {
      randomMealsList.add(Row(
        children: [
          Expanded(
            child: buildMealCard(
              context: context,
              image: randomMealsModel!
                  .meals[randomMealsModel!.meals.length - 1].strMealThumb!,
              meal: randomMealsModel!.meals[randomMealsModel!.meals.length - 1].strMeal!,
              mealId: randomMealsModel!.meals[randomMealsModel!.meals.length - 1].idMeal!,
              function: () {
                getMealDetailsData(
                    randomMealsModel!.meals[randomMealsModel!.meals.length - 2].idMeal!);
                navigateTo(context, MealScreen());
              },
            ),
          ),
        ],
      ));
    }
    emit(RecipesSuccessAddRandomToListState());
  }

  Color? color;

  void changeDefaultColor(){
    defaultColor = buildMaterialColor(color!);
    CacheHelper.saveData(key: 'defaultColor', value: defaultColor.value).then((value) => emit(RecipesSuccessChangeDefaultColorState()));
  }

  void changeAppMode(){
    isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) => emit(RecipesChangeModeState()));
  }

  QuestionModel? answerModel;

  void getAnswerData(String question) {
    emit(RecipesLoadingGetAnswerDataState());

    DioHelper.getSideData(
      url: '$ANSWER$question',
    ).then((value) {
      answerModel = QuestionModel.fromJson(value.data);
      emit(RecipesSuccessGetAnswerDataState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetAnswerDataState(error.toString()));
    });
  }

  DailyModel? dailyModel;
  void getDailyData(double calories) {
    dailyDataModelList = [];
    emit(RecipesLoadingGetDailyDataState());

    DioHelper.getSideData(
      url: '$DAILY$calories',
    ).then((value) {
      dailyModel = DailyModel.fromJson(value.data);
      CacheHelper.saveData(key: 'calories', value: dailyModel!.nutrients!.calories.toString(),);
      CacheHelper.saveData(key: 'protein', value: dailyModel!.nutrients!.protein.toString(),);
      CacheHelper.saveData(key: 'fat', value: dailyModel!.nutrients!.fat.toString(),);
      CacheHelper.saveData(key: 'carbohydrates', value: dailyModel!.nutrients!.carbohydrates.toString(),);
      emit(RecipesSuccessGetDailyDataState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetDailyDataState(error.toString()));
    });
  }

  DailyDataModel? dailyDataModel;
  List<DailyDataModel> dailyDataModelList = [];

  void getDailyMealsData(int mealId) {
    emit(RecipesLoadingGetDailyMealsDataState());

    DioHelper.getSideData(
      url: '$DAILYMEALSDATA$mealId/information',
    ).then((value) {
      dailyDataModel = DailyDataModel.fromJson(value.data);
      dailyDataModelList.add(dailyDataModel!);
      if(dailyDataModelList.length == 3){
        CacheHelper.saveData(key: 'dailyMeals', value: [
          dailyDataModelList[0].id.toString(),
          dailyDataModelList[1].id.toString(),
          dailyDataModelList[2].id.toString(),
        ]);
      }
      emit(RecipesSuccessGetDailyMealsDataState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetDailyMealsDataState(error.toString()));
    });
  }

  void getLastDailyMeals(){
    dailyDataModelList = [];
    if(CacheHelper.getData(key: 'dailyMeals') != null){
      List list = CacheHelper.getData(key: 'dailyMeals');
      list.forEach((element) {
        getDailyMealsData(int.parse(element));
        print(element);
      });
    }
  }

  List<String> favouritesDailyMeals = [];

  void getFavouritesDailyMeals() {
    favouritesDailyMeals = [];
    favouriteDailyMealsList = [];
    List list = [];
    if (CacheHelper.getData(key: 'favouritesDailyMeals') != null) {
      list = CacheHelper.getData(key: 'favouritesDailyMeals');
    }
    list.forEach((element) {
      favouritesDailyMeals.add(element.toString());
      getFavouriteDailyMealsData(element.toString());
    });
    print(list);
    emit(RecipesGetFavouriteState());
  }

  void addToFavouriteDailyMeals(String mealId) {
    favouritesDailyMeals.add(mealId);
    getFavouriteDailyMealsData(mealId);
    emit(RecipesAddToFavouriteState());
  }

  void removeFromFavouriteDailyMeals(String mealId) {
    favouritesDailyMeals.remove(mealId);
    favouriteDailyMealsList.removeWhere((element) => element.id.toString() == mealId);
    emit(RecipesRemoveFromFavouriteState());
  }

  DailyDataModel? favouriteDailyDataModel;
  List<DailyDataModel> favouriteDailyMealsList = [];

  void getFavouriteDailyMealsData(String mealId) {
    emit(RecipesLoadingGetFavouriteMealsDataState());

    DioHelper.getSideData(
      url: '$DAILYMEALSDATA$mealId/information',
    ).then((value) {
      favouriteDailyDataModel = DailyDataModel.fromJson(value.data);
      favouriteDailyMealsList.add(favouriteDailyDataModel!);
      emit(RecipesSuccessGetFavouriteMealsDataState());
    }).catchError((error) {
      print(error);
      emit(RecipesErrorGetFavouriteMealsDataState(error.toString()));
    });
  }
}
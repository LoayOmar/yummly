abstract class RecipesStates {}

class RecipesInitialState extends RecipesStates {}

class RecipesBottomNavState extends RecipesStates {}

class RecipesAddToIngredientsListState extends RecipesStates {}

class RecipesChangeIngredientItemState extends RecipesStates {}

class RecipesClearIngredientsListState extends RecipesStates {}

class RecipesAddToFavouriteState extends RecipesStates {}

class RecipesGetFavouriteState extends RecipesStates {}

class RecipesGetShoppingState extends RecipesStates {}

class RecipesSaveShoppingState extends RecipesStates {}

class RecipesRemoveMealFromShoppingState extends RecipesStates {}

class RecipesRemoveFromFavouriteState extends RecipesStates {}

class RecipesLoadingGetCategoriesState extends RecipesStates {}

class RecipesSuccessGetCategoriesState extends RecipesStates {}

class RecipesErrorGetCategoriesState extends RecipesStates {
  String error;

  RecipesErrorGetCategoriesState(this.error);
}
class RecipesLoadingGetAreasState extends RecipesStates {}

class RecipesSuccessGetAreasState extends RecipesStates {}

class RecipesErrorGetAreasState extends RecipesStates {
  String error;

  RecipesErrorGetAreasState(this.error);
}
class RecipesLoadingGetLatestState extends RecipesStates {}

class RecipesSuccessGetLatestState extends RecipesStates {}

class RecipesErrorGetLatestState extends RecipesStates {
  String error;

  RecipesErrorGetLatestState(this.error);
}

class RecipesLoadingGetFilterByCategoryState extends RecipesStates {}

class RecipesSuccessGetFilterByCategoryState extends RecipesStates {}

class RecipesErrorGetFilterByCategoryState extends RecipesStates {
  String error;

  RecipesErrorGetFilterByCategoryState(this.error);
}

class RecipesLoadingGetFilterByAreaState extends RecipesStates {}

class RecipesSuccessGetFilterByAreaState extends RecipesStates {}

class RecipesErrorGetFilterByAreaState extends RecipesStates {
  String error;

  RecipesErrorGetFilterByAreaState(this.error);
}

class RecipesLoadingGetFavouriteMealsDataState extends RecipesStates {}

class RecipesSuccessGetFavouriteMealsDataState extends RecipesStates {}

class RecipesErrorGetFavouriteMealsDataState extends RecipesStates {
  String error;

  RecipesErrorGetFavouriteMealsDataState(this.error);
}

class RecipesLoadingGetMealDetailsState extends RecipesStates {}

class RecipesSuccessGetMealDetailsState extends RecipesStates {}

class RecipesErrorGetMealDetailsState extends RecipesStates {
  String error;

  RecipesErrorGetMealDetailsState(this.error);
}

class RecipesLoadingGetRandomMealState extends RecipesStates {}

class RecipesSuccessGetRandomMealState extends RecipesStates {}

class RecipesErrorGetRandomMealState extends RecipesStates {
  String error;

  RecipesErrorGetRandomMealState(this.error);
}

class RecipesChangeModeState extends RecipesStates {}

class RecipesSuccessAddRandomToListState extends RecipesStates {}

class RecipesSuccessChangeDefaultColorState extends RecipesStates {}

class RecipesLoadingGetRandomMealsState extends RecipesStates {}

class RecipesSuccessGetRandomMealsState extends RecipesStates {}

class RecipesErrorGetRandomMealsState extends RecipesStates {
  String error;

  RecipesErrorGetRandomMealsState(this.error);
}

class RecipesSuccessAddLatestToListState extends RecipesStates {}

class RecipesSuccessAddAreaToListState extends RecipesStates {}

class RecipesSuccessAddCategoryToListState extends RecipesStates {}

class RecipesClearSearchModelState extends RecipesStates {}

class RecipesLoadingGetSearchDataState extends RecipesStates {}

class RecipesSuccessGetSearchDataState extends RecipesStates {}

class RecipesErrorGetSearchDataState extends RecipesStates {
  String error;

  RecipesErrorGetSearchDataState(this.error);
}

class RecipesLoadingGetAnswerDataState extends RecipesStates {}

class RecipesSuccessGetAnswerDataState extends RecipesStates {}

class RecipesErrorGetAnswerDataState extends RecipesStates {
  String error;

  RecipesErrorGetAnswerDataState(this.error);
}

class RecipesLoadingGetDailyDataState extends RecipesStates {}

class RecipesSuccessGetDailyDataState extends RecipesStates {}

class RecipesErrorGetDailyDataState extends RecipesStates {
  String error;

  RecipesErrorGetDailyDataState(this.error);
}

class RecipesLoadingGetDailyMealsDataState extends RecipesStates {}

class RecipesSuccessGetDailyMealsDataState extends RecipesStates {}

class RecipesErrorGetDailyMealsDataState extends RecipesStates {
  String error;

  RecipesErrorGetDailyMealsDataState(this.error);
}
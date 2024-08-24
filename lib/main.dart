import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/http_overrides.dart';
import 'package:recipe/shared/bloc_observer.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:recipe/shared/network/local/cache_helper.dart';
import 'package:recipe/shared/network/remote/dio_helper.dart';
import 'package:recipe/shared/styles/colors.dart';

import 'modules/onboarding/onboarding_screen.dart';
import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  DioHelper.init();

  DioHelper.sideInit();

  isDark = CacheHelper.getData(key: 'isDark') ?? isDark;

  defaultColor = buildMaterialColor(Color(CacheHelper.getData(key: 'defaultColor')??defaultColor.value));

  HttpOverrides.global = MyHttpOverrides();

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipesCubit()..getFavourites()..getShoppingList()..getCategoriesData()..getAreasData()..getLatestData()..getLastDailyMeals()..getFavouritesDailyMeals(),
      child: BlocConsumer<RecipesCubit, RecipesStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: defaultColor,
            drawerTheme: DrawerThemeData(
              backgroundColor: defaultColor.shade50,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.grey,
              elevation: 20,
            ),
            textTheme: TextTheme(
              bodyLarge: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              headlineLarge: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade50,
              ),
              labelLarge: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            fontFamily: 'Jannah',
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            drawerTheme: const DrawerThemeData(
              backgroundColor: Colors.black54,
            ),
            primarySwatch: defaultColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.white,
              elevation: 20,
            ),
            textTheme: TextTheme(
              bodyLarge: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              headlineLarge: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade50,
              ),
              labelLarge: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            fontFamily: 'Jannah',
            useMaterial3: true,
          ),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: OnBoardingScreen(),
        ),
      ),
    );
  }
}

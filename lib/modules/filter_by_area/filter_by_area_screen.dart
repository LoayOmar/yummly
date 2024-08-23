import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:recipe/shared/styles/colors.dart';


class FilterByAreaScreen extends StatelessWidget {
  final String title;

  const FilterByAreaScreen({Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);

        if( state is RecipesSuccessGetFilterByAreaState){
          cubit.addAreaToList(context: context);
        }

        return Scaffold(
          appBar: defaultAppBar(title: title, context: context),
          body: state is RecipesLoadingGetFilterByAreaState || cubit.areaList.isEmpty ? Center(
            child: CircularProgressIndicator(color: defaultColor,),
          ) : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            itemBuilder: (context, index) {
              return cubit.areaList[index];
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: cubit.areaList.length,
          ),
        );
      },
    );
  }
}

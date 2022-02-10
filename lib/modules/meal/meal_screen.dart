import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:recipe/shared/network/local/cache_helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class MealScreen extends StatelessWidget {
  YoutubePlayerController? _controller;
  YoutubeMetaData? _videoMetaData;

  bool _isPlayerReady = false;
  PlayerState? _playerState;

  var videoId;

  void listener() {
    if(_isPlayerReady && !_controller!.value.isFullScreen){
      _playerState = _controller!.value.playerState;
      _videoMetaData = _controller!.metadata;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {
        if(state is RecipesSuccessGetMealDetailsState || state is RecipesSuccessGetRandomMealState){
          _controller = YoutubePlayerController(
            initialVideoId: videoId = YoutubePlayer.convertUrlToId(RecipesCubit.get(context).mealModel!.meals[0].strYoutube!)!,
            flags: const YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
              loop: false,
              isLive: false,
              forceHD: false,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);

        return state is RecipesLoadingGetMealDetailsState || state is RecipesLoadingGetRandomMealState
            ? Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                      cubit.mealModel!.meals[0].strMeal!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
                  ),
                ),
                body: ListView(
                  padding: const EdgeInsets.only(bottom: 20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    buildMealPicCard(
                      context: context,
                      image: cubit.mealModel!.meals[0].strMealThumb!,
                      meal: cubit.mealModel!.meals[0].strMeal!,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildHeaderCard(
                      context: context,
                      title: 'Ingredients Required',
                      subTitle:
                          '${cubit.mealModel!.meals[0].ingredients.length} Items',
                      icon: IconBroken.Document,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildMealItem(
                      context: context,
                      texts: cubit.ingredients,
                      mealId: cubit.mealModel!.meals[0].idMeal!,
                      mealName: cubit.mealModel!.meals[0].strMeal!,
                      showIconButton: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildHeaderCard(
                      context: context,
                      title: 'Direction to Prepare',
                      subTitle:
                          '${cubit.mealModel!.meals[0].ingredients.length} Steps',
                      icon: IconBroken.Arrow___Down_Circle,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildMealItem(
                      context: context,
                      texts: cubit.instructions,
                      mealId: cubit.mealModel!.meals[0].idMeal!,
                      mealName: cubit.mealModel!.meals[0].strMeal!,
                      showIconButton: false,
                    ),
                    buildHeaderCard(
                      context: context,
                      title: 'Watch the Video',
                      subTitle: '',
                      icon: IconBroken.Video,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 15,
                        child:Container(
                          height: 250,
                          child: YoutubePlayer(
                            controller: _controller!,
                            aspectRatio: 16/9,
                            showVideoProgressIndicator: true,
                            progressColors: const ProgressBarColors(
                              playedColor: Colors.white,
                              handleColor: Colors.white,
                            ),
                            onReady: (){_controller!.addListener(listener);},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

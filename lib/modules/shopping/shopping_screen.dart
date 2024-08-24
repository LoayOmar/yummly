import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/shared/components/components.dart';
import 'package:recipe/shared/cubit/cubit.dart';
import 'package:recipe/shared/cubit/states.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class ShoppingScreen extends StatelessWidget {
  TextEditingController itemController = TextEditingController();

  ShoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipesCubit.get(context);

        List<String> mealName = [];
        List<List<String>> items = [];
        cubit.shoppingItems.forEach((key, value) {
          List<String> list = [];
          mealName.add(key);
          for (var element in value) {
            list.add(element.toString());
          }
          items.add(list);
        });

        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 10),
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mealName[index],
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, idx) {
                            return Row(
                              children: [
                                if (items[index][idx] != 'false')
                                  IconButton(
                                    onPressed: () {
                                      cubit.removeFromShopping(
                                          item: items[index][idx],
                                          mealName: mealName[index],
                                          index: idx,
                                          len: items[index].length,
                                      );
                                      items[index][idx] = 'false';
                                      List<String> list = [];
                                      for (int i = 0;
                                          i < items[index].length;
                                          i++) {
                                        if (items[index][i] == 'false') {
                                          list.add('false');
                                        } else {
                                          list.add('true');
                                        }
                                      }
                                      CacheHelper.removeData(
                                          key: mealName[index]);
                                      CacheHelper.saveData(
                                          key: mealName[index], value: list);
                                    },
                                    icon: Icon(
                                      IconBroken.Bookmark,
                                      color: defaultColor,
                                    ),
                                  ),
                                if (items[index][idx] != 'false')
                                  Expanded(
                                    child: Text(
                                      items[index][idx],
                                      style:
                                          Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                                      softWrap: true,
                                    ),
                                  ),
                              ],
                            );
                          },
                          separatorBuilder: (context, idx) => const SizedBox(),
                          itemCount: items[index].length,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(),
            itemCount: cubit.shoppingItems.length,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.noHeader,
                  body: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      children: [
                        Container(
                          child: defaultTextFormField(
                            controller: itemController,
                            type: TextInputType.text,
                            validate: (value) {},
                            label: 'Enter Shopping Item',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: defaultButton(
                              function: () {
                                if(itemController.text.isEmpty){
                                  showToast(text: 'Enter Item Name', state: ToastStates.ERROR);
                                } else {
                                  cubit.addToShopping(item: itemController.text, mealName: 'Personal Shopping List', isPersonal: true);
                                  showToast(text: '${itemController.text} Added To Personal Shopping List', state: ToastStates.SUCCESS);
                                  itemController.clear();
                                  Navigator.pop(context);
                                }
                              },
                              background: defaultColor.shade500,
                              textColor: Colors.white,
                              text: 'Add',
                              context: context,
                              elevation: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).show();
            },
            child: const Icon(IconBroken.Plus),
          ),
        );
      },
    );
  }
}

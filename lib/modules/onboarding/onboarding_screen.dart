import 'package:flutter/material.dart';
import 'package:animated_switch/animated_switch.dart';
import 'package:recipe/layout/recipe_layout.dart';
import 'package:recipe/shared/components/components.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/onboarding.jpg'),
            fit: BoxFit.cover,
          )),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.65),
                      Colors.black.withOpacity(0),
                    ]
                  )
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Cooking Experience Like a Chef',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        'Let\'s make a delicious dish with the best recipe for the family',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Container(
                        width: 210,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.lightGreen,
                        ),
                        child: AnimatedSwitch(
                          width: 200,
                          height: 45,
                          textOff: 'Get Started',
                          textOn: 'Welcome Chef',
                          colorOff: Colors.lightGreen,
                          colorOn: Colors.lightGreen,
                          iconOn: Icons.arrow_forward,
                          iconOff: Icons.check,
                          animationDuration: Duration(milliseconds: 600),
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          onChanged : (value){
                            if(value == true){
                              Future.delayed(
                                const Duration(milliseconds: 800),
                                  (){
                                    navigateAndFinish(context, RecipeLayOut());
                                  }
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

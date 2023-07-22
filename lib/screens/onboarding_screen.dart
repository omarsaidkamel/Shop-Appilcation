import 'package:flutter/material.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/tools/Sharedpreferencesclass.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../tools/default_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  int pageIndicatorIndex = 0;
void tologin(){
  sharedpreferencesshop.saveData(key: 'onboarding', value: true).then((value) {
    if(value!){
      goWithOutBack(
        context: context,
        widget: const LoginScreen(),
      );
    }
  });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                  onPressed: tologin,
                  child:const Text(
                    'Skip',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.7,
                    width: MediaQuery.of(context).size.width,
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        onBoardingPage(image: 'image/3916903.jpg',context: context),
                        onBoardingPage(image: 'image/4036890.jpg',context: context),
                        onBoardingPage(image: 'image/4058271.jpg',context: context),
                      ],
                    ),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmoothPageIndicator(
                          onDotClicked: (x){
                            pageController.animateToPage(
                              x,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                            pageIndicatorIndex = x;
                            setState(() {

                            });
                          },
                          controller: pageController,
                          count: 3,
                          axisDirection: Axis.horizontal,
                          effect:const ExpandingDotsEffect(
                            activeDotColor: Colors.deepOrange,
                            dotHeight: 20,
                            dotWidth: 20,
                          ),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          onPressed: (){
                            if(pageIndicatorIndex == 2){
                              tologin();
                            }
                            else {
                              setState(() {
                                pageIndicatorIndex++;
                              });
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            }
                          },
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/modules/login/shop_login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/color.dart';



class BoardingModel
{
  final String image;
  final String body;
  final String title;


  BoardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding =
  [
    BoardingModel(
      image: 'assets/images/b1.jpeg',
      body: 'Best Shopping',
      title: 'Welcome to our shopping Application',
    ),
    BoardingModel(
      image: 'assets/images/boarding2.jpg',
      body: 'New products',
      title: 'All Products with high quality ',
    ),
    BoardingModel(
      image: 'assets/images/boarding10.jpg',
      body: 'Good services',
      title: 'Make sure you will enjoy with us ',
    ),
  ];

  var boardingController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            Function: submit,
            isUpperCase: true,
            text: 'skip',
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context , index)
                {
                  return buildBoardingItem(boarding[index]);
                },
                itemCount: 3,
                onPageChanged: (index)
                {
                  if(index == boarding.length-1)
                  {
                    setState(() {
                      isLast = true;
                    });

                  }
                  else
                  {
                    setState(() {
                      isLast = false;
                    });

                  }

                },
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect:  const ExpandingDotsEffect(
                      spacing: 4.0,
                      dotHeight: 11.0,
                      dotWidth: 14.0,
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      expansionFactor: 4.0

                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if (isLast == true)
                    {
                      submit();
                    }
                    else
                    {
                      boardingController.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.decelerate,
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

  Widget buildBoardingItem(BoardingModel model)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child:Image(
            image: AssetImage(model.image),
          ),
        ),
        Text(
          model.body,
          style:  const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          model.title,
          style:  const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }


  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, SociaLoginScreen());
      }
    });
  }
}


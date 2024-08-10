import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/modules/login/new_login_screen.dart';
import 'package:social_app/modules/login/shop_login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/translations/locale_keys.g.dart';
import 'dart:ui' as ui;


class BoardingModel
{
  final String image;
  final Color color;
  final String title;
  final String body;


  BoardingModel({
    required this.image,
    required this.color,
    required this.title,
    required this.body,
  });
}

class liquidOnBoarding extends StatefulWidget {
  const liquidOnBoarding({Key? key}) : super(key: key);

  @override
  State<liquidOnBoarding> createState() => _liquidOnBoardingState();
}

class _liquidOnBoardingState extends State<liquidOnBoarding>
{
  LiquidController liquidController = LiquidController();

  @override
  Widget build(BuildContext context) {

    List<BoardingModel>boarding=
    [
      BoardingModel(
        color: Colors.black,
        image: 'assets/images/social2.png',
        title: LocaleKeys.title1.tr(),
        body: LocaleKeys.body1.tr(),
      ),
      BoardingModel(
        color: const Color(0xff0b554c),
        image: 'assets/images/social1.png',
        title: LocaleKeys.title2.tr(),
        body: LocaleKeys.body2.tr(),
      ),
      BoardingModel(
        color: const Color(0xff592386),
        image: 'assets/images/social3.png',
        title: LocaleKeys.title3.tr(),
        body: LocaleKeys.body3.tr(),

      ),
      BoardingModel(
        color: Colors.blueGrey,
        image: 'assets/images/social4.png',
        title: LocaleKeys.title4.tr(),
        body: LocaleKeys.body4.tr(),
      ),
      BoardingModel(
        color: const Color(0xff7b087a),
        image: 'assets/images/social5.png',
        title: LocaleKeys.title5.tr(),
        body: LocaleKeys.body5.tr(),
      ),
      BoardingModel(
        color: const Color(0xff0b3855),
        image: 'assets/images/social6.png',
        title: LocaleKeys.title6.tr(),
        body: LocaleKeys.body6.tr(),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: PopupMenuButton(
                onSelected: (value)
                {
                  if (value == 'Arabic')
                  {
                    SocialCubit.get(context).changeLocalToAr(context);
                  } else
                  {
                    SocialCubit.get(context).changeLocalToEn(context);
                  }
                },
                color: Theme.of(context).textTheme.bodyText2!.color,
                icon: Icon(
                  Icons.language,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'Arabic',
                    child: Text(
                      'عربي',
                      style: TextStyle(
                        color:
                        Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'English',
                    child: Text(
                      'English',
                      style: TextStyle(
                        color:
                        Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                ],
              ))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Directionality(
            textDirection: ui.TextDirection.ltr,
            child: LiquidSwipe.builder(
              liquidController: liquidController,
              enableSideReveal: true,
              positionSlideIcon: 0.7,
              enableLoop: false,
              slideIconWidget: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPageChangeCallback: (index)
              {
                setState(() {});
              },
              itemBuilder: (BuildContext context, int index)
              {
                // print('youseffffffffffffffffffffffffffffffffffffffffffffff');
                // print(SocialCubit.get(context).textDirection.toString());
                return Directionality(
                  textDirection:SocialCubit.get(context).textDirection,  //عشان اتحكم ف مكان ال Direction بتاع الكلام
                  child: buildItem(boarding[index]),);
              },
              itemCount: 6,

            ),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        submit();
                      },
                      child: Text(
                        LocaleKeys.skip.tr(),
                        style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.white),
                      )),
                  AnimatedSmoothIndicator(
                    activeIndex: liquidController.currentPage,
                    count: boarding.length,

                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xff2a79b8),
                      dotColor: Color(0xffc4dffa),
                      dotHeight: 13,
                      dotWidth: 13,
                      expansionFactor: 3.5,
                      spacing: 7,
                    ),
                    onDotClicked: (index) {
                      liquidController.animateToPage(page: index);
                    },
                  ),
                  TextButton(
                    onPressed: ()
                    {
                      final page = liquidController.currentPage + 1;
                      if (page == 6)
                      {
                        submit();
                      }
                      else
                      {
                        liquidController.animateToPage(page: page > 6 ? 0 : page);
                      }
                    },
                    child: Text(
                      LocaleKeys.next.tr(),style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.white,),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

  }

  Widget buildItem(BoardingModel model) {
    return Container(
      color: model.color,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 450,
            child: Image(
              image: AssetImage(
                model.image,
              ),
              height: 400,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  //عشان اتحكم ف مكان ال body
              children: [
                Text(
                  model.body,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffc4dffa),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  model.title,
                  textAlign: TextAlign.start, //عشان اتحكم ف مكان السطريت الاخار
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xffc4dffa)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }




  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, SocialLoginNewScreen());
      }
    });
  }

}

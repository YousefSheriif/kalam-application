import 'package:easy_localization/easy_localization.dart';
import 'package:social_app/modules/login/new_login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

String ?token ;


String ?uId ;


bool? darkCopy ;





// void signOut(context)
// {
//   CacheHelper.removeData(key: 'token').then((value)
//   {
//     if(value == true)
//     {
//       navigateAndFinish(context, ShopLoginScreen(),);
//     }
//   });
// }
//




void printFullText(String text)
{
  final pattern = RegExp('.{1,8000}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));

}


void signOut(context)
{
  CacheHelper.removeData(key: 'uId').then((value)
  {
    if(value == true)
    {
      navigateAndFinish(context, SocialLoginNewScreen(),);
    }
  });
}


String getDate ()
{
  DateTime dateTime =  DateTime.now();
  String date =  DateFormat.yMMMd().format(dateTime);
  return date;
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/color.dart';


Widget defaultButton({
  Color? color = Colors.blue ,
  double height = 45.0,
  double width = 250.0,
  double radius = 30.0,
  bool isUpper = false,
  required String text,
  required Function,
  Color? textColor = Colors.white ,
  double textSize = 22.0 ,
})
{
  return Center(
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        onPressed: Function,
        child: Text(
          isUpper?text.toUpperCase():text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

}

Widget defaultTextButton({
  required Function,
  required String text,
  bool isUpperCase = false ,
  bool isLine = false ,
  required Color  color  ,
  double fontSize = 17.0,
  FontWeight ? fontWeight  ,



})
{
  return TextButton(
    onPressed: Function,
    child:Text( isUpperCase?text.toUpperCase():text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: isLine? TextDecoration.underline:TextDecoration.none,
      ),
    ),
  );
}


Widget defaultTextFormField({
  required TextEditingController? controller,
  required TextInputType keyboardType ,
  String ? labelText ,
  String ? hintText ,
  required IconData ?prefixIcon,
  void Function(String value)? onchange,
  void Function(String val)? onSubmit,
  void Function()? onTab,
  void Function()? suffixOnPressed,
  required String ? validatorString ,
  IconData ?suffixIcon,
  bool isPassword  = false ,
  Color? suffixColor = Colors.grey ,
  Color? prefixColor = Colors.grey ,
  Color? labelColor  ,
  Color? errorColor = Colors.red ,
  bool ? isClickable = true,
  Color ?textColor,
  Color ?borderColor= Colors.black,
})
{
  return TextFormField(
    controller: controller,

    style: TextStyle(color: textColor),
    enabled: isClickable,
    keyboardType:keyboardType ,
    onChanged: onchange,
    onFieldSubmitted: onSubmit,
    onTap: onTab,
    validator: (val)
    {
      if (val!.isEmpty)
      {
        return validatorString;
      }
      return null;
    },
    obscureText: isPassword ,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon,color: prefixColor,),
      prefixIconConstraints:const BoxConstraints(minWidth: 50.0 ),
      suffixIcon: IconButton(
        icon: Icon(suffixIcon,color:suffixColor,),
        onPressed: suffixOnPressed,
      ),
      labelText: labelText,
      hintText: hintText ,
      hintStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
      labelStyle: TextStyle(color: labelColor ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor!,width: 1.2),
        borderRadius: BorderRadius.circular(30.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: errorColor!,width: 1.2),
      ),
      errorStyle: TextStyle(color:errorColor )
    ),
  ) ;
}



Widget addressItem({
  required String ? labelText ,
  required String ? hintText ,
  required TextEditingController ? nameController ,
  required String ? validatorString ,

})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(labelText!,style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600),),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
          validator: (val)
          {
            if(val!.isEmpty)
            {
              return validatorString;
            }
            return null;
          },
          controller: nameController,
          keyboardType: TextInputType.name,
        ),
      ),
    ],
  );
}



void navigateTo(context ,Widget)
{
    Navigator.push(context, MaterialPageRoute(
    builder: (context)
    {
      return Widget;
    },
      ),
    );
}

void navigateBack(context)
{
  Navigator.pop(context);
}


void navigateAndFinish(context ,widget)
{
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder:(context) {
          return widget;
        },
      ),
        (Route<dynamic> route) => false,
  );
}


Widget myDivider()
{
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 20.0),
    child: Container(
      color: Colors.grey,
      width: double.infinity,
      height: 1.0,
    ),
  );
}

void showToast({
  required String? message,
  required ToastStates? state,
})
{
  Fluttertoast.showToast(
    msg: message.toString(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseColor(state!),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


enum ToastStates{SUCCESS,WARNING,ERROR}


Color chooseColor(ToastStates state)
{
  Color ?color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color ;
}




Widget buildDataInfoItem({
  required String ?label,
  required String ?text,
  required IconData? icon,
  Color? color = Colors.black,
  Color? iconColor = Colors.grey,
})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const SizedBox(width: 40.0,),
          Text(label!,style: TextStyle(color: color,fontSize: 13.0),),
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      Row(
        children:  [
          Icon(icon,color: iconColor,),
          const SizedBox(width: 15.0,),
          Expanded(child: Text(text!,style: TextStyle(color: color,fontSize: 16.0),)),

        ],
      ),
      const SizedBox(
        height: 15,
      ),
      Container(width: double.infinity,height: 1,color: defaultColor,),
    ],
  );

}



void pop (context)
{
  Navigator.pop(context);
}

import 'package:flutter/material.dart';
import 'package:wakeamole/Utils/AppColors.dart';

class AppMainButton extends StatelessWidget {
  final Function? ontap;
  final String? title;
  final Color? backgroundColor;
  final Color? textColor;

  const AppMainButton({Key? key,required this.ontap,required this.title, this.backgroundColor = AppColors.ACCENT, this.textColor = AppColors.BUTTONTEXT}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        ontap?.call();
      },
      child: Container(
        height: 60,
        alignment: Alignment.center,
        width: 300,
        decoration: BoxDecoration(
          color: backgroundColor!,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Text(
          title!,
          style: TextStyle(
            color: textColor!,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

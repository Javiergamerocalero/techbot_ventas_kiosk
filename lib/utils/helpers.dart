import 'package:flutter/material.dart';

const Color cyan = Color(0xFF07c8cc);
const Color yellow = Color(0xFFfac93d);
const Color grey = Color(0xFFAAAAAA);
const Color lightGrey = Color(0xFFEEEEEE);
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);

ElevatedButton elevatedButton({
  required Color backgroundColor,
  required Widget child,
  required void Function()? onPressed,
  Color foregroundColor = Colors.white,
  Color? disabledBackgroundColor,
  Color? disabledForegroundColor,
  Color borderColor = Colors.white,
  TextStyle textStyle = const TextStyle(fontSize: 20),
  double paddingHorizontal = 15,
  double paddingVertical = 15,
  double borderWidth = 1,
  double borderRadius = 10,
  Size? minimumSize,
  Size? maximumSize,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: backgroundColor.withValues(alpha: 0.7),
      disabledForegroundColor: foregroundColor.withValues(alpha: 0.6),
      textStyle: textStyle,
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      side: BorderSide(color: borderColor, width: borderWidth),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      minimumSize: minimumSize,
      maximumSize: maximumSize,
    ),
    child: child,
  );
}

Future showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String rigthButtonText,
  required void Function()? rigthButtonOnPress,
  String? leftButtonText,
  void Function()? leftButtonOnPress,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          Visibility(
            visible: leftButtonText != null && leftButtonOnPress != null,
            child: TextButton(onPressed: leftButtonOnPress, child: Text(leftButtonText ?? '')),
          ),
          TextButton(onPressed: rigthButtonOnPress, child: Text(rigthButtonText)),
        ],
      );
    },
  );
}

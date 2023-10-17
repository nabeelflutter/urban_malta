import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData? iconData;
  final Color? color;
  final Color? iconColor;
  final double size;

  const CircleButton({Key? key, this.onTap, this.iconData, this.color, this.iconColor, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: iconColor,
          size: size!/2,
        ),
      ),
    );
  }
}


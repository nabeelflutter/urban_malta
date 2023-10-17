import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter/material.dart';

import '../components/AppColors.dart';

const md.Color defaultColor = AppColors.app_black;

const md.Color defaultOnSelectColor = AppColors.app_color;

class BottomNav extends md.StatefulWidget {
  final int ?index;
  final void Function(int i) ?onTap;
  final List<BottomNavItem> ?items;
  final double elevation;
  final IconStyle ?iconStyle;
  final md.Color color;
  final LabelStyle ?labelStyle;

  BottomNav({
    this.index,
    this.onTap,
    this.items,
    this.elevation = 13.0,
    this.iconStyle,
    this.color = md.Colors.white,
    this.labelStyle,
  })  : assert(items != null),
        assert(items!.length >= 2);

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends md.State<BottomNav> {
  int ?currentIndex;
  IconStyle ?iconStyle;
  LabelStyle ?labelStyle;

  @override
  void initState() {
    currentIndex = widget.index ?? 0;
    super.initState();
  }

  @override
  md.Widget build(md.BuildContext context) {
    iconStyle = widget.iconStyle ?? IconStyle();
    labelStyle = widget.labelStyle ?? LabelStyle();

    return md.Material(
        elevation: widget.elevation,
        color: widget.color,
        child: md.Container(
            height: 70,
            child: md.Row(
              mainAxisAlignment: md.MainAxisAlignment.spaceAround,
              mainAxisSize: md.MainAxisSize.max,
              children: widget.items!.map((b) {
                final int i = widget.items!.indexOf(b);
                final bool selected = i == currentIndex;

                return BMNavItem(
                  icon: b.icon,
                  iconSize: selected
                      ? iconStyle!.getSelectedSize()
                      : iconStyle!.getSize(),
                  onTap: () => onItemClick(i),
                  color: selected
                      ? iconStyle!.getSelectedColor()
                      : iconStyle!.getColor(),
                );
              }).toList(),
            )));
  }

  onItemClick(int i) {
    setState(() {
      currentIndex = i;
    });
    if (widget.onTap != null) widget.onTap!(i);
  }

  parseLabel(String label, LabelStyle style, bool selected) {
    if (!style.isVisible()) {
      return null;
    }

    if (style.isShowOnSelect()) {
      return selected ? label : null;
    }

    return label;
  }
}

class BottomNavItem {
  final String icon;
  final String ?label;

  BottomNavItem(this.icon, {this.label});
}

class LabelStyle {
  final bool ?visible;
  final bool ?showOnSelect;
  final md.TextStyle ?textStyle;
  final md.TextStyle ?onSelectTextStyle;

  LabelStyle(
      {this.visible,
      this.showOnSelect,
      this.textStyle,
      this.onSelectTextStyle});

  isVisible() {
    return visible ?? true;
  }

  isShowOnSelect() {
    return showOnSelect ?? false;
  }

}

class IconStyle {
  final double ?size;
  final double ?onSelectSize;
  final md.Color ?color;
  final md.Color ?onSelectColor;

  IconStyle({this.size, this.onSelectSize, this.color, this.onSelectColor});

  getSize() {
    return 24.0;
  }

  getSelectedSize() {
    return 24.0;
  }

  getColor() {
    return color ?? defaultColor;
  }

  getSelectedColor() {
    return onSelectColor ?? defaultOnSelectColor;
  }
}

class BMNavItem extends md.StatelessWidget {
  final String ?icon;
  final double ?iconSize;
  final void Function() ?onTap;
  final md.Color ?color;

  BMNavItem({
    this.icon,
    this.iconSize,
    this.onTap,
    this.color,
  })  : assert(icon != null),
        assert(iconSize != null),
        assert(color != null),
        assert(onTap != null);

  @override
  md.Widget build(md.BuildContext context) {
    return md.Expanded(
        child: md.InkResponse(
      key: key,
      child: md.Padding(
          padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
          child: md.Column(
              mainAxisSize: md.MainAxisSize.min,
              children: <md.Widget>[
                md.Image(
                    image: AssetImage(icon!),
                    width: iconSize,
                    height: iconSize, color: color),
              ])),
      highlightColor: md.Theme.of(context).highlightColor,
      splashColor: md.Theme.of(context).splashColor,
      radius: md.Material.defaultSplashRadius,
      onTap: () => onTap!(),
    ));
  }
}

import 'package:flutter/cupertino.dart';

class ScreenInfo {
  late final MediaQueryData mediaQueryData;

  late final double devicePixelRatio;
  late final TextScaler textScale;
  late final Orientation orientation;
  late final double screenWidth;
  late final double screenHeight;
  late final double aspectRatio;

  late final double blockWidth;
  late final double blockHeight;
  
  ScreenInfo(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    
    // 设备像素比
    devicePixelRatio = mediaQueryData.devicePixelRatio;
    // 文本比例因子
    textScale = mediaQueryData.textScaler;
    // 设备方向
    orientation = mediaQueryData.orientation;

    // 屏幕宽度
    screenWidth = mediaQueryData.size.width;
    // 屏幕高度
    screenHeight = mediaQueryData.size.height;

    // 屏幕宽高比
    aspectRatio = screenWidth / screenHeight;

    // 单位宽度
    blockWidth = screenWidth / 100;
    // 单位高度
    blockHeight = screenHeight / 100;
  }

  double textFrontSize(double fontSize) {
    return textScale.scale(fontSize);
  }
}
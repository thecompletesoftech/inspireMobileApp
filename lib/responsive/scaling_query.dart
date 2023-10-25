import 'dart:math';

import 'package:flutter/material.dart';

class ScalingQuery {
  final _guidelineBaseWidth = 350;
  final _guidelineBaseHeight = 680;

  double? shortDimension;
  double? longDimension;

  ScalingQuery(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    shortDimension = width < height ? width : height;
    longDimension = width < height ? height : width;
  }

  double fontSize(double textSize) {
    var tempLongDimension = (16 / 9) * shortDimension!;
    return sqrt(pow(tempLongDimension, 2) + pow(shortDimension!, 2)) * (textSize / 100);
  }

  double scale(double textSize) {
    return shortDimension! / _guidelineBaseWidth * textSize;
  }

  double verticalScale(double textSize) {
    return longDimension! / _guidelineBaseHeight * textSize;
  }

  double moderateScale(double textSize, [double factor = 0.5]) {
    return textSize + (scale(textSize) - textSize) * factor;
  }

  double hp(textSize) {
    return (longDimension! * textSize) / 100;
  }

  double wp(textSize) {
    return (shortDimension! * textSize) / 100;
  }
}

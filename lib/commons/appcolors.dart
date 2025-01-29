import 'package:flutter/material.dart';

/// Enter your app primer color code in opacity ----->>
/// NOTE: Don't change opacity code just change color code -------->>
Map<int, Color> textColor = {
  50: const Color(0x80cdf6f7),
  100: const Color(0xFFCDF6F7),
  200: const Color(0xFF9BEDEF),
  300: const Color(0xff6ae5e8),
  400: const Color(0xFF38DCE0),
  500: const Color(0xFF06D3D8),
  600: const Color(0xFF05A9AD),
  700: const Color(0xff047f82),
  800: const Color(0xff025456),
  900: const Color(0xff012a2b),
};

class AppColors {
  /// Enter your app primer color code ----->>
  static MaterialColor primerColor = MaterialColor(0xFF002D74, textColor);

  ///************** Common Color **************///
  /// NOTE: DO not remove this colors -------->>>
  Color black = const Color(0xFF000000);
  Color white = const Color(0xFFFFFFFF);
  Color yellow = const Color(0xFFEEC829);
  Color yellowInRoute = const Color(0xFFF7EE1B);
  Color red = const Color(0xFFFF0025);
  Color grey = const Color(0xFF707070);
  Color transparent = const Color(0x00000000);
  Color textFiledBgColor = const Color(0xFFE5E8EC);
  Color textFiledBorderColor = const Color(0xFFC3C8D3).withOpacity(0.8);
  Color textFiledLabelColor = const Color(0xFF666F80);
  Color inactiveColor = const Color(0xFFE7E0EC);
  Color textcolor = const Color(0xFF3F3F3F);
  Color cardcolor = const Color(0xFFFFFBFE);

  ///=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-= APP COLORS ==-=-=-=--=-=-=-=-=-=-=-=-=///
  Color appColor = const Color(0xff002d74);
  Color appBGColor = const Color(0xBFF4F4F4);
  Color textBlack = const Color(0xFF1C1B1F);
  Color textBlack1 = const Color(0xFF191919);
  Color textBlack2 = const Color(0xFF49454F);
  Color introBlack = const Color(0xFF09051C);
  Color buttonColor = const Color(0xFFCDD5E3);
  Color textField = const Color(0xFFF4F4F4);
  Color lightText = const Color(0xFF3E3E3E);
  Color googleButton = const Color(0xFFEB4335);
  Color divider = const Color(0xFFC1C1C2);
  Color border = const Color(0xFF6C6C6C);
  Color border1 = const Color(0xFF98989A);
  Color bottomSheetBar = const Color(0xFF06D2D8);
  Color brown = const Color(0xFF873202);
  Color allowButton = const Color(0xFFF6F6F6);
  Color shadow = const Color(0xFF5A6CEA);
  Color textGreen = const Color(0xFF005E0A);
  Color textPink = const Color(0xFFF032E4);
  Color updateGreen = const Color(0xFF00BB13); //0xFF1FCC42
  Color updateYellow = const Color(0xFFEA8C00); //0xFFE98C00
  Color bottomSheetBackground = const Color(0xFF273840);
  Color delete = const Color(0xFFD72B2B);
  Color pinkcolor = const Color(0xFFE8DEF8);
  Color greyColor = const Color(0xFFEAEAEB);
  Color lightGreen = const Color(0xFF61FF00);
}

//
Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

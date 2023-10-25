// import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/foundation.dart';

String selectedLang = '';
String fontFamilyBold = selectedLang == Constants.languageCodeAr ? 'Tajawal-Bold' : 'Roboto-Bold';
String fontFamilyLight = selectedLang == Constants.languageCodeAr ? 'Tajawal-Light' : 'Roboto-Light';
String fontFamilyBook = selectedLang == Constants.languageCodeAr ? 'Tajawal-Regular' : 'Roboto-Regular';
String fontFamilyRegular = selectedLang == Constants.languageCodeAr ? 'Tajawal-Regular' : 'Roboto-Regular';
String fontFamilyMedium = selectedLang == Constants.languageCodeAr ? 'Tajawal-Medium' : 'Roboto-Medium';
String fontFamilyMediumFututext = selectedLang == Constants.languageCodeAr ? 'Roboto-Medium' : 'FuturaMediumBT';
String fontFamilyFutuHvtext = selectedLang == Constants.languageCodeAr ? 'Roboto-Medium' : 'Futura_Hv_BT';
String fontFamilyFuturaHeavyBTtext = selectedLang == Constants.languageCodeAr ? 'Roboto-Medium' : 'Futura_Hv_BT';

class Constants {
  static const bool isTestingMode = kDebugMode;
  // if(userOrOwner == false){ user flow } else { Business Owner Flow }
  static bool userOrOwner = false;
  static const String owner = "Business";

  // Time Format .....
  static const String YYYY_MM_DD_HH_MM_SS = 'yyyy-MM-dd hh:mm:ss';
  static const String YYYY_MM_DD_HH_MM_SS_24 = 'yyyy-MM-dd HH:mm:ss';
  static const String HH_MM_A = 'hh:mm a';
  static const String YYYY_MM_DD = 'yyyy-MM-dd';
  static const String DD_MM_YYYY = 'dd-MM-yyyy';

  // language code
  static const String languageCodeEn = 'en';
  static const String languageCodeAr = 'ar';

  //API calling....
  static const String baseUrl = "http://xyz.co.in:3030/api/";
  static const String signUp = "user/signUp";
  static const String login = "user/login";
  static const String forgotPassword = "user/forgotPassword";
  static const String getUserProfile = "user/getUserProfile";
  static const String updateProfile = "user/updateProfile";
  static const String changePassword = "user/changePassword";
  static const String updatePassword = "user/updatePassword";
  static const String verifyOTP = "user/verifyOTP";
  static const String resendOTP = "user/resendOTP";
  static const String logOut = "user/logOut";
  static const String deleteAccount = "user/deleteAccount";

  static const String refreshToken = "user/refreshToken";
  static const String isRegister = "user/isRegister";

  /// ----------- Socket ----------->>
  // static IO.Socket? socket;
  // static const String socketBaseUrl = "http://xyz.co.in:3030/";

  /// ------------ Socket Key ------------>>
  static String socketJoin = "socketJoin";
  static String socketLeave = "socketLeave";
  static String getChatUserList = "getChatUserlist";
  static String setChatUserList = "setChatUserlist";

  /// ------------ OLD Socket Key ------------>>
  static String updateChatList = "updateChatList";
  static String getMessageList = "getMessageList";
  static String setMessageList = "setMessageList";
  static String sendMessage = "sendMessage";
  static String setNewMessage = "setNewMessage";
  static String startTyping = "startTyping";
  static String stopTyping = "stopTyping";

  static const String kUriPrefix = "";
  static const String apiKey = "";
  static const String googleApiKey = "AIzaSyC6LvoJFvAIK3Gpa_SkIgz-oRzhN4RyZwc";
  static String bold = "";
  static String light = "";
  static String book = "";
  static String regular = "";
  static String medium = "";
  static const String languageCodeDefault = languageCodeEn;

  //google map json
  static String mapStyles = '''[
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]''';
}

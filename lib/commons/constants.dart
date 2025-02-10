// import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/foundation.dart';

String selectedLang = '';
String fontFamilyBold =
    selectedLang == Constants.languageCodeAr ? 'Tajawal-Bold' : 'Roboto-Bold';
String fontFamilyLight =
    selectedLang == Constants.languageCodeAr ? 'Tajawal-Light' : 'Roboto-Light';
String fontFamilyBook = selectedLang == Constants.languageCodeAr
    ? 'Tajawal-Regular'
    : 'Roboto-Regular';
String fontFamilyRegular = selectedLang == Constants.languageCodeAr
    ? 'Tajawal-Regular'
    : 'Roboto-Regular';
String fontFamilyMedium = selectedLang == Constants.languageCodeAr
    ? 'Tajawal-Medium'
    : 'Roboto-Medium';
String fontFamilyMediumFututext = selectedLang == Constants.languageCodeAr
    ? 'Roboto-Medium'
    : 'FuturaMediumBT';
String fontFamilyFutuHvtext =
    selectedLang == Constants.languageCodeAr ? 'Roboto-Medium' : 'Futura_Hv_BT';
String fontFamilyFuturaHeavyBTtext =
    selectedLang == Constants.languageCodeAr ? 'Roboto-Medium' : 'Futura_Hv_BT';

//<---------------------login constant---------------------------->

const String version = '1.0.2';
// Search parameters for the home page Based on the last searches
String initialBasedLastSearchesTerm = '- ';
const int initialMaxPages = 5;
const int limitResultBasedLastSearchesTerm = 15;
const int limitResultSearchesTermGrid = 40;
const int limitResultByIdSubCategory = 20;
const int limitResultByTerm = 15;
const String ipLocalDenisHost = "192.168.15.44";
// const String ipRemoteTesting = "209.208.27.55"; // remote testing
const String ipRemoteTesting = "104.245.38.245"; // remote testing
const String ipRemoteProduction = "104.245.38.245"; //remote Live
String serverAddress = ipRemoteTesting;

String publicCtxAuthentication =
    "http://$serverAddress/public/auth/gateway_graphql";

String protectedCtxAuthentication =
    "http://$serverAddress/protected/auth/gateway_graphql";

//<-----------------------------login constant over --------------------------->

class Constants {
  static const bool isTestingMode = kDebugMode;

  // if(userOrOwner == false){ user flow } else { Business Owner Flow }
  // static bool userOrOwner = false;
  // static const String owner = "Business";

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
  static const String baseUrl = "https://";

  static const String login = "pha-api/accounts/login/";
  static const String propertyInfo = "/inspection/api/properties/";
  static const String certificates = "/inspection/api/certificates";
  static const String buildings = "/inspection/api/buildings";
  static const String createBuildings = "/inspection/api/buildings/create/";
  static const String getDeficiency = "/inspection/api/deficiency_areas";
  static const String getBuildingType = "/inspection/api/building_types";
  static const String createInspection = "/inspection/api/create/";
  static const String createInspector = "/inspection/api/inspector/create/";
  static const String dailySchedules = "/inspection/api/schedule_inspections";
  static const String completeInspection = "/inspection/api/collection";
  static const String findingType = "/inspection/api/finding_types";
  static const String results = "/inspection/api/results";
  static const String section8Create = "/inspection/api/section8/create/";
  static const String inspectionType = "/inspection/api/inspection_types";

  static const String signUp = "user/signUp";

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
  // static String updateChatList = "updateChatList";
  // static String getMessageList = "getMessageList";
  // static String setMessageList = "setMessageList";
  // static String sendMessage = "sendMessage";
  // static String setNewMessage = "setNewMessage";
  // static String startTyping = "startTyping";
  // static String stopTyping = "stopTyping";

  static const String kUriPrefix = "";
  static const String apiKey = "";

  // static const String googleApiKey = "AIzaSyC6LvoJFvAIK3Gpa_SkIgz-oRzhN4RyZwc";
  static const String googleApiKey = "AIzaSyAHAmJ0f-Q9xHKfd-rsddiqm4Mq7mb0xUY";
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

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'api_repository/loading.dart';
import 'commons/all.dart';
import 'languages/app_localizations_delegate.dart';
import 'languages/locale_constant.dart';
import 'routes/app_pages.dart';
import 'screens/splashscreen/binding/splash_binding.dart';
import 'screens/splashscreen/screen/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  printOkStatus(
      'Handling a background message -----1----->>>>>${message.data}');
  printOkStatus(
      'Handling a background message ------2---->>>>> ${message.messageId}');
}

// AndroidNotificationChannel? channel;
// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> main() async {
  // final context = SecurityContext.defaultContext;
  // context.allowLegacyUnsafeRenegotiation = true;
  //-=-=-=-=-=-=- this fir camera =-=-=-=-=-=-=-
  WidgetsFlutterBinding.ensureInitialized();

  //-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=
  await GetStorage.init();
  // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await Firebase.initializeApp();

    // channel = const AndroidNotificationChannel(
    //   'high_importance_channel',
    //   'High Importance Notifications',
    //   description: 'This channel is used for important notifications.',
    //   playSound: true,
    //   importance: Importance.high,
    //   showBadge: true,
    // );
    //
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // await flutterLocalNotificationsPlugin
    //     ?.resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel!);
  } else {
    await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
          apiKey: "AIzaSyDxBtNrW3EQgr7kJNR_X32d8J6SQKkQxDw",
          authDomain: "inspire-59452.firebaseapp.com",
          projectId: "inspire-59452",
          storageBucket: "inspire-59452.appspot.com",
          messagingSenderId: "1039537530741",
          appId: "1:1039537530741:web:3acf109d6ff8baded6153c",
          measurementId: "G-2SKL0MPPKQ"),
    );
  }

  var isDenied = await Permission.notification.isDenied;
  if (isDenied) {
    var status = await Permission.notification.request();
  }
  // if (Platform.isAndroid) {
  //   var autoStart = await isAutoStartAvailable;
  //   if (autoStart == false) {
  //     getAutoStartPermission();
  //   } else {
  //     printAction("permission allow......");
  //   }
  // }
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocal(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    printAction(
        "test_newLocale: ${newLocale.languageCode} - ${newLocale.countryCode}");
    state?.setLocal(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? local;
  // final notifications = FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  GetStorageData getStorage = GetStorageData();

  StreamSubscription? sub;
  var initialUriIsHandled = false.obs;

  firebaseInit() async {
    if (Platform.isIOS) {
      // final bool? result = await flutterLocalNotificationsPlugin
      //     ?.resolvePlatformSpecificImplementation<
      //         IOSFlutterLocalNotificationsPlugin>()
      //     ?.requestPermissions(alert: true, badge: true, sound: true);
    }
    _firebaseMessaging.requestPermission();
    if (Platform.isIOS) iOSPermission();
    printAction("going to take token");
    _firebaseMessaging.getToken().then((value) {
      tokenReceived(value!);
    });
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        printOkStatus(
            "message -- main -- initState ---------->>>>> ${message.messageType}");
      }
    });
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        printOkStatus("notification-- ${notification!.title}");
        AppleNotification? ios = message.notification?.apple;
        if (/*notification != null &&*/ ios != null) {
          printAction('NOTIFICATION INIT IOS');
        }

        var jsonData = json.decode(message.data["data"].toString());

        if (jsonData != null && jsonData["data"] != null) {
          var data = jsonData["data"];
          printAction(data);
        }

        if (Platform.isAndroid) {
          // flutterLocalNotificationsPlugin!.show(
          //   notification.hashCode,
          //   notification.title,
          //   notification.body,
          //   NotificationDetails(
          //     iOS: const DarwinNotificationDetails(
          //       presentSound: true,
          //       presentBadge: true,
          //       presentAlert: true,
          //     ),
          //     android: AndroidNotificationDetails(
          //       channel!.id,
          //       channel!.name,
          //       channelDescription: channel!.description,
          //       icon: 'ic_notifications',
          //       importance: Importance.max,
          //       priority: Priority.high,
          //       enableLights: true,
          //       playSound: true,
          //       enableVibration: true,
          //       channelShowBadge: true,
          //     ),
          //   ),
          // );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      printAction("test_message_message_data: ${message.data}");
      printAction("test_message_message_length: ${message.data.length}");
    });

    _firebaseMessaging.getInitialMessage();
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void tokenReceived(String pushToken) async {
    printOkStatus("main push token ---------->>>>> $pushToken");
    getStorage.saveString(getStorage.fcmToken, pushToken);
  }

  void iOSPermission() async {
    printOkStatus(
        "<<<<<-------------- User granted permission -------------->>>>>");
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
  }

  void setLocal(Locale locale) {
    setState(() {
      local = locale;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocale().then((locale) {
      setState(() {
        local = locale;
      });
    });
  }

  @override
  void initState() {
    changeLanguage(context, Constants.languageCodeEn);
    firebaseInit();
    super.initState();
  }

  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  @override
  Widget build(BuildContext context) {
    Loading();

    Platform.isAndroid
        ? SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
          )
        : SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              // systemNavigationBarColor: Colors.white,
              // systemNavigationBarDividerColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          );

    return ResponsiveSizer(
      builder: (p0, p1, p2) => GetMaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        getPages: AppPages.list,
        supportedLocales: const [
          Locale(Constants.languageCodeEn, ''),
          Locale(Constants.languageCodeAr, ''),
        ],
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        locale: local,
        theme: ThemeData(
          primarySwatch: AppColors.primerColor,
          fontFamily: fontFamilyBold,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              // TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
            },
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors().appColor, // button text color
            ),
          ),
        ),
        initialBinding: SplashBinding(),
        home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

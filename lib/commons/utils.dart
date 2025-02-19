import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../languages/language.dart';
import 'all.dart';

/// <<< To get commons function --------- >>>
class Utils {
  /// <<< To create dark status bar --------- >>>
  static bool backWholeApp() {
    exit(0);
    return false;
  }

  static bool isLandScapeMode(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return true;
    } else {
      return false;
    }
  }

  static bool isLargeScreen(BuildContext context) {
    return getWidth(context) > 1200;
  }

  static bool isSmallScreen(BuildContext context) {
    return getWidth(context) < 500;
  }

  static bool isMediumScreen(BuildContext context) {
    return getWidth(context) > 800 && getWidth(context) < 1200;
  }

  static bool isTabletScreen(BuildContext context) {
    return getWidth(context) > 300 && getWidth(context) < 820;
  }

  static bool isTabletScreen1(BuildContext context) {
    return getWidth(context) > 300 && getWidth(context) < 800;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// <<< To create dark status bar --------- >>>
  static void darkStatusBar() {
    AppColors appColors = AppColors();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: appColors.border1,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  /// <<< To create light status bar --------- >>>
  static void lightStatusBar() {
    AppColors appColors = AppColors();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: appColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showSnackBar(
          context: Get.context!,
          message: Languages.of(Get.context!)!.urlNotFound);
      throw 'Could not launch $url';
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      showSnackBar(
        context: Get.context!,
        message: Languages.of(Get.context!)!.urlNotFound,
      );
      throw Exception('Exception $url');
    }
  }

  /// <<< To choose screens portrait --------- >>>
  static void screenPortrait(context) {
    Utils.isSmallScreen(context)
        ? SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ])
        : SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
  }

  /// <<< To choose screens portrait --------- >>>
  static void screenAllow() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<bool> checkPermissionOpenCamera() async {
    var photosStatus = await Permission.photos.status;
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;
    var storageStatus = await Permission.storage.status;
    var manageExternalStorageStatus =
        await Permission.manageExternalStorage.status;
    if (!photosStatus.isGranted) await Permission.photos.request();
    if (!cameraStatus.isGranted) await Permission.camera.request();
    if (!microphoneStatus.isGranted) await Permission.microphone.request();
    if (!storageStatus.isGranted) await Permission.storage.request();
    if (!manageExternalStorageStatus.isGranted)
      await Permission.manageExternalStorage.request();
    if (await Permission.microphone.isGranted) {
      if (await Permission.camera.isGranted) {
        return true;
      } else {
        printError("App needs +++========");
        openAppSettings();
        printError(
            "App needs to access your storage, please provide permission");
        return false;
      }
    } else {
      openAppSettings();
      printError("Provide microphone permission to use camera.");
      return false;
    }
  }

  /// <<< To get device type --------- >>>
  String getDeviceType() {
    if (Platform.isAndroid) {
      return 'Android';
    } else {
      return 'iOS';
    }
  }

  /// <<< To check email valid or not --------- >>>
  bool emailValidator(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(email)) {
      return true;
    }
    return false;
  }

  /// <<< To check phone valid or not --------- >>>
  bool phoneValidator(String contact) {
    String p = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }
    return false;
  }

  /// <<< To check password valid or not --------- >>>
  bool passwordValidator(String contact) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }
    return false;
  }

  /// <<< To check data, string, list, object are empty or not --------- >>>
  bool isValidationEmpty(String? val) {
    if (val == null ||
        val.isEmpty ||
        val == "null" ||
        val == "" ||
        val == "Null" ||
        val == "NULL") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isValidURL(String url) async {
    if (await canLaunch(url)) {
      return true;
    } else {
      return false;
    }
  }

  /// <<< To check data, string, list, object are empty or not --------- >>>
  bool isOTPValid(String? val) {
    if (val == null ||
        val.isEmpty ||
        val == "null" ||
        val == "" ||
        val == "NULL" ||
        val.length < 4) {
      return true;
    } else {
      return false;
    }
  }

  /// <<< To check data, string, list, object are empty or not --------- >>>
  bool isRoutingNoValid(String? val) {
    if (val == null ||
        val.isEmpty ||
        val == "null" ||
        val == "" ||
        val == "NULL" ||
        val.length < 9) {
      return true;
    } else {
      return false;
    }
  }

  /// <<< To show snackBar massage  --------- >>>
  void showSnackBar(
      {required BuildContext context,
      required String message,
      bool? isOk = false}) {
    AppColors appColors = AppColors();

    Future<void>.delayed(Duration.zero, () {
      Get.snackbar(
        "",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: isOk! ? Colors.green.shade600 : Colors.red.shade600,
        colorText: appColors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        padding:
            const EdgeInsets.only(bottom: 15, top: 10, left: 15, right: 15),
        titleText: Container(),
      );
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List> getBytesFromNetwork(String path, int width) async {
    Uint8List image = await loadNetworkImage(path);
    final ui.Codec codec = await ui.instantiateImageCodec(
        image.buffer.asUint8List(),
        targetHeight: Platform.isAndroid ? 150 : 160,
        targetWidth: Platform.isAndroid ? 150 : 160);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> convertNetworkImageToCustomBitmapDescriptor(
      String title,
      {int size = 100,
      bool addBorder = false,
      Color borderColor = Colors.white,
      double borderSize = 20,
      required String imageUrl,
      Color titleColor = Colors.white,
      Color titleBackgroundColor = Colors.black}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color;
    final TextPainter textPainter = TextPainter(
        // textDirection: textDirection??TextDirection.LTR,
        );
    final double radius = size / 2;

    //make canvas clip path to prevent image drawing over the circle
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        Radius.circular(100)));
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size * 8 / 10, size.toDouble(), size * 3 / 10),
        Radius.circular(100)));
    canvas.clipPath(clipPath);

    //paintImage
    // final http.Response response = await http.get(Uri.parse(imageUrl));
    // final Uint8List imageUint8List = response.bodyBytes;
    final Uint8List imageUint8List = await getBytesFromAsset(imageUrl, 50);
    final ui.Codec codec = await ui.instantiateImageCodec(
      imageUint8List,
      targetHeight: Platform.isAndroid ? 150 : 160,
      targetWidth: Platform.isAndroid ? 150 : 160,
    );
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      image: imageFI.image,
      fit: BoxFit.cover,
    );

    // if (addBorder) {
    //   //draw Border
    //   paint..color = borderColor;
    //   paint..style = PaintingStyle.stroke;
    //   paint..strokeWidth = borderSize;
    //   canvas.drawCircle(Offset(radius, radius), radius, paint);
    // }

    if (title != null) {
      if (title.length > 9) {
        title = title.substring(0, 9);
      }
      //draw Title background
      paint.color = titleBackgroundColor;
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(radius, radius), radius, paint);

      //draw Title
      textPainter.textDirection = ui.TextDirection.ltr;
      textPainter.text = TextSpan(
          text: title,
          style: TextStyle(
            fontSize: radius,
            fontWeight: FontWeight.w500,
            fontFamily: fontFamilyMedium,
            color: titleColor,
          ));

      textPainter.layout();
      textPainter.paint(canvas, Offset(radius / 1.5, radius / 2.2));
    }

    //convert canvas as PNG bytes
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final data = await _image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    //convert PNG bytes as BitmapDescriptor
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  Future<BitmapDescriptor> convertNetworkImageToCustomBitmapDescriptor1(
      String imageUrl,
      {int size = 150,
      bool addBorder = false,
      Color borderColor = Colors.white,
      double borderSize = 10,
      required String title,
      Color titleColor = Colors.white,
      Color titleBackgroundColor = Colors.black}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color;
    final TextPainter textPainter = TextPainter(
        // textDirection: textDirection??TextDirection.LTR,
        );
    final double radius = size / 2;

    //make canvas clip path to prevent image drawing over the circle
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        Radius.circular(100)));
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size * 8 / 10, size.toDouble(), size * 3 / 10),
        Radius.circular(100)));
    canvas.clipPath(clipPath);

    //paintImage
    //paintImage
    // final http.Response response = await http.get(Uri.parse(imageUrl));
    // final Uint8List imageUint8List = response.bodyBytes;
    final Uint8List imageUint8List = await getBytesFromAsset(imageUrl, 50);
    final ui.Codec codec = await ui.instantiateImageCodec(
      imageUint8List,
      targetHeight: Platform.isAndroid ? 150 : 160,
      targetWidth: Platform.isAndroid ? 150 : 160,
    );
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      image: imageFI.image,
      fit: BoxFit.cover,
    );

    if (addBorder) {
      //draw Border
      paint.color = borderColor;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = borderSize;
      canvas.drawCircle(Offset(radius, radius), radius, paint);
    }

    if (title != null) {
      if (title.length > 9) {
        title = title.substring(0, 9);
      }
      //draw Title background
      paint.color = titleBackgroundColor;
      paint.style = PaintingStyle.fill;
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(0, size * 8 / 10, size.toDouble(), size * 3 / 10),
              Radius.circular(100)),
          paint);

      //draw Title
      textPainter.textDirection = ui.TextDirection.ltr;
      textPainter.text = TextSpan(
          text: title,
          style: TextStyle(
            fontSize: radius / 2.5,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ));
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(radius - textPainter.width / 2,
              size * 9.5 / 10 - textPainter.height / 2));
    }
    //convert canvas as PNG bytes
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final data = await _image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    //convert PNG bytes as BitmapDescriptor
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  // =-=-=-=-=-=-=-=-=- Get current location 👇 =-=-==-=-=->>>>>>

  Future getAddressFromLatLng() async {
    Position position = await getGeoLocationPosition();
    GetStorageData().saveString(GetStorageData().userLAT, position.latitude);
    GetStorageData().saveString(GetStorageData().userLNG, position.longitude);
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${Constants.googleApiKey}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      final results = jsonResult['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final address =
            results[0]['formatted_address'].toString().split(',')[1];
        printAction("Address==>>> $address");

        GetStorageData().saveString(GetStorageData().userLoc, address);
      }
    }
  }

  Future<File> addTimestampToImage(File imageFile, DateTime dateTime) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);

    if (image == null) return File('');

    String timestamp = "${DateFormat('MM-dd-yyyy HH:mm').format(dateTime)}";
    img.drawString(
      image,
      timestamp,
      font: image.height <= 500
          ? img.arial14
          : image.height <= 1000
              ? img.arial24
              : img.arial48,
      color: img.ColorFloat64.rgb(255, 255, 255),
      x: int.parse((image.width * .07).ceil().toString()),
      y: int.parse((image.height * .9).ceil().toString()),
    );

    Uint8List encodedImage = Uint8List.fromList(img.encodeJpg(image));
    Directory tempDir = await getTemporaryDirectory();
    File newImage = File("${tempDir.path}/timestamped_image.jpg");
    await newImage.writeAsBytes(encodedImage);

    return newImage;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (Platform.isIOS) {
        Get.defaultDialog(
            middleText: "Hello world!",
            backgroundColor: Colors.white,
            titleStyle: const TextStyle(color: Colors.white),
            middleTextStyle: const TextStyle(color: Colors.white),
            textCancel: "OK",
            cancelTextColor: Colors.pink,
            buttonColor: Colors.pinkAccent,
            barrierDismissible: false,
            radius: 50,
            content: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0, left: 20),
                  child: Text(
                    "Turn on Location Services \nfor your iPhone",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 17),
                  ),
                ),
                ListTile(
                    title: const Text(
                      '1. Open the Settings app',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Image.asset(
                      "assets/images/settings1.jpeg",
                      fit: BoxFit.cover,
                    )),
                SizedBox(height: 15.px),
                ListTile(
                    title: const Text(
                      '2. Select Privacy',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Image.asset(
                      "assets/images/privacy.jpg",
                      fit: BoxFit.cover,
                    )),
                SizedBox(height: 15),
                ListTile(
                    title: const Text(
                      '3. Select Location  Services',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Image.asset(
                      "assets/images/gps.jpeg",
                      fit: BoxFit.cover,
                    )),
                SizedBox(height: 15),
                ListTile(
                    title: const Text(
                      '4. Turn on Location Services',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: SizedBox(
                      height: 30,
                      child: Image.asset(
                        "assets/images/switch.jpg",
                        fit: BoxFit.cover,
                      ),
                    )),
              ],
            ));
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        // AppSettings.openLocationSettings();
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      // AppSettings.openLocationSettings();
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (Platform.isIOS) {
        Get.defaultDialog(
            middleText: "Hello world!",
            backgroundColor: Colors.white,
            titleStyle: const TextStyle(color: Colors.white),
            middleTextStyle: const TextStyle(color: Colors.white),
            // textConfirm: "Ok",
            textCancel: "OK",
            cancelTextColor: Colors.pink,
            // confirmTextColor: Colors.white,
            buttonColor: Colors.pinkAccent,
            barrierDismissible: false,
            radius: 50.px,
            content: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0, left: 20),
                  child: Text(
                    "Turn on Location Services \nfor your iPhone",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 17),
                  ),
                ),
                ListTile(
                  title: Text(
                    '1. Open the Settings app',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // leading: Image.asset(
                  //   "assets/images/settings1.jpeg",
                  //   fit: BoxFit.cover,
                  // )
                ),
                SizedBox(height: 15),
                ListTile(
                  title: Text(
                    '2. Select Privacy',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // leading: Image.asset(
                  //   "assets/images/privacy.jpg",
                  //   fit: BoxFit.cover,
                  // )
                ),
                SizedBox(height: 15),
                ListTile(
                  title: Text(
                    '3. Select Location  Services',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // leading: Image.asset(
                  //   "assets/images/gps.jpeg",
                  //   fit: BoxFit.cover,
                  // )
                ),
                SizedBox(height: 15),
                ListTile(
                  title: Text(
                    '4. Turn on Location Services',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // leading: Container(
                  //   height: 30,
                  //   child: Image.asset(
                  //     "assets/images/switch.jpg",
                  //     fit: BoxFit.cover,
                  //   ),
                  // )
                ),
              ],
            ));

        return Future.error('Location services are disabled.');
      }
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      // AppSettings.openLocationSettings();
      // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Uint8List> loadNetworkImage(path) async {
    final completed = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completed.complete(info)));
    final imageInfo = await completed.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  /// <<< To show toast massage  --------- >>>
  void showToast({required String message, required BuildContext context}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      backgroundColor: Colors.black,
    );
  }

  /// <<< To transfer string to Md5 --------- >>>
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  /// <<< hide keyboard --------- >>>
  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// <<< To using country code get his emoji --------- >>>
  String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  /// <<< To transfer time to milliSeconds --------- >>>
  static transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String strTime = '';
    if (hoursStr == '00' || hoursStr == '0') {
      strTime = '$minutesStr:$secondsStr';
    } else {
      strTime = '$hoursStr:$minutesStr:$secondsStr';
    }
    return strTime;
  }

  /// <<< To get current time --------- >>>
  String currentTime() {
    String month = DateFormat.M().format(DateTime.now().toLocal());
    String day = DateFormat.d().format(DateTime.now().toLocal());
    String time = DateFormat.Hm().format(DateTime.now().toLocal());
    String timeDate =
        '${DateFormat.y().format(DateTime.now().toLocal())}-${month.length == 1 ? '0$month' : month}-${day.length == 1 ? '0$day' : day} $time';
    return timeDate;
  }

  /// <<< To get current date --------- >>>
  String currentDate(String outputFormat) {
    var now = DateTime.now().toLocal();
    var formatter = DateFormat(outputFormat);
    String formattedDate = formatter.format(now);

    return formattedDate;
  }

  /// <<< To launch url --------- >>>
  void urlLaunch(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  List<String> fillSlots() {
    List<String> list = [];
    for (int i = 1; i <= 100; i++) {
      list.add("$i");
    }
    return list;
  }

  Future<String> getFileNameWithExtension(File file) async {
    if (await file.exists()) {
      return path.basename(file.path);
    } else {
      return "";
    }
  }

  /// <<< To change date formant --------- >>>
  String changeDateFormat({DateTime? date, String? outputFormat}) {
    if (date != null) {
      DateFormat formatter = DateFormat(outputFormat);
      String formatted = formatter.format(date);
      return formatted;
    }
    return '';
  }

  bool isValidDate(String input) {
    try {
      final date = DateTime.parse(input);
      final originalFormatString = toOriginalFormatString(date);
      return input == originalFormatString;
    } catch (e) {
      return false;
    }
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y$m$d";
  }

  /// Time Ago Since Date --------- >>>
  String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime dateUtc = DateTime.parse(dateString);
    var dateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc.toString(), true);
    DateTime date = dateTime.toLocal();
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return (numericDates)
          ? '${(difference.inDays / 365).floor()} Y'
          : '${(difference.inDays / 365).floor()} Years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 Y' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} M';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 M' : 'Last Month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return (numericDates)
          ? '${(difference.inDays / 7).floor()} w'
          : '${(difference.inDays / 7).floor()} Weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 w' : 'Last week';
    } else if (difference.inDays >= 2) {
      return (numericDates)
          ? '${difference.inDays} d'
          : '${difference.inDays} Days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 d' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} h';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 h' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} min';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 min' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} sec';
    } else {
      return 'now';
    }
  }

  String utcToLocal(String date, {bool? isChat}) {
    if (date.isNotEmpty) {
      var dateTime = DateFormat(Constants.YYYY_MM_DD_HH_MM_SS_24)
          .parse(date.toString(), true);
      DateTime dateLocal = dateTime.toLocal();
      return dateLocal.toString();
    }
    return '';
  }

  /// <<< To get Day Of Month Suffix --------- >>>
  String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  /// <<<--- Date Picker ----------------->>
  Future<DateTime> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime(DateTime.now().year - 13);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1947, 8),
      lastDate: DateTime(
        DateTime.now().year - 13,
      ),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return picked;
    }
    return selectedDate;
  }

  Future<String> createFileFromString(bytes) async {
    var photosStatus = await Permission.storage.status;
    if (!photosStatus.isGranted) {
      await Permission.storage.request();
    }

    String dir = (await getTemporaryDirectory()).path;
    String fullPath = '$dir/sign${DateTime.now().millisecondsSinceEpoch}.png';
    File file = File(fullPath);
    await file.writeAsBytes(bytes);
    printAction(file.path);

    final result = await ImageGallerySaver.saveImage(bytes);
    printAction("local file full path ${result['filePath']}");
    printAction("local file full path ${result.toString()}");

    return file.path;
  }

  /// <<< To read Time stamp --------- >>>
  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('dd-yyyy,MM HH:mm a');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = '${diff.inDays}DAY AGO';
      } else {
        time = '${diff.inDays}DAYS AGO';
      }
    }

    return time;
  }
}

/// <<< Error Massage Red color --------- >>>
void printError(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[91m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Ok Status Massage Green Color --------- >>>
void printOkStatus(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[92m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Warning Massage Yellow Color --------- >>>
void printWarning(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[93m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Action Massage Blue Color --------- >>>
void printAction(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[94m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Cancel Massage Gray Color --------- >>>
void printCancel(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[96m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Error Massage Red color --------- >>>
void printWhite(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[97m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// Color Print Code --------------->>>>
/**
    debugPrint("\x1B[1m 1hello \x1B[0m");
    debugPrint("\x1B[3m 3hello \x1B[0m");
    debugPrint("\x1B[4m 4hello \x1B[0m");
    debugPrint("\x1B[7m 7hello \x1B[0m");
    debugPrint("\x1B[9m 9hello \x1B[0m");
    debugPrint("\x1B[21m 21hello \x1B[0m");
    debugPrint("\x1B[30m 30hello \x1B[0m");
    debugPrint("\x1B[31m 31hello \x1B[0m");
    debugPrint("\x1B[32m 32hello \x1B[0m");
    debugPrint("\x1B[33m 33hello \x1B[0m");
    debugPrint("\x1B[34m 34hello \x1B[0m");
    debugPrint("\x1B[35m 35hello \x1B[0m");
    debugPrint("\x1B[36m 36hello \x1B[0m");
    debugPrint("\x1B[37m 37hello \x1B[0m");
    debugPrint("\x1B[40m 40hello \x1B[0m");
    debugPrint("\x1B[41m 41hello \x1B[0m");
    debugPrint("\x1B[42m 42hello \x1B[0m");
    debugPrint("\x1B[43m 43hello \x1B[0m");
    debugPrint("\x1B[44m 44hello \x1B[0m");
    debugPrint("\x1B[45m 45hello \x1B[0m");
    debugPrint("\x1B[46m 46hello \x1B[0m");
    debugPrint("\x1B[47m 47hello \x1B[0m");
    debugPrint("\x1B[51m 51hello \x1B[0m");
    debugPrint("\x1B[52m 52hello \x1B[0m");
    debugPrint("\x1B[90m 90hello \x1B[0m");
    debugPrint("\x1B[91m 91hello \x1B[0m");
    debugPrint("\x1B[92m 92hello \x1B[0m");
    debugPrint("\x1B[93m 93hello \x1B[0m");
    debugPrint("\x1B[94m 94hello \x1B[0m");
    debugPrint("\x1B[95m 95hello \x1B[0m");
    debugPrint("\x1B[96m 96hello \x1B[0m");
    debugPrint("\x1B[97m 97hello \x1B[0m");
    debugPrint("\x1B[100m 100hello \x1B[0m");
    debugPrint("\x1B[101m 101hello \x1B[0m");
    debugPrint("\x1B[102m 102hello \x1B[0m");
    debugPrint("\x1B[103m 103hello \x1B[0m");
    debugPrint("\x1B[104m 104hello \x1B[0m");
    debugPrint("\x1B[105m 105hello \x1B[0m");
    debugPrint("\x1B[106m 106hello \x1B[0m");
    debugPrint("\x1B[107m 107hello \x1B[0m");
    debugPrint("\x1B[108m 108hello \x1B[0m");
 **/

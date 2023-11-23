import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_housing/commons/all.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HSAckController extends BaseController {
  RxCommonModel? item;
  RxString imageFile = "".obs;
  bool visibleBtn = false;
  bool change = true;
  final commentController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  var dataList = [
    RxCommonModel(
      title: "D1. Cabinets are missing",
      status: "false",
      image: ImagePath.kitchen,
      imgId: ImagePath.cabinets,
    ),
    RxCommonModel(
      title: "D3. Refrigerator is missing",
      image: ImagePath.kitchen,
      imgId: ImagePath.bedroom,
      status: "false",
    ),
  ];
  String dropDownValue = "Finding Type*";
  List<String> itemList = ["1st time fail", "Terminate"];

  SpeechToText speechToText = SpeechToText();
  var isListening = false.obs;
  var speechText = "".obs;

  void listen() async {
    var microphoneStatus = await Permission.microphone.status;
    var storageStatus = await Permission.storage.status;
    if (!microphoneStatus.isGranted) await Permission.microphone.request();
    if (!storageStatus.isGranted) await Permission.storage.request();
    if (await Permission.microphone.isGranted) {
      if (!isListening.value) {
        bool available = await speechToText.initialize(
          onStatus: (val) {
            printAction("Permission onStatus $val");
            if (val == "done") {
              isListening.value = false;
              speechToText.stop();
              update();
            }
          },
          onError: (val) {
            printAction("Permission onError $val");
          },
        );
        if (available) {
          isListening.value = true;
          update();

          speechToText.listen(onResult: (val) {
            commentController.text = val.recognizedWords;
            update();
          });
        }
      } else {
        isListening.value = false;
        speechToText.stop();
        update();
      }
    } else {
      printAction("Permission Denied");
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;
    }
    update();
    // TODO: implement onInit
    super.onInit();
  }

  late final Rx<DateTime> _selectedDate = DateTime.now().obs;
  late final Rx<TimeOfDay> _selectedTime = TimeOfDay.now().obs;

  Rx<DateTime> get selectedDate => _selectedDate;
  Rx<TimeOfDay> get selectedTime => _selectedTime;

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      initialDate: _selectedDate.value,
      firstDate: DateTime(1985),
      lastDate: DateTime.now(),
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      var date = DateFormat("MM/dd/yyyy").format(selectedDate.value);
      dateController.text = "  $date";
      visibleBtn = true;
    }
    update();
  }

  void selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      printAction(pickedTime.format(Get.context!)); //output 10:51 PM
      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(Get.context!).toString());
      //converting to DateTime so that we can further format on different pattern.
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      printAction(formattedTime); //output 14:59:00
      selectedTime.value = pickedTime;
      // var date = DateFormat("hh:mm").format(selectedTime.value);
      timeController.text = "  $formattedTime";
      visibleBtn = true;
    }
    update();
  }

  final leaveController = TextEditingController();
  var active = false;

  dialogNoOnePresent() {
    alertActionDialogApp(
        context: Get.context!,
        borderRadius: 28.px,
        widget: GetBuilder<HSAckController>(
          // assignId: true,
          builder: (_) {
            return Column(
              children: [
                Container(
                  width: 406.px,
                  height: 210.px,
                  padding: EdgeInsets.all(
                    24.px,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTextView(
                        Strings.noOneIsPresent,
                        textStyleNew: MyTextStyle(
                          textColor: appColors.textBlack,
                          textSize: 24.px,
                          textFamily: fontFamilyRegular,
                          textWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'You can complete the inspection if no one is present to make a signature.',
                                style: MyTextStyle(
                                  textColor: appColors.textBlack2,
                                  textSize: 16.px,
                                  textFamily: fontFamilyRegular,
                                  textWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).paddingSymmetric(vertical: 16.px),
                      CommonTextField(
                        controller: leaveController,
                        height: 55.px,
                        padding: EdgeInsets.zero,
                        border: Border.all(color: appColors.border1),
                        borderRadius: 100.px,
                        color: appColors.lightText.withOpacity(0.2),
                        hintText: "Give us more context",
                        labelText: "Leave a Comment",
                        isLable: true,
                        prefixIcon: SvgPicture.string(
                          icMsg,
                          color: appColors.lightText,
                          // height: 20,
                        ).paddingOnly(left: 15.px),
                        onChange: (value) {
                          if (!utils.isValidationEmpty(value)) {
                            active = true;
                          } else {
                            active = false;
                          }
                          update();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 406.px,
                  height: 2.px,
                  color: appColors.grey.withOpacity(0.5),
                ),
                SizedBox(
                  width: 406.px,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonButton(
                              title: Strings.cancel,
                              textColor: appColors.appColor,
                              color: appColors.transparent,
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w500,
                              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                              radius: 100.px,
                              onTap: () {
                                active = false;
                                leaveController.clear();
                                update();
                                Get.back();
                              }).paddingOnly(right: 8.px),
                          CommonButton(
                              title: Strings.completeInspection,
                              textColor: active ? appColors.black : appColors.border1,
                              color: active ? appColors.textPink : appColors.black.withOpacity(0.11999999731779099),
                              textSize: 16.px,
                              textFamily: fontFamilyRegular,
                              textWeight: FontWeight.w500,
                              padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 10.px),
                              radius: 100.px,
                              onTap: () {
                                if (active) {
                                  Get.back();
                                  Get.back(result: true);
                                  // Get.back(result: true);
                                  // Get.offNamed(HomeScreen.routes, arguments: HomeController().item);
                                } else {
                                  utils.showToast(message: "Leave comment is empty", context: Get.context!);
                                }
                              }),
                        ],
                      ).paddingOnly(
                        top: 24.px,
                        left: 8.px,
                        right: 24.px,
                        bottom: 24.px,
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}

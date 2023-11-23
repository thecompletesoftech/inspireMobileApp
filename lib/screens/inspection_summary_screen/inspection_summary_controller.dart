import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';

import '../home_screen/home_controller.dart';

class InspectionSummaryController extends BaseController {
  RxCommonModel? item;
  RxString imageFile = "".obs;
  bool visibleBtn = false;
  bool change = true;
  final commentController = TextEditingController();
  final dateController = TextEditingController();

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

  String? itemTitle;

  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;
      if (Get.isRegistered<HomeController>()) {
        itemTitle = Get.find<HomeController>().item!.massage!;
      }
    }
    update();
    // TODO: implement onInit
    super.onInit();
  }

  late final Rx<DateTime> _selectedDate = DateTime.now().obs;
  var formattedDate = ''.obs;

  Rx<DateTime> get selectedDate => _selectedDate;

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
      formattedDate.value = date;
      dateController.text = "  $date";
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
        widget: GetBuilder<InspectionSummaryController>(
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
                                  Get.back(result: true);
                                  Get.back(result: true);

                                  // if (Get.isRegistered<HomeController>()) {
                                  //   Get.find<HomeController>().dataList.where((element) {
                                  //       if (element.id == InspectionController().item!.id) {
                                  //         element.status = InspectionStatus.inCompleted.toString();
                                  //       }
                                  //       return element.id == InspectionController().item!.id;
                                  //   });
                                  // }
                                  // Get.offNamed(HomeScreen.routes, arguments: BuildingDetailsController().item);
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

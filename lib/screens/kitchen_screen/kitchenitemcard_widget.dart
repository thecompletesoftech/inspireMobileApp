import 'package:flutter_svg/flutter_svg.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/kitchen_screen/kitchen_controller.dart';

import '../standard_screen/standard_screen.dart';

class KitchenItemCardWidget extends GetView<KitchenController> {
  final RxCommonModel item1;
  const KitchenItemCardWidget({super.key, required this.item1});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KitchenController>(
      init: KitchenController(),
      assignId: true,
      builder: (controller) {
        return Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
              shape: const Border(
                top: BorderSide(color: Colors.transparent),
                bottom: BorderSide(color: Colors.transparent),
              ),
              leading: MyTextView(
                item1.title!.substring(0, 1).toUpperCase(),
                textStyleNew: MyTextStyle(
                  textSize: 20.px,
                  textWeight: FontWeight.w400,
                  textColor: controller.appColors.black,
                  textFamily: fontFamilyRegular,
                ),
              ),
              title: Container(
                height: 1,
                color: Colors.grey,
              ),
              children: List.generate(controller.searchList.length, (index1) {
                final item = controller.searchList[index1];
                return item1.title!.substring(0, 1).toUpperCase() == item.title!.substring(0, 1).toUpperCase()
                    ? ShadowContainer(
                        radius: 8.px,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(StandardScreen.routes, arguments: [
                              controller.item,
                              controller.dataList.indexWhere((element) => element.title == item.title)
                            ])!
                                .then((value) {
                              if (value != null && value == true) {
                                item.status = "true";
                                controller.change = value;
                                if (controller.sendImagesList.isNotEmpty) {
                                  controller.visibleBtn = true;
                                }
                                controller.update();
                              }
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                item.image ?? "",
                                fit: BoxFit.fill,
                                width: 118.px,
                              ),
                              SizedBox(
                                width: 16.px,
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: MyTextView(
                                              item.title,
                                              textStyleNew: MyTextStyle(
                                                textSize: 20.px,
                                                textWeight: FontWeight.w400,
                                                textColor: controller.appColors.textBlack1,
                                                textFamily: fontFamilyRegular,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16.px,
                                          ),
                                          if (item.status == "true") ...[
                                            ClipOval(
                                                child: SvgPicture.string(
                                              icComplete,
                                            ))
                                          ]
                                        ],
                                      ),
                                    ),
                                    MyTextView(
                                      item.subtitle,
                                      isMaxLineWrap: true,
                                      textStyleNew: MyTextStyle(
                                        textSize: 16.px,
                                        textColor: controller.appColors.textBlack2,
                                        textWeight: FontWeight.w400,
                                        textFamily: fontFamilyRegular,
                                      ),
                                    ).paddingOnly(top: 8.px),
                                  ],
                                ).paddingSymmetric(horizontal: 8.px, vertical: 16.px),
                              ),
                            ],
                          ),
                        ),
                      ).paddingSymmetric(vertical: 8.px)
                    : const SizedBox();
              }).toList()),
        );
      },
    );
  }
}

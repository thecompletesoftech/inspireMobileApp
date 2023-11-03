import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:public_housing/commons/all.dart';
import 'package:public_housing/screens/text_message_screen/text_message_controller.dart';

class TextMessageScreen extends GetView<TextMessageController> {
  TextMessageScreen({Key? key}) : super(key: key);
  static const routes = "/TextMessageScreen";
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextMessageController>(
      builder: (controller) {
        return BaseScreen(
          backgroundColor: controller.appColors.appBGColor,
          resizeToAvoidBottomInset: true,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PopupMenuButton<int>(
                key: _key,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.transparent,
                ),
                // onSelected: (int value) => actionPopUpItemSelected(value),
                itemBuilder: (context) {
                  return <PopupMenuEntry<int>>[
                    PopupMenuItem(
                        value: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTextView(
                                "Text for Arrival",
                                textStyleNew: MyTextStyle(
                                    textSize: 12.px, textColor: AppColors().textBlack, textWeight: FontWeight.w500),
                              ),
                              MyTextView(
                                Strings.arrival,
                                maxLinesNew: 8,
                                textStyleNew: MyTextStyle(
                                    textSize: 16.px, textColor: AppColors().textBlack, textWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )),
                    PopupMenuItem(
                        value: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTextView(
                                "Report Delay",
                                textStyleNew: MyTextStyle(
                                    textSize: 12.px, textColor: AppColors().textBlack, textWeight: FontWeight.w500),
                              ),
                              MyTextView(
                                Strings.arrival,
                                maxLinesNew: 8,
                                textStyleNew: MyTextStyle(
                                    textSize: 16.px, textColor: AppColors().textBlack, textWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )),
                  ];
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShadowContainer(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    child: CommonIconButton(
                        icon: icEditNotes,
                        iconheigth: 24.px,
                        title: Strings.notes,
                        radius: 100.px,
                        padding: EdgeInsets.fromLTRB(16.px, 16.px, 20.px, 16.px),
                        color: controller.appColors.transparent,
                        textColor: controller.appColors.appColor,
                        textWeight: FontWeight.w500,
                        textSize: 14.px,
                        onTap: () {
                          _key.currentState?.showButtonMenu();
                        }),
                  ),
                ],
              ),
            ],
          ).paddingOnly(bottom: 70.px, right: 22.px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonAppBar(color: controller.appColors.transparent, radius: 0.px),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 60.px),
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 175.px,
                          child: Stack(
                            clipBehavior: Clip.antiAlias,
                            fit: StackFit.loose,
                            children: [
                              ClipOval(
                                  child: Image.asset(
                                controller.item!.image!,
                                width: 100.px,
                                height: 100.px,
                                fit: BoxFit.cover,
                              )),
                              Positioned(
                                right: -2,
                                child: ClipOval(
                                    child: Image.asset(
                                  ImagePath.user,
                                  width: 110.px,
                                  height: 110.px,
                                  fit: BoxFit.cover,
                                )),
                              ),
                            ],
                          ),
                        ).paddingSymmetric(vertical: 20.px),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextView(
                              Strings.message,
                              textStyleNew: MyTextStyle(
                                textSize: 32.px,
                                textWeight: FontWeight.w400,
                                textColor: controller.appColors.black,
                                textFamily: fontFamilyBold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextView(
                              Strings.messageHint,
                              isMaxLineWrap: true,
                              textStyleNew: MyTextStyle(
                                textSize: 20.px,
                                textWeight: FontWeight.w400,
                                textColor: controller.appColors.border,
                                textFamily: fontFamilyRegular,
                              ),
                            ),
                          ],
                        ).paddingOnly(top: 20.px, bottom: 15.px),
                      ],
                    ).paddingAll(16.px),
                    ListView.builder(
                        itemCount: controller.itemCount.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 24.px),
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          RxCommonModel item = controller.itemCount[index];
                          return Row(
                            children: [
                              Image.asset(
                                item.image!,
                                height: 59.px,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        MyTextView(
                                          item.title,
                                          isMaxLineWrap: true,
                                          textStyleNew: MyTextStyle(
                                            textSize: 16.px,
                                            textWeight: FontWeight.w600,
                                            textColor: controller.appColors.black,
                                            textFamily: fontFamilyRegular,
                                          ),
                                        ).paddingOnly(right: 16.px),
                                        MyTextView(
                                          item.subtitle,
                                          isMaxLineWrap: true,
                                          textStyleNew: MyTextStyle(
                                            textSize: 12.px,
                                            textWeight: FontWeight.w400,
                                            textColor: controller.appColors.black,
                                            textFamily: fontFamilyRegular,
                                          ),
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: 16.px).paddingOnly(bottom: 8.px),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.px),
                                      child: MyTextView(
                                        item.massage,
                                        isMaxLineWrap: true,
                                        textStyleNew: MyTextStyle(
                                          textSize: 16.px,
                                          textWeight: FontWeight.w400,
                                          textColor: controller.appColors.black,
                                          textFamily: fontFamilyRegular,
                                        ),
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(vertical: 16.px),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Column(
                  children: [
                    ShadowContainer(
                      radius: 0.0,
                      padding: EdgeInsets.symmetric(horizontal: 32.px, vertical: 16.px),
                      margin: EdgeInsets.zero,
                      elevation: 0.0,
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 0,
                            child: InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: controller.appColors.appColor,
                                child: InkWell(
                                  onTap: () {
                                    controller.listen();
                                  },
                                  child: SvgPicture.string(
                                    icMike1,
                                    // height: 48.px,
                                    color: controller.isListening.value
                                        ? controller.appColors.delete
                                        : controller.appColors.white,
                                  ),
                                ),
                              ),
                            ).paddingOnly(bottom: 2.0, left: 10, right: 10),
                          ),
                          Flexible(
                            flex: 1,
                            child: controller.sendAudioButton
                                ? SizedBox(
                                    child: CommonTextField(
                                      height: 55.px,
                                      borderRadius: 25.px,
                                      color: controller.appColors.textField,
                                      controller: controller.messageController,
                                      hintText: "Type your message here",
                                      hintTextStyle: MyTextStyle(
                                          textColor: controller.appColors.border,
                                          textSize: 20.px,
                                          textFamily: fontFamilyRegular,
                                          textWeight: FontWeight.w400),
                                    ),
                                  )
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width - 55,
                                    child: Card(
                                        margin: EdgeInsets.only(left: 2.px, right: 2.px, bottom: 8.px),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                        child: TextFormField(
                                          controller: controller.messageController,
                                          focusNode: controller.focusNode,
                                          textAlignVertical: TextAlignVertical.center,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 5,
                                          minLines: 1,
                                          showCursor: false,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              controller.sendChatButton = true;
                                            } else {
                                              controller.sendChatButton = false;
                                            }
                                            controller.update();
                                          },
                                          decoration: InputDecoration(
                                            fillColor: Colors.lightBlueAccent,
                                            border: InputBorder.none,
                                            suffixIcon: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 50,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.mic,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      controller.sendChatButton = false;
                                                      controller.sendAudioButton = true;
                                                      controller.update();
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            ),
                                            contentPadding: EdgeInsets.all(5.px),
                                          ),
                                        ))),
                          ),
                          Expanded(
                            flex: 0,
                            child: CommonIconButton(
                                icon: icSend,
                                iconheigth: 20.px,
                                title: Strings.send,
                                radius: 100.px,
                                padding: EdgeInsets.fromLTRB(16.px, 10.px, 24.px, 10.px),
                                color: controller.appColors.appColor,
                                textColor: controller.appColors.white,
                                textFamily: fontFamilyRegular,
                                textWeight: FontWeight.w500,
                                textSize: 16.px,
                                onTap: () {
                                  if (controller.sendAudioButton == false) {}
                                  controller.sendAudioButton = true;
                                  controller.sendChatButton = false;
                                  if (controller.messageController.text.isNotEmpty) {
                                    controller.itemCount.add(RxCommonModel(
                                        title: Strings.userName,
                                        subtitle: "Today at ${DateFormat('hh:mm a').format(DateTime.now())}",
                                        massage: controller.messageController.text.trim(),
                                        image: ImagePath.user));
                                    controller.messageController.clear();
                                  }
                                  controller.update();
                                }).paddingOnly(bottom: 2.px, left: 10.px, right: 10.px),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

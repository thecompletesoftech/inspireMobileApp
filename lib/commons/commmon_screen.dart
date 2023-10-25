import 'all.dart';

class CommonScreen extends StatelessWidget {
  const CommonScreen(
      {Key? key,
      this.child,
      this.title,
      this.titleEnable = true,
      this.actions,
      this.actionEnable = false,
      this.onTap,
      this.resizeToAvoidBottomInset = true})
      : super(key: key);

  final Widget? child;
  final Widget? title;
  final bool titleEnable;
  final bool actionEnable;
  final bool? resizeToAvoidBottomInset;
  final List<Widget>? actions;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils().hideKeyboard();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // color: AppColors().white,
          image: DecorationImage(
              image: AssetImage(
                selectedLang == Constants.languageCodeAr ? ImagePath.commonBgAr : ImagePath.commonBg,
              ),
              fit: BoxFit.fill),
        ),
        child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: AppBar(
              leadingWidth: 9.h,
              toolbarHeight: 10.h,
              leading: Padding(
                padding: EdgeInsets.only(
                    left: selectedLang == Constants.languageCodeAr ? 0 : 3.h,
                    right: selectedLang == Constants.languageCodeAr ? 3.h : 0),
                child: GestureDetector(
                  onTap: onTap,
                  child: RotatedBox(
                    quarterTurns: selectedLang == Constants.languageCodeAr ? 2 : 0,
                    child: Image.asset(
                      ImagePath.commonBackBtn,
                      height: 45.px,
                      width: 45.px,
                    ),
                  ),
                ),
              ),
              title: titleEnable ? title : null,
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(child: child!)),
      ),
    );
  }
}

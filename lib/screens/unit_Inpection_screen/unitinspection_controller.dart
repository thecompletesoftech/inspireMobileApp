import '../../commons/all.dart';

class UnitController extends BaseController {
  TextEditingController unitnumberoRname = TextEditingController();
  TextEditingController unitAddress = TextEditingController();
  TextEditingController bedrooms = TextEditingController();
  TextEditingController bathrooms = TextEditingController();
  var switchbtn = false.obs;

  getunitinspection() {
    return unitnumberoRname.text.isNotEmpty && unitAddress.text.isNotEmpty;
  }
}

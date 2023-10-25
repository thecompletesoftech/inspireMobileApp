import 'package:get/get.dart';
import 'package:public_housing/screens/add_bank_detail/add_bank_detail_controller.dart';

class AddBankDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddBankDetailController>(AddBankDetailController());
  }
}

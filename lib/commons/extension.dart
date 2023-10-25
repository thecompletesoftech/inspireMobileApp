import 'all.dart';

extension $GetxExtension on GetInterface {
  T deleteAndPut<T>(T dependency, {String? tag}) {
    GetInstance().delete<T>(tag: tag, force: true);
    return Get.put<T>(dependency, tag: tag);
  }
}

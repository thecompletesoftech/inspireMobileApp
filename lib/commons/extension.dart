import 'all.dart';

extension $GetxExtension on GetInterface {
  T deleteAndPut<T>(T dependency, {String? tag}) {
    GetInstance().delete<T>(tag: tag, force: true);
    return Get.put<T>(dependency, tag: tag);
  }
}

extension FirstWhereOrNull<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

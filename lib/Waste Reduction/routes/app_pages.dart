// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/chat_image/bindings/chat_image_binding.dart';
import '../modules/chat_image/views/chat_image_view.dart';
import '../modules/chat_text/bindings/chat_text_binding.dart';
import '../modules/chat_text/views/chat_text_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.CHAT_IMAGE,
      page: () => const ChatImageView(),
      binding: ChatImageBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_TEXT,
      page: () => const ChatTextView(),
      binding: ChatTextBinding(),
    ),
  ];
}

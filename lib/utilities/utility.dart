import 'package:flutter/material.dart';

import 'package:get/get.dart';

class Utility {
  static SnackbarController snackBar(String msg) {
    return Get.snackbar(msg, "", snackPosition: SnackPosition.BOTTOM);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Show {
  static void showSnackBar(String title, String message, {int? duration}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: duration ?? 2),
        colorText: Colors.black);
  }

  static void showBottomError( String title, {required BuildContext context,}) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Text(
            title)));
  }

  static void showSuccessSnackBar(String title, String message, {int? duration,Color? textColor}) {
    Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: duration ?? 2),
      // backgroundColor: Colors,
      colorText: Colors.black,
      icon:  Icon(Icons.task_alt_rounded, color: Colors.black,),
    );
  }


  static void showErrorSnackBar(String title, String error, {int? duration}) {
    Get.snackbar(
      title,
      error,
      overlayBlur: 1,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(Icons.error_outlined, color: Colors.white,),
      isDismissible: true,
      duration: Duration(seconds: duration ?? 4),
    );
  }

  static void showWarningSnackBar(String title, String error, {int? duration}) {
    Get.snackbar(
      title,
      error,
      overlayBlur: 1,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange.shade700,
      colorText: Colors.black,
      icon: const Icon(Icons.error_outline, color: Colors.black,),
      isDismissible: true,
      duration: Duration(seconds: duration ?? 4),
    );
  }

  static void showLoader() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
      ),
      barrierDismissible: false,
    );
  }
}
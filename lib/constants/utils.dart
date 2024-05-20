import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/home_page.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  static bool areFieldsFilled(TextEditingController usernameController,
      TextEditingController passwordController) {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void updateUserProvider(BuildContext context, dynamic userDetails) {
    Provider.of<UsernameProvider>(context, listen: false)
        .changename(details: userDetails);
  }

  static void navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  static bool areFieldsFilledSignUp(
      TextEditingController usernameController,
      TextEditingController nameController,
      TextEditingController passwordController,
      TextEditingController confirmpassController) {
    return usernameController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmpassController.text.isNotEmpty;
  }

  static bool areSame(
    TextEditingController passwordController,
    TextEditingController confirmpassController,
  ) {
    return passwordController.text == confirmpassController.text;
  }

  static bool passwordStrong(
    TextEditingController passwordController,
  ) {
    return passwordController.text.length >= 8;
  }

  static void showFlushbar(BuildContext context, String message,
      {color = Colors.green}) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      maxWidth: 350,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: BorderRadius.circular(10),
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticInOut,
      backgroundColor: color, // Set the background color to green
      boxShadows: const [
        BoxShadow(
          color: Colors.black38,
          offset:
              Offset(0.0, 6.0), // Increase the offset to match the elevation
          blurRadius: 6.0, // Increase the blur radius to match the elevation
        ),
      ],
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white, // Set the text color to white
          fontSize: 16.0, // Set the font size to 16.0
          fontWeight: FontWeight.bold, // Set the font weight to bold
        ),
      ),
    ).show(context);
  }

  static Widget oneofthem(BuildContext context) {
    if (Provider.of<UsernameProvider>(context).user["profile_picture"] ==
        null) {
      return Text(
        Provider.of<UsernameProvider>(context).user["name"][0],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return ClipOval(
        child: Image.network(
          '$urlhttp' +
              Provider.of<UsernameProvider>(context, listen: false)
                  .user["profile_picture"],
          width: 100, // Set the desired width
          height: 100, // Set the desired height
          fit: BoxFit.cover,
        ),
      );
    }
  }
}

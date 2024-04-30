import 'package:flutter/material.dart';

class NavigatorUtil {
  /// The function `get` navigates to a new screen in a Flutter app using the provided `BuildContext`
  /// and `Widget`.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter in the `get` method is typically the
  /// `BuildContext` object that provides information about the location in the widget tree. It is used
  /// to access various properties and methods related to the current widget's context, such as finding
  /// ancestor widgets or navigating to a new screen.
  ///   widget (Widget): The `widget` parameter in the `get` method is of type `Widget`. It represents
  /// the widget that will be displayed when navigating to a new screen using the `Navigator.push`
  /// method in Flutter.
  static get(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  /// The function `getAnRemoveAll` navigates to a new screen and removes all previous routes in a
  /// Flutter app.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter in Flutter represents the location of a widget
  /// within the widget tree. It provides access to various services such as theme, localization, and
  /// navigation. In the code snippet you provided, the `context` parameter is used to access the
  /// `Navigator` to perform a navigation operation.
  ///   widget (Widget): The `widget` parameter in the `getAnRemoveAll` function is a Flutter widget that
  /// you want to navigate to and remove all the routes below it in the navigation stack. This widget
  /// will be used to create a new route in the navigator and remove all the routes until this new route.
  static getAnRemoveAll(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }
}

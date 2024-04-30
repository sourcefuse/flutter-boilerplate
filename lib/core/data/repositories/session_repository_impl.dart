import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_arch/core/domain/entities/mwuser.dart';
import 'package:clean_arch/core/domain/repositories/session_repository_contract.dart';
import 'package:clean_arch/core/injector.dart';
import 'package:clean_arch/utils/logs_util.dart';

class SessionRepositoryImpl implements SessionRepositoryContract {
  static String prefSession = 'PREF_SESSION';
  static String prefFcm = 'PREF_FCM';

  final PublishSubject<bool> _sessionExpiredSubject = PublishSubject<bool>();

  final BehaviorSubject<MWUser> _mwUserBehaviourSubject = BehaviorSubject();

  void _notifyListener(MWUser user) {
    _mwUserBehaviourSubject.add(user);
  }

  /// The function `isSessionActive` returns a stream that emits a boolean value indicating whether a
  /// session is active based on the presence of a session user preference.
  ///
  /// Returns:
  ///   A `Stream<bool>` is being returned. The stream emits a boolean value indicating whether a session
  /// is active or not.
  @override
  Stream<bool> isSessionActive() {
    return Stream.value(_getSessionUserPref()).map((sessionUser) {
      bool isSessionActive = sessionUser != null;
      if (isSessionActive) {
        _notifyListener(sessionUser);
      }
      return isSessionActive;
    }).onErrorReturn(false);
  }

  /// The function `getSessionUser` returns the current session user if available, otherwise it returns
  /// null.
  ///
  /// Returns:
  ///   The `getSessionUser` method is returning an instance of `MWUser` if the
  /// `_mwUserBehaviourSubject` has a value, otherwise it returns `null`.
  @override
  MWUser? getSessionUser() {
    if (_mwUserBehaviourSubject.hasValue) {
      return _mwUserBehaviourSubject.value;
    }

    return null;
  }

  @override
  Stream<MWUser> addUser(MWUser user) {
    // Starting new session with fresh user details
    _notifyListener(user);
    return _updateUserPref(user);
  }

  Stream<MWUser> _updateUserPref(MWUser user) {
    String jsonVal = jsonEncode(user.toJson());
    return Stream.fromFuture(
            sl<SharedPreferences>().setString(prefSession, jsonVal))
        .map((value) => user);
  }

  /// this will clear all the data from pref.
  @override
  Stream<bool> clearSession() {
    // clear pref data
    return Stream.value(sl<SharedPreferences>().clear()).map((noData) => true);
  }

  /// The function `updateUser` updates a user's preferences and notifies listeners, returning a stream
  /// of boolean values.
  ///
  /// Args:
  ///   user (MWUser): The `user` parameter in the `updateUser` method represents an instance of the
  /// `MWUser` class, which is used to update user preferences.
  ///
  /// Returns:
  ///   A `Stream<bool>` is being returned.
  @override
  Stream<bool> updateUser(MWUser user) {
    return _updateUserPref(user).map((session) {
      _notifyListener(user);
      return true;
    }).onErrorReturn(false);
  }

  /// The function `_getSessionUserPref` reads and decodes a JSON string from SharedPreferences to
  /// retrieve a `MWUser` object.
  ///
  /// Returns:
  ///   The function `_getSessionUserPref()` is returning an instance of `MWUser` if the session JSON
  /// data is successfully retrieved and decoded from the shared preferences. If there is an error
  /// during the process, it will return `null`.
  MWUser? _getSessionUserPref() {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    try {
      String? sessionJson = sharedPreferences.getString(prefSession);
      if (sessionJson != null) {
        final session = MWUser.fromJson(jsonDecode(sessionJson));
        return session;
      } else {
        return null;
      }
    } catch (exception) {
      LogsUtil.getInstance.printLog(
          'SessionManager: Error reading JSON from Pref: ${exception.toString()}');
      return null;
    }
  }

  /// This function returns a stream that emits boolean values indicating whether the session has
  /// expired.
  ///
  /// Returns:
  ///   A `Stream<bool>` is being returned.
  @override
  Stream<bool> sessionExpireObservable() {
    return _sessionExpiredSubject;
  }

  /// The `notifySessionExpired` function notifies subscribers that the session has expired.
  void notifySessionExpired() {
    _sessionExpiredSubject.add(true);
  }

  /// The function `updateFcmToken` updates the FCM token in SharedPreferences and returns a stream with
  /// a boolean value indicating the success of the operation.
  ///
  /// Args:
  ///   fcmToken (String): The `fcmToken` parameter in the `updateFcmToken` method is a string
  /// representing the Firebase Cloud Messaging (FCM) token that you want to update or store in the
  /// SharedPreferences.
  ///
  /// Returns:
  ///   A `Stream<bool>` is being returned.
  @override
  Stream<bool> updateFcmToken(String fcmToken) {
    return Stream.fromFuture(
            sl<SharedPreferences>().setString(prefFcm, fcmToken))
        .map((value) => value);
  }

  /// The function `getFcmToken` returns a stream containing the Firebase Cloud Messaging (FCM) token
  /// stored in SharedPreferences, or an empty string if the token is not found.
  ///
  /// Returns:
  ///   A stream of type String is being returned. The stream emits the value of the FCM token stored in
  /// SharedPreferences, or an empty string if the token is not found.
  @override
  Stream<String> getFcmToken() {
    return Stream.value(sl<SharedPreferences>().getString(prefFcm) ?? '');
  }
}

import 'package:clean_arch/core/domain/entities/mwuser.dart';

abstract class SessionRepositoryContract {
  Stream<MWUser> addUser(MWUser user);

  Stream<bool> updateUser(MWUser user);

  MWUser? getSessionUser();

  Stream<bool> isSessionActive();

  Stream<bool> clearSession();

  Stream<bool> sessionExpireObservable();

  Stream<bool> updateFcmToken(String fcmToken);

  Stream<String> getFcmToken();
}

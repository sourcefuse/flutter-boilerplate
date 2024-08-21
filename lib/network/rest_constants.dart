class RestConstants {
  static const String kApiHost = '';

  static const String kLiveBaseUrl = 'https://$kApiHost/api/';
  static const String kStagingBaseUrl = 'https://$kApiHost/api/';
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorized = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure
  static String kRefreshToken = "";

  static String kAuthTokenURL = "";

  static String kAuthMeURL = "";
}

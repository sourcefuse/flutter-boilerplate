/*
 * Created on 30 10 2023
 *
 * Author: Arun Sharma
 * Copyright (c) 2023 SourceFuse
 */

import 'package:dio/dio.dart';

import '../../../../network/base/base_api_ds.dart';
import '../../../../network/client/api_client.dart';
import '../../../../network/entities/base_response.dart';
import '../../../../network/rest_constants.dart';
import '../../../../utils/logger.dart';

// All API Implementation goes here.
class OnlineDS extends BaseApiDS {
  /// The `refreshTokenAPI` function sends a request to refresh an access token and updates the token in
  /// the shared preferences if the request is successful.
  ///
  /// Returns:
  ///   The function `refreshTokenAPI` returns a `Future<BaseResponse>`.
  Future<BaseResponse> refreshTokenAPI() async {
    var response = await callApi(
      ApiClient().dio().post(
            RestConstants.kRefreshToken,
            options: Options(headers: {
              ApiClient.kAuthorization: "",
            }),
            data: null,
          ),
    );

    if (response.success ?? false) {
      logger.d(response.data);
    }

    return response;
  }

  /// The `tokenAPI` function sends a POST request to the authentication API endpoint with the code and
  /// client ID as parameters, and returns the response.
  ///
  /// Returns:
  ///   a Future object of type BaseResponse.
  Future<BaseResponse> tokenAPI() async {
    var response = await callApi(
      ApiClient().dio().post(
            RestConstants.kAuthTokenURL,
            data: null,
          ),
    );

    if (response.success ?? false) {
      logger.d(response.data);
    }

    return response;
  }

  /// The `authMeAPI` function makes an API call to retrieve user authentication information and logs the
  /// response data if the call is successful.
  ///
  /// Returns:
  ///   The function `authMeAPI` returns a `Future<BaseResponse>`.
  Future<BaseResponse> authMeAPI() async {
    var response = await callApi(
      ApiClient().dio().get(
            RestConstants.kAuthMeURL,
            options: Options(headers: {
              ApiClient.kAuthorization: "",
              ApiClient.kContentType: 'application/json',
            }),
          ),
    );
    if (response.success ?? false) {
      logger.d(response.data);
    }
    return response;
  }
}

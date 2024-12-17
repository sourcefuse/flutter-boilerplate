import 'package:clean_arch/core/data/model/dashboard_res_model/dashboard_response.dart';
import 'package:clean_arch/core/data/model/login_res_model/login_response.dart';
import 'package:clean_arch/network/entities/network_exceptions.dart';
import 'package:clean_arch/presenter/ui/login/login_req_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../rest_constants.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: RestConstants.kStagingBaseUrl)
abstract class ApiClient {
  factory ApiClient({String? baseUrl, bool? showLoader}) {
    Dio dio = Dio();
    dio.options = BaseOptions(
        receiveTimeout: const Duration(seconds: 50),
        connectTimeout: const Duration(seconds: 50),
        baseUrl: RestConstants.kStagingBaseUrl);
    dio.options.headers["Authorization"] = "UserToken";
    RequestOptions? reqOptions;
    dio.interceptors.add(LogInterceptor(
        request: false,
        requestBody: false,
        requestHeader: false,
        responseBody: false,
        responseHeader: false));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (showLoader ?? true) {}
      reqOptions = options;
      return handler.next(options);
    }, onResponse: (response, handler) async {
      if (showLoader ?? true) {}
      return handler.next(response);
    }, onError: (DioException e, handler) {
      if (showLoader ?? true) {}
      retryApiFromClient(e, reqOptions, dio, handler);
      // return handler.next(err);
    }));
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @POST(RestConstants.loginUrl)
  Future<LoginResponseModel> loginUser(@Body() LoginRequestModel data);

  @POST(RestConstants.registerUrl)
  Future<LoginResponseModel> registerUser(@Body() LoginRequestModel data);

  @GET(RestConstants.posts)
  Future<List<DashboardResponse>?> fetchDashboardData();
}

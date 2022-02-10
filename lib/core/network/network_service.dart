import 'package:aimedic/core/network/retry_interceptor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'dio_connectivity_request_retrier.dart';

class NetworkService {

  static NetworkService? _instace;
  static NetworkService get instance {
    if (_instace != null) return _instace!;
    _instace = NetworkService._init();
    return _instace!;
  }

  final String _baseUrl1 = 'https://apidv.aimedic.tech/';
  late final Dio dio;

  NetworkService._init()  {
    dio = Dio(BaseOptions(baseUrl: _baseUrl1));

    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );
  }
}

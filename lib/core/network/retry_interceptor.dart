import 'dart:io';

import 'package:dio/dio.dart';
import 'dio_connectivity_request_retrier.dart';
import 'package:aimedic/core/network/refresh_service.dart';

import 'network_service.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError( DioError err, ErrorInterceptorHandler handler,) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        return e;
      }
    }
    return err;
  }

  bool _shouldRetry(DioError err) {
    print(err);
    if(err.response?.statusCode==403 || err.response?.statusCode==401)
      {
        Future.delayed(Duration(seconds: 5)).then((value) =>{
        RefreshService(NetworkService.instance.dio).refreshToken()
        });
      }
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }


}



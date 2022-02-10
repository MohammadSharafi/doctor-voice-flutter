import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                responseType: requestOptions.responseType,
                headers: requestOptions.headers,
                validateStatus: requestOptions.validateStatus,
                sendTimeout: requestOptions.sendTimeout,
                responseDecoder: requestOptions.responseDecoder,
                requestEncoder: requestOptions.requestEncoder,
                receiveTimeout: requestOptions.receiveTimeout,
                receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
                maxRedirects: requestOptions.maxRedirects,
                followRedirects: requestOptions.followRedirects,
                extra: requestOptions.extra,
                contentType: requestOptions.contentType,
                method: requestOptions.method,
                listFormat: requestOptions.listFormat,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}

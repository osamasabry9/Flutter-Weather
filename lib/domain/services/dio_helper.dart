// import 'package:dio/dio.dart';

// class DioHelper {
//   static Dio? dio;
//   static final DioHelper _instance = DioHelper._internal();
//   factory DioHelper() => _instance;
//   DioHelper._internal() {
//     dio = Dio(BaseOptions(
//       baseUrl: 'https://api.openweathermap.org/data/2.5/forecast',
//       receiveDataWhenStatusError: true,
//     ));
//   }

//   static Future<Response> getData({
//     required String url,
//   }) async {
//     return await dio!.get(
//       url,
//     );
//   }
// }

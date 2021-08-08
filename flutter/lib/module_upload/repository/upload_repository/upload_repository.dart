import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_upload/response/imgbb/imgbb_response.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
class UploadRepository {
  Future<ImgBBResponse> upload(String filePath) async {
    var client = Dio(BaseOptions(baseUrl: Urls.baseAPI));
    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath),
    });

    Logger().info('UploadRepo', 'Uploading: ' + filePath);

    Response response = await client.post(
      Urls.uploadAPI,
      data: data,
    );
    Logger().info('Got a Response', response.toString());
    print(client.httpClientAdapter);
    if (response == null) {
      return null;
    }
    return ImgBBResponse(url: response.data);
  }
}

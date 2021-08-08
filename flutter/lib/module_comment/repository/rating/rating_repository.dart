import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_comment/request/create_rating/create_rating.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class RatingRepository {
  final HttpClient _client;

  RatingRepository(this._client);

  Future<bool> postRating(CreateRatingRequest request) async {
    Map response = await this._client.post(Urls.rate, request.toJson());

    if (response == null) return false;
    return true;
  }
}

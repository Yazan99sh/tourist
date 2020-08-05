import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/requests/create_profile/create_profile_body.dart';
import 'package:tourists/responses/create_profile/create_profile_response.dart';

@provide
class IntentionsRepository {
  HttpClient _client;

  IntentionsRepository(this._client);

  Future<CreateProfileResponse> createIntentions(CreateProfileBody createProfileBody) async {
    String response = await _client.put(Urls.createProfileAPI, createProfileBody.toJson());
    if (response != null) {
      return CreateProfileResponse.fromJson(jsonDecode(response));
    }
    return null;
  }
}
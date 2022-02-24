import 'dart:convert';

import 'package:hubapp/helpers/constants.dart';
import 'package:hubapp/models/hub.dart';
import 'package:hubapp/models/hub_request.dart';
import 'package:hubapp/services/auth_service.dart';
import 'package:http/http.dart' as http;

class HubService {
  static final HubService instance = HubService._internal();
  factory HubService() => instance;
  HubService._internal();

  Future<Hub> createHub(HubRequest hubRequest) async {
    var url = Uri.https(HUB_API_DOMAIN, '/api/hubs');
    var response = await http.post(url,
        headers: _getHeaders(), body: json.encode(hubRequest.toJson()));
    var responseBody = json.decode(response.body);
    if (response.statusCode == 201) {
      return Hub.fromJson(responseBody);
    }
    throw Exception(
        'Hub creation failed, status: ${response.statusCode}, body: $responseBody');
  }

  Future<List<Hub>> listHubs() async {
    var url = Uri.https(HUB_API_DOMAIN, '/api/hubs');
    var response = await http.get(url, headers: _getHeaders());
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      return (responseBody as List<dynamic>)
          .map((hubJson) => Hub.fromJson(hubJson))
          .toList();
    }
    throw Exception(
        'Hub listing failed, status: ${response.statusCode}, body: $responseBody');
  }

  Map<String, String> _getHeaders() {
    var authService = AuthService.instance;
    return {
      'Authorization': 'Bearer ${authService.auth0AccessToken}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}

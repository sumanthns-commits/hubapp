import 'dart:convert';

import 'package:hubapp/helpers/constants.dart';
import 'package:hubapp/models/hub.dart';
import 'package:hubapp/models/hub_request.dart';
import 'package:hubapp/models/thing.dart';
import 'package:hubapp/models/thing_request.dart';
import 'package:hubapp/models/thing_state_change_request.dart';
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

  Future<Thing> createThing(String hubId, ThingRequest thingRequest) async {
    var url = Uri.https(HUB_API_DOMAIN, '/api/hubs/$hubId/things');
    var response = await http.post(url,
        headers: _getHeaders(), body: json.encode(thingRequest.toJson()));
    var responseBody = json.decode(response.body);
    if (response.statusCode == 201) {
      return Thing.fromJson(responseBody);
    }
    throw Exception(
        'Failed to add thing to hub $hubId, status: ${response.statusCode}, body: $responseBody');
  }

  Future<void> updateThingState(
      String hubId, String thingId, ThingStateChangeRequest request) async {
    var url = Uri.https(HUB_API_DOMAIN, '/api/hubs/$hubId/things/$thingId');
    var response = await http.patch(url,
        headers: _getHeaders(), body: json.encode(request.toJson()));
    var responseBody = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to update thing $thingId of hub $hubId, status: ${response.statusCode}, body: $responseBody');
    }
  }

  Future<void> deleteHub(String hubId) async {
    var url = Uri.https(HUB_API_DOMAIN, '/api/hubs/$hubId');
    var response = await http.delete(url, headers: _getHeaders());
    if (response.statusCode != 204) {
      throw Exception(
          'Failed to delete hub $hubId, status: ${response.statusCode}');
    }
  }
}

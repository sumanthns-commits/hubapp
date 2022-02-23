import 'package:flutter/cupertino.dart';
import 'package:hubapp/models/hub.dart';
import 'package:hubapp/models/hub_request.dart';
import 'package:hubapp/services/hub_service.dart';

class HubProvider with ChangeNotifier {
  List<Hub> _hubs = [];

  List<Hub> get hubs => List<Hub>.unmodifiable(_hubs);

  Future<void> loadHubs() async {
    _hubs = await HubService.instance.listHubs();
  }

  Future<void> addHub(HubRequest hubRequest) async {
    var hub = await HubService.instance.createHub(hubRequest);
    _hubs.add(hub);
    notifyListeners();
  }
}

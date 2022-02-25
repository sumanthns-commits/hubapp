import 'package:flutter/cupertino.dart';
import 'package:hubapp/models/hub.dart';
import 'package:hubapp/models/hub_request.dart';
import 'package:hubapp/models/thing.dart';
import 'package:hubapp/models/thing_request.dart';
import 'package:hubapp/models/thing_state_change_request.dart';
import 'package:hubapp/services/hub_service.dart';
import 'package:collection/collection.dart';

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

  Future<void> addThing(String hubId, ThingRequest thingRequest) async {
    Hub? hub = _hubs.firstWhereOrNull((hub) => hub.id == hubId);
    if (hub != null) {
      Thing thing = await HubService.instance.createThing(hubId, thingRequest);
      hub.addThing(thing);
      notifyListeners();
    }
  }

  Hub? findHub(String id) {
    return _hubs.firstWhereOrNull((hub) => hub.id == id);
  }

  Future<void> updateThingState(
      String thingId, bool newValue, String hubId) async {
    Hub? hub = _hubs.firstWhereOrNull((hub) => hub.id == hubId);
    if (hub != null) {
      Thing? thing =
          hub.things.firstWhereOrNull((element) => element.id == thingId);
      if (thing != null && thing.isOn() != newValue) {
        await HubService.instance.updateThingState(
            hubId, thingId, ThingStateChangeRequest.fromValue(newValue));
        hub.updateThingState(thingId, newValue);
        notifyListeners();
      }
    }
  }

  Future<void> removeHub(String hubId) async {
    Hub? hub = _hubs.firstWhereOrNull((hub) => hub.id == hubId);
    if (hub != null) {
      await HubService.instance.deleteHub(hubId);
      _hubs.removeWhere((element) => element.id == hubId);
      notifyListeners();
    }
  }
}

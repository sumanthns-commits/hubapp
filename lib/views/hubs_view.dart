import 'package:flutter/cupertino.dart';
import 'package:hubapp/providers/hub_provider.dart';
import 'package:provider/provider.dart';

class HubsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hubsProvider = context.watch<HubProvider>();
    Future<void> hubsFuture = Future.value();
    if (hubsProvider.hubs.isEmpty) {
      hubsFuture = hubsProvider.loadHubs();
    }
    return FutureBuilder<void>(
        future: hubsFuture,
        builder: (BuildContext innerContext, AsyncSnapshot<void> snapshot) {
          return ListView(
            children: hubsProvider.hubs
                .map((hub) => Container(
                      child: Text(hub.id),
                    ))
                .toList(),
          );
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hubapp/providers/hub_provider.dart';
import 'package:hubapp/screens/create_hub_screen.dart';
import 'package:hubapp/views/hub_tile.dart';
import 'package:provider/provider.dart';

class HubsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hubsProvider = context.watch<HubProvider>();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hubsProvider.hubs.isEmpty) ...[
            Text(
              'You don\'t have any hubs yet :(',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(
              height: 20,
            ),
          ],
          ...hubsProvider.hubs.map((hub) => HubTile(hub: hub)).toList(),
          OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(CreateHubScreen.routeName);
              },
              icon: const Icon(
                Icons.add,
                size: 18,
              ),
              label: Text('Create new hub')),
        ],
      ),
    );
  }
}

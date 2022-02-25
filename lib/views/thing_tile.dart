import 'package:flutter/material.dart';
import 'package:hubapp/models/thing.dart';
import 'package:hubapp/providers/hub_provider.dart';
import 'package:provider/provider.dart';

class ThingTile extends StatefulWidget {
  final Thing thing;
  final String hubId;

  const ThingTile({Key? key, required this.thing, required this.hubId})
      : super(key: key);

  @override
  _ThingTileState createState() => _ThingTileState();
}

class _ThingTileState extends State<ThingTile> {
  late bool _thingState;

  @override
  void initState() {
    _thingState = this.widget.thing.isOn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _thingState,
      onChanged: (bool newValue) {
        _changeThingState(newValue, context, this.widget.thing.id);
      },
      title: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.thing.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
            ),
            Text(widget.thing.description),
          ],
        ),
      ),
    );
  }

  void _changeThingState(
      bool newValue, BuildContext context, String thingId) async {
    var hubProvider = Provider.of<HubProvider>(context, listen: false);
    await hubProvider.updateThingState(thingId, newValue, this.widget.hubId);
    setState(() {
      _thingState = newValue;
    });
  }
}

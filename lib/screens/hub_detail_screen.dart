import 'package:flutter/material.dart';
import 'package:hubapp/models/hub.dart';
import 'package:hubapp/providers/hub_provider.dart';
import 'package:hubapp/screens/add_thing_screen.dart';
import 'package:hubapp/views/thing_tile.dart';
import 'package:provider/provider.dart';

class HubDetailScreen extends StatefulWidget {
  final String hubId;
  static const String routeName = '/hub';

  const HubDetailScreen({Key? key, required this.hubId}) : super(key: key);

  @override
  _HubDetailScreenState createState() => _HubDetailScreenState();
}

class _HubDetailScreenState extends State<HubDetailScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var hubProvider = Provider.of<HubProvider>(context);
    var hub = hubProvider.findHub(this.widget.hubId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hub"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _deleteHub(context, hub);
              },
              icon: const Icon(
                Icons.delete,
                size: 30,
              ))
        ],
      ),
      body: hub == null
          ? Text('Hub not found')
          : isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          hub.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(
                          hub.description,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          height: 2,
                        ),
                        Text(
                          'Things',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        ...hub.things.map((thing) =>
                            ThingTile(thing: thing, hubId: widget.hubId)),
                        SizedBox(height: 20),
                        OutlinedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  AddThingScreen.routeName,
                                  arguments: hub);
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 18,
                            ),
                            label: Text('Add another thing')),
                      ],
                    ),
                  ),
                ),
    );
  }

  void _deleteHub(BuildContext context, Hub? hub) async {
    if (hub == null) {
      return;
    }
    bool confirmDelete = await _confirmDeleteViaDialog(context, hub);
    if (!confirmDelete) {
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      var hubProvider = Provider.of<HubProvider>(context, listen: false);
      await hubProvider.removeHub(hub.id);
      Navigator.pop(context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _confirmDeleteViaDialog(BuildContext context, Hub hub) async {
    bool confirmDelete = false;
    // show the confirm dialog
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                  'You are about to delete the hub "${hub.name}". This action is irreversible.\nAre you sure want to delete?'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No')),
                TextButton(
                    onPressed: () {
                      confirmDelete = true;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'))
              ],
            ));
    return confirmDelete;
  }
}

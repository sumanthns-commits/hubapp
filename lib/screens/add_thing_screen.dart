import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hubapp/models/hub.dart';
import 'package:hubapp/models/thing_request.dart';
import 'package:hubapp/providers/hub_provider.dart';
import 'package:provider/provider.dart';

class AddThingScreen extends StatefulWidget {
  static const String routeName = '/thing';
  final Hub hub;

  const AddThingScreen({Key? key, required this.hub}) : super(key: key);

  @override
  _AddThingScreenState createState() => _AddThingScreenState();
}

class _AddThingScreenState extends State<AddThingScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  final passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Thing'),
        centerTitle: true,
      ),
      body: Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                        controller: descriptionController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton.icon(
                          onPressed: () {
                            _addThing(context);
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                          label: Text('Add'))
                    ],
                  ),
                )),
      ),
    );
  }

  Future<void> _addThing(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        var name = this.nameController.text;
        var description = this.descriptionController.text;
        var thingRequest = ThingRequest(name, description);
        var hubProvider = Provider.of<HubProvider>(context, listen: false);
        await hubProvider.addThing(this.widget.hub.id, thingRequest);
        Navigator.pop(context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

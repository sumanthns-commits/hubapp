import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hubapp/models/hub_request.dart';
import 'package:hubapp/providers/hub_provider.dart';
import 'package:provider/provider.dart';

class CreateHubScreen extends StatefulWidget {
  @override
  _CreateHubScreenState createState() => _CreateHubScreenState();
}

class _CreateHubScreenState extends State<CreateHubScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  final passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Hub'),
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
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText:
                                'configure hub device with the same password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            )),
                        controller: passwordController,
                        obscureText: !_passwordVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: _passwordValidator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton.icon(
                          onPressed: () {
                            _createHub(context);
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                          label: Text('Create'))
                    ],
                  ),
                )),
      ),
    );
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    var passwordRegex = new RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$",
        caseSensitive: true,
        multiLine: false);
    if (!passwordRegex.hasMatch(value)) {
      return 'Password should be of atleast 8 characters and contain at least one uppercase letter, one lowercase letter and one number';
    }
  }

  Future<void> _createHub(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        var name = this.nameController.text;
        var password = this.passwordController.text;
        var description = this.descriptionController.text;
        var hubRequest = HubRequest(name, description, password);
        await Provider.of<HubProvider>(context, listen: false)
            .addHub(hubRequest);
        await Navigator.of(context).pushNamed('/');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

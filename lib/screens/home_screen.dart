import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hubapp/providers/hub_provider.dart';
import 'package:hubapp/services/auth_service.dart';
import 'package:hubapp/views/hubs_view.dart';
import 'package:hubapp/widgets/hub_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isProgressing = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          isLoggedIn
              ? IconButton(
                  onPressed: logoutAction,
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                  ))
              : Text('')
        ],
      ),
      body: isProgressing
          ? Center(child: CircularProgressIndicator())
          : isLoggedIn
              ? SingleChildScrollView(
                  child: HubsView(),
                )
              : Center(
                  child: TextButton(
                    onPressed: () => loginAction(context),
                    child: Text('Login | Register'),
                  ),
                ),
    );
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }

  setLoadingState() {
    setState(() {
      isProgressing = true;
      errorMessage = '';
    });
  }

  setSuccessAuthState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
      name = AuthService.instance.idToken?.name;
    });
  }

  Future<void> loginAction(BuildContext context) async {
    setLoadingState();
    final message = await AuthService.instance.login();
    if (message == 'Success') {
      await context.read<HubProvider>().loadHubs();
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
        errorMessage = message;
      });
    }
  }

  initAction() async {
    setLoadingState();
    final bool isAuth = await AuthService.instance.init();
    if (isAuth) {
      await _loginSuccessSifeEffect();
    } else {
      setState(() {
        isProgressing = false;
      });
    }
  }

  Future<void> _loginSuccessSifeEffect() async {
    await context.read<HubProvider>().loadHubs();
    setSuccessAuthState();
  }

  logoutAction() async {
    await AuthService.instance.logout();
    setState(() {
      isLoggedIn = false;
    });
  }
}

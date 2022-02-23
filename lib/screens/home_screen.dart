import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hubapp/services/auth_service.dart';
import 'package:hubapp/views/hubs_view.dart';
import 'package:hubapp/widgets/hub_drawer.dart';

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
      ),
      drawer: HubDrawer(isLoggedIn: isLoggedIn, logoutAction: logoutAction),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isProgressing)
                CircularProgressIndicator()
              else if (!isLoggedIn)
                TextButton(
                  onPressed: loginAction,
                  child: Text('Login | Register'),
                )
              else ...[
                Text(
                  'Welcome $name !',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                HubsView(),
              ],
            ],
          ),
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

  Future<void> loginAction() async {
    setLoadingState();
    final message = await AuthService.instance.login();
    if (message == 'Success') {
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
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
      });
    }
  }

  logoutAction() async {
    await AuthService.instance.logout();
    setState(() {
      isLoggedIn = false;
    });
  }
}

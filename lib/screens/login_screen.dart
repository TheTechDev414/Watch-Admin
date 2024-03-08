import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/helper/utility.dart';
import 'package:watch_admin/screens/home_screen.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/widgets/newWidget/customLoader.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHidden = true;
  CustomLoader loader;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController(),
      _password = TextEditingController();

  @override
  void initState() {
    loader = CustomLoader();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Consumer<ThemeNotifier>(
          builder: (context, notifier, index) {
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                WidgetAnimator(Image.asset(
                  "assets/logo.jpeg",
                  height: 120,
                  width: 120,
                )),
                SizedBox(
                  height: 20,
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                        controller: _email,
                      keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  notifier.darkTheme ? Colors.white : primary,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: notifier.darkTheme
                                    ? Colors.white
                                    : primary),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Enter your Email",
                        )),
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18, bottom: 18),
                    child: TextField(
                        controller: _password,
                        obscureText: isHidden,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },
                              icon: Icon(
                                isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  notifier.darkTheme ? Colors.white : primary,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: notifier.darkTheme
                                    ? Colors.white
                                    : primary),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Enter your Password",
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        color: primary,
                        onPressed: () {
                          _emailLogin();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: secondary,
                              fontSize: 20,
                            ),
                          ),
                        )),
                  ),
                )
              ],
            );
          },
        ));
  }

  void _emailLogin() {
    var state = Provider.of<AuthState>(context, listen: false);
    if (state.isbusy) {
      return;
    }
    loader.showLoader(context);
    var isValid =
        validateCredentials(_scaffoldKey, _email.text, _password.text);
    if (isValid) {
      state
          .signIn(_email.text, _password.text, scaffoldKey: _scaffoldKey)
          .then((status) {
            print(state.user.email);
        if (state.user != null) {
          loader.hideLoader();

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);

          // widget.loginCallback();
        } else {
          cprint('Unable to login', errorIn: '_emailLoginButton');
          loader.hideLoader();
        }
      });
    } else {
      loader.hideLoader();
    }
  }
}

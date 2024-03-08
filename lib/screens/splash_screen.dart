import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/helper/enum.dart';
import 'package:watch_admin/screens/home_screen.dart';
import 'package:watch_admin/state/authState.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds:8),
            (){
          var state = Provider.of<AuthState>(context, listen: false);
          // state.authStatus = AuthStatus.NOT_DETERMINED;
          state.getCurrentUser();
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => Login()));
        }
    );
  }
Widget _body(){
    return Consumer<ThemeNotifier>(
      builder: (context,notifier,index){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/logo.jpeg",height: 150,width: 150,),
            SizedBox(height: 10,),
            Text("Elite Edge Ware",style: TextStyle(color: notifier.darkTheme ? Colors.white :primary,fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 100,),
            SpinKitRipple(color: notifier.darkTheme ? Colors.white :primary,)
          ],
        );
      },
    );

}
  @override
  Widget build(BuildContext context) {

    var state = Provider.of<AuthState>(context);
    return Scaffold(
       body:  state.authStatus == AuthStatus.NOT_DETERMINED
           ? _body()
           : state.authStatus == AuthStatus.NOT_LOGGED_IN
           ? Login()
           : HomeScreen(),
    );
  }
}

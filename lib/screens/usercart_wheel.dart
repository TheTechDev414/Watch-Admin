import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/models/user.dart';
import 'package:watch_admin/state/chats/chatState.dart';
import 'package:watch_admin/state/searchState.dart';

class UserCartWheel extends StatefulWidget {
  @override
  _UserCartWheelState createState() => _UserCartWheelState();
}

class _UserCartWheelState extends State<UserCartWheel> {

  final StreamController _dividerController = StreamController<int>();

  dispose() {
    _dividerController.close();
  }

  @override
  Widget build(BuildContext context) {
    var searchState = Provider.of<SearchState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Give Away"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinningWheel(
              Image.asset('assets/roulette-8-300.png'),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.6,
              canInteractWhileSpinning: false,
              dividers: 8,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage:
              Image.asset('assets/roulette-center-300.png'),
              secondaryImageHeight: 110,
              secondaryImageWidth: 110,
            ),
            SizedBox(height: 30),
            StreamBuilder(
              stream: _dividerController.stream,
              builder: (context, snapshot) =>
              snapshot.hasData ? RouletteScore(selected:snapshot.data,registeredusers: searchState.userlist,) : Container(),
            )
          ],
        ),
      ),
    );
  }

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatefulWidget {
  final int selected;
  final List<UserModel> registeredusers;

  const RouletteScore({Key key, this.selected, this.registeredusers}) : super(key: key);



  @override
  _RouletteScoreState createState() => _RouletteScoreState();
}

class _RouletteScoreState extends State<RouletteScore> {

   Map<int, String> labels=new Map<int,String>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<widget.registeredusers.length;i++){
      labels[i]=widget.registeredusers[i].displayName;
    }
  }
  @override
  Widget build(BuildContext context) {

    return Column(children:[Text('${labels[widget.selected]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0)),

      WidgetAnimator(
        FlatButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            color: Colors.red,
            onPressed: (){

              final chatState = Provider.of<ChatState>(context, listen: false);
              chatState.setChatUser = widget.registeredusers[widget.selected];
              Navigator.pushNamed(context, '/ChatScreenPage');

            }, icon: Icon(Icons.chat,color: Colors.white,), label: Text("Contact",style: TextStyle(color: Colors.white),)),
      ),
    ]);
  }
}

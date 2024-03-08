import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/screens/widgets/board_view.dart';
import 'package:watch_admin/screens/widgets/model.dart';
import 'package:watch_admin/screens/winners.dart';
import 'package:watch_admin/state/adminState.dart';
import 'package:watch_admin/state/chats/chatState.dart';
import 'package:watch_admin/state/searchState.dart';

class CartWheel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartWheelState();
  }
}

class _CartWheelState extends State<CartWheel>
    with SingleTickerProviderStateMixin {
  double _angle = 0;
  double _current = 0;
  AnimationController _ctrl;
  Animation _ani;
  List<Luck> _items = List<Luck>();
  bool loader=false;
  // [
  //   Luck("Afnan", Colors.accents[0]),
  //   Luck("Hassan", Colors.accents[2]),
  //   Luck("Ali", Colors.accents[4]),
  //   Luck("Hamza", Colors.accents[6]),
  //   Luck("Huzaifa", Colors.accents[8]),
  //   Luck("Hasham", Colors.accents[10]),
  //   Luck("Maaz", Colors.accents[12]),
  //   Luck("Talha", Colors.accents[14]),
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fill_data();
    var _duration = Duration(milliseconds: 40000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }
  fill_data(){
    setState(() {
      loader=true;
    });
    var adminState = Provider.of<AdminState>(context, listen: false);
    for(int i=0;i<adminState.contestusers.length;i++){
      _items.add(Luck(adminState.contestusers[i].displayName,adminState.contestusers[i].profilePic, Colors.accents[i]));
    }
    setState(() {
      loader=false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Give Away"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Winners',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WinnerScreen()));

            },
          ),

        ],
      ),
      body: loader?SpinKitRipple(color: secondary,):Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green, Colors.blue.withOpacity(0.2)])),
            //),),
        child: AnimatedBuilder(
            animation: _ani,
            builder: (context, child) {
              final _value = _ani.value;
              final _angle = _value * this._angle;
              return Column(
//                alignment: Alignment.center,
                children: <Widget>[
                  BoardView(items: _items, current: _current, angle: _angle),
                  _buildGo(),
                  if (!_ctrl.isAnimating)
                    _buildResult(_value),
                ],
              );
            }),
      ),
    );
  }

  _buildGo() {
    return Material(
      color: Colors.white,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        child: Container(
          alignment: Alignment.center,
          height: 72,
          width: 72,
          child: Text(
            "GO",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold,color: Colors.black),
          ),
        ),
        onTap: _animation,
      ),
    );
  }

  _animation() {
    if (!_ctrl.isAnimating) {
      var _random = Random().nextDouble();
      _angle = 20 + Random().nextInt(5) + _random;
      _ctrl.forward(from: 0.0).then((_) {
        _current = (_current + _random);
        _current = _current - _current ~/ 1;
        _ctrl.reset();
      });
    }
  }

  int _calIndex(value) {
    var _base = (2 * pi / _items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * _items.length).floor();
  }

  _buildResult(_value) {
    var _index = _calIndex(_value * _angle + _current);
   // var searchState = Provider.of<SearchState>(context, listen: false);

    var adminState = Provider.of<AdminState>(context, listen: false);
    // String _asset = _items[_index].asset;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(children: [
          Image.network(_items[_index].image, height: 80, width: 80),
          Text(_items[_index].name,style: TextStyle(color: Colors.black),),
          WidgetAnimator(
            FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                color: Colors.red,
                onPressed: (){
                  adminState.contestusers[_index].createdAt=DateTime.now().toString();
                  adminState.addWinner(adminState.contestusers[_index]);
                  SweetAlert.show(context,
                      title: "Congrats",
                      subtitle: "This user is selected for  giveaway",
                      confirmButtonText: "Message",
                      style: SweetAlertStyle.confirm,

                      showCancelButton: true,

                      onPress: (bool isConfirm) {
                        if (isConfirm) {

                          final chatState = Provider.of<ChatState>(context, listen: false);
                          chatState.setChatUser = adminState.contestusers[_index];
                          Navigator.pushNamed(context, '/ChatScreenPage');
                          // return false to keep dialog
                          return false;
                        }

                      }
                      );


                }, icon: Icon(Icons.chat,color: Colors.white,), label: Text("Select",style: TextStyle(color: Colors.white),)),
          ),

        ],)
      ),
    );
  }
}
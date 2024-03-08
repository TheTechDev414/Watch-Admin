import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';

class Newusers extends StatefulWidget {
  final isEdit;
  final String name;
  final String email;
  final String role;
  final String status;

  const Newusers({Key key, this.isEdit, this.name, this.email, this.role, this.status}) : super(key: key);
  @override
  _NewusersState createState() => _NewusersState();
}

class _NewusersState extends State<Newusers> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  String role;
  String status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.name;
    email.text = widget.email;
    role = widget.role;
    status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isEdit == true ?"Edit User":'Add User'),
      ),
      body: Consumer<ThemeNotifier>(
          builder:(context,notifier,value){
            return ListView(
              children: [
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: name,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: notifier.darkTheme ? Colors.white :primary,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: notifier.darkTheme ? Colors.white :primary),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Enter name",
                        )
                    ),
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: email,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: notifier.darkTheme ? Colors.white :primary,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: notifier.darkTheme ? Colors.white :primary),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Enter email",
                        )
                    ),
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint:  Text("Select Role"),
                          value: role,
                          onChanged: (String Value) {
                            setState(() {
                              role = Value;
                            });
                          },
                          items: ["Admin","Vendor"].map((String user) {
                            return  DropdownMenuItem<String>(
                              value: user,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Text(
                                    user,
                                    style:  TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint:  Text("Select Status"),
                          value: status,
                          onChanged: (String Value) {
                            setState(() {
                              status = Value;
                            });
                          },
                          items: ["Active","In Active"].map((String user) {
                            return  DropdownMenuItem<String>(
                              value: user,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Text(
                                    user,
                                    style:  TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        color: primary,
                        onPressed: (){
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }, child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.isEdit == true ?"Edit User":"Add User",style: TextStyle(
                        color: secondary,
                        fontSize: 20,
                      ),),
                    )),
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}

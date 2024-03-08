import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/models/watch_model_Model.dart';
import 'package:watch_admin/state/adminState.dart';

class AddWatchModel extends StatefulWidget {
  @override
  _AddWatchModelState createState() => _AddWatchModelState();
}

class _AddWatchModelState extends State<AddWatchModel> {
  TextEditingController
      new_brand=TextEditingController(),
      new_model=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AdminState>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add Watch Brands"),
        ),
        body: Consumer<ThemeNotifier>(builder: (context, notifier, value) {
          return ListView(
            children: [
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50,
                    width: double.infinity,
                    child: DropDown(
                      showUnderline: false,

                      items: state.brandnames,
                      // initialValue: user_customer_remainder_date.text,
                      hint: Text(
                        "Select Brand",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      onChanged: (value) {
                        setState(() {
                          new_brand.text = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),

                    child: GestureDetector(
                        onTap: () {
                          _addBrand(notifier);
                        },
                        child: Text("Enter new brand",textAlign:TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold,),)),

                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50,
                    width: double.infinity,
                    child: DropDown<watch_model_Model>(
                      showUnderline: false,
                      items: state.brandmodels
                          .where((element) =>
                              element.watch_brand ==
                              (new_brand.text == null || new_brand.text.isEmpty
                                  ? state.brandnames[0]
                                  : new_brand.text))
                          .toList(),
                      customWidgets: state.brandmodels
                          .where((element) =>
                              element.watch_brand ==
                              (new_brand.text == null || new_brand.text.isEmpty
                                  ? state.brandnames[0]
                                  : new_brand.text))
                          .toList()
                          .map((p) => buildDropDownRow(p))
                          .toList(),

                      // initialValue: user_customer_remainder_date.text,
                      hint: Text(
                        "Brand Model",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      onChanged: (watch_model_Model value) {
                        setState(() {new_model.text = value.watch_model;
                        });
                      },
                    ),
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(4),

                    child: GestureDetector(
                        onTap: () {

                          _addBrandModel(notifier);
                        },
                        child: Text("Enter new model",textAlign:TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold,),)),

                  ),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // WidgetAnimator(
              //   Padding(
              //     padding: const EdgeInsets.only(left: 28.0, right: 28),
              //     child: Container(
              //       width: 250,
              //       padding: EdgeInsets.all(4),
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //             // set border color
              //             ), // set border width
              //         borderRadius: BorderRadius.all(
              //             Radius.circular(10.0)), // set rounded corner radius
              //       ),
              //       child: TextField(
              //         controller: brand,
              //         cursorColor:
              //             notifier.darkTheme ? Colors.white : Color(0xff151d3a),
              //         style: TextStyle(
              //             color: notifier.darkTheme
              //                 ? Colors.white
              //                 : Color(0xff151d3a)),
              //         decoration: InputDecoration(
              //           prefixText: "     ",
              //           hintStyle: TextStyle(
              //             color: notifier.darkTheme
              //                 ? Colors.white
              //                 : Color(0xff151d3a),
              //           ),
              //           hintText: 'Enter brand',
              //           border: InputBorder.none,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

            ],
          );
        }));
  }

  Row buildDropDownRow(watch_model_Model model) {
    return Row(
      children: <Widget>[
        if (model.watch_brand == new_brand.text) Text(model.watch_model),
      ],
    );
  }

  _addBrand(notifier) async {
    await showDialog<String>(
      context: context,
        builder: (context) {
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[

                Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        // set border color
                      ), // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: new  TextField(
                      controller: new_brand,
                      cursorColor: notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                      style: TextStyle(
                          color: notifier.darkTheme
                              ? Colors.white
                              : Color(0xff151d3a)),
                      decoration: InputDecoration(
                        prefixText: "     ",
                        hintStyle: TextStyle(
                          color: notifier.darkTheme
                              ? Colors.white
                              : Color(0xff151d3a),
                        ),
                        hintText: 'Enter brand',
                        border: InputBorder.none,
                      ),
                    )
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('ADD'),
                  onPressed: () {
                    if(new_brand.text!=null||new_brand.text.isNotEmpty) {
                      final state = Provider.of<AdminState>(context,listen: false);
                      state.addBrandNames(new_brand.text);
                      new_brand.text=new_brand.text;
                      Navigator.pop(context);
                      new_brand.text="";
                    }

                  })
            ],
          );
        });
  }

  _addBrandModel(notifier) async {
    await showDialog<String>(
      context: context,
      builder: (context) {
        return new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Column(
            children: <Widget>[

              Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      // set border color
                    ), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // set rounded corner radius
                  ),
                  child: new  TextField(
                    controller: new_brand,
                    enabled: false,
                    cursorColor: notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                    style: TextStyle(
                        color: notifier.darkTheme
                            ? Colors.white
                            : Color(0xff151d3a)),
                    decoration: InputDecoration(
                      prefixText: "     ",
                      hintStyle: TextStyle(
                        color: notifier.darkTheme
                            ? Colors.white
                            : Color(0xff151d3a),
                      ),
                      hintText: 'Enter brand',
                      border: InputBorder.none,
                    ),
                  )
              ),
              SizedBox(height: 30,),
              Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      // set border color
                    ), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // set rounded corner radius
                  ),
                  child: new  TextField(
                    controller: new_model,
                    cursorColor: notifier.darkTheme ? Colors.white : Color(0xff151d3a),
                    style: TextStyle(
                        color: notifier.darkTheme
                            ? Colors.white
                            : Color(0xff151d3a)),
                    decoration: InputDecoration(
                      prefixText: "     ",
                      hintStyle: TextStyle(
                        color: notifier.darkTheme
                            ? Colors.white
                            : Color(0xff151d3a),
                      ),
                      hintText: 'Enter Model',
                      border: InputBorder.none,
                    ),
                  )
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  if(new_model.text!=null||new_model.text.isNotEmpty) {
                    final state = Provider.of<AdminState>(context,listen: false);
                    state.addBrandModel(new_brand.text,new_model.text);
                    new_model.text="";
                    Navigator.pop(context);
                  }
                })
          ],
        );
      },
    );
  }
}

// TextField(
//   controller: new_brand,
//   cursorColor:
//   notifier.darkTheme ? Colors.white : Color(0xff151d3a),
//   style: TextStyle(
//       color: notifier.darkTheme
//           ? Colors.white
//           : Color(0xff151d3a)),
//   decoration: InputDecoration(
//     prefixText: "     ",
//     hintStyle: TextStyle(
//       color: notifier.darkTheme
//           ? Colors.white
//           : Color(0xff151d3a),
//     ),
//     hintText: 'Enter brand',
//     border: InputBorder.none,
//   ),
// )
//
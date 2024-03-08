import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/models/signoffSheetModel.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/widgets/newWidget/customLoader.dart';

class SignOffSheet extends StatefulWidget {
  final SignoffSheetModel sheet;
  final bool isEdit;

  const SignOffSheet({Key key, this.sheet, this.isEdit}) : super(key: key);
  @override
  _SignOffSheetState createState() => _SignOffSheetState();
}

class _SignOffSheetState extends State<SignOffSheet> {
  SignoffSheetModel model;

TextEditingController _companyName=TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CustomLoader loader;

  static List<String> descriptionList =
  List<String>();

  static List<String> serionalNoList =
  List<String>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descriptionList.add(null);
    serionalNoList.add(null);
    loader = CustomLoader();
    model = SignoffSheetModel();

    var authstate = Provider.of<AuthState>(context, listen: false);
    _companyName.text=authstate.userModel.companyName;
    if(widget.isEdit??false){
      model=widget.sheet;

    }



  }


  @override
  Widget build(BuildContext context) {

    var authstate = Provider.of<AuthState>(context, listen: false);

    return Scaffold(
      appBar: header(context, titleText: 'SIGNOFF SHEET'),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Completion Form",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(child: _companyImage()),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: _companyName,
                  enabled: false,
                  // validator: (String value) {
                  //   if (value.isEmpty) {
                  //     return "Please fill out form";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  onChanged: (value) {
                    model.companyName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Company Name',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    disabledBorder:CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.jobNo = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Job No',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  // validator: (String value) {
                  //   if (value.isEmpty) {
                  //     return "Please fill out form";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  onChanged: (value) {
                    model.accountNo = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Account No',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.siteName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Site Name',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.siteAddress = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Site Address',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.postalCode = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Postal Code',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.telephoneNo = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Telephone No',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.siteContact = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Site Contact',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Please tick one of the below",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: CheckboxListTile(
                        title: new Text("Service Call"),
                        value: model.serviceCall??false,
                        onChanged: (bool value) {
                          setState(() {
                            model.serviceCall = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: CheckboxListTile(
                        title: new Text("Installation"),
                        value: model.installation??false,
                        onChanged: (bool value) {
                          setState(() {
                            model.installation = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: CheckboxListTile(
                        title: new Text("Delivery"),
                        value: model.delivery??false,
                        onChanged: (bool value) {

                          setState(() {
                            model.delivery = value;
                          });
                        },

                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: CheckboxListTile(
                        title: new Text("Survery"),
                        value: model.survery??false,
                        onChanged: (bool value) {
                          setState(() {
                            model.survery = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Description of work",
                  style: TextStyle(
                    color: primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 5,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please fill out form";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          model.comments = value;
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: "Comments",
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Please tick below where applicable",
                  style: TextStyle(
                    color: primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CheckboxListTile(
                title:
                    new Text("The system has been demonstrated to the client"),
                value: model.systemDemonstration??false,
                onChanged: (bool value) {
                  setState(() {
                    model.systemDemonstration = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              CheckboxListTile(
                title: new Text("Music has been left playing"),
                value: model.musicPlaying??false,
                onChanged: (bool value) {
                  setState(() {
                    model.musicPlaying = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              CheckboxListTile(
                title: new Text("Visuals are on screen"),
                value: model.visualScreen??false,
                onChanged: (bool value) {
                  setState(() {
                    model.visualScreen = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              CheckboxListTile(
                title: new Text("Volume Controls have been labelled"),
                value: model.volumeControls??false,
                onChanged: (bool value) {
                  setState(() {
                    model.volumeControls = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              CheckboxListTile(
                title: new Text(
                    "CloudCasting office confirmed to me that the media player is online:"),
                value: model.cloudcastingOfficeConfirmation??false,
                onChanged: (bool value) {
                  setState(() {
                    model.cloudcastingOfficeConfirmation = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              CheckboxListTile(
                title: new Text("Additional work is required"),
                value: model.additionalWork??false,
                onChanged: (bool value) {
                  setState(() {
                    model.additionalWork = value;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Equipment List & Serial Numbers:",
                  style: TextStyle(
                    color: primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
             ..._getUserDescriptionField(),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.engineerName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Engineers Name',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.date = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Date',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.timeOfArrival = value;
                  },
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
                    ).then((value) {
                      model.timeOfArrival = value.toString();

                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Time of Arrival',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  initialValue:
                  model.departureTime ,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please fill out form";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    model.departureTime = value;
                  },

                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
                    ).then((value) {
                      model.timeOfArrival = value.toString();

                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Departure Time',
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "Signature",
                  style: TextStyle(
                    color: primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              if(widget.isEdit??false)
                Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child:Image(
                  image: NetworkImage(widget.sheet.signature),
                  height: 150,
                ),
              ),


              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Signature(
                  controller: _controller,
                  height: 150,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //SHOW EXPORTED IMAGE IN NEW ROUTE
                      IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.blue,
                        onPressed: () async {
                          if (_controller.isNotEmpty) {
                            final Uint8List data =
                                await _controller.toPngBytes();

                            if (data != null) {
                              await Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    return Scaffold(
                                      appBar: AppBar(),
                                      body: Center(
                                        child: Container(
                                          color: Colors.grey[300],
                                          child: Image.memory(data),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                        },
                      ),
                      //CLEAR CANVAS
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() => _controller.clear());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: ButtonTheme(
                  minWidth: 200,
                  height: 50.0,
                  child: RaisedButton(
                    splashColor: Colors.deepPurpleAccent,
                    elevation: 5.0,
                    color: primary,
                    onPressed: () {
                      if (!formKey.currentState.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please complete form")));
                        // );
                      } else {
                        submitSignOffSheet();
                      }
                    },
                    child: new Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _companyImage() {
    var authstate = Provider.of<AuthState>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      height: 90,
      width: 90,
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.white, width: 5),
      //   shape: BoxShape.circle,
      //   image: DecorationImage(
      //       image: customAdvanceNetworkImage("https://png.pngtree.com/element_pic/16/11/03/dda587d35b48fd01947cf38931323161.jpg"),
      //       fit: BoxFit.cover),
      // ),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: customAdvanceNetworkImage(authstate.userModel.companyurl),
        // child: Container(
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     color: Colors.black38,
        //   ),
        //   child: Center(
        //     child: IconButton(
        //       onPressed: uploadImage,
        //       icon: Icon(Icons.camera_alt, color: Colors.white),
        //     ),
        //   ),
        // ),
      ),
    );
  }
  submitSignOffSheet() async {
    if (_controller.isNotEmpty != null) {
      loader.showLoader(context);
      var state = Provider.of<FeedState>(context, listen: false);

      var authstate = Provider.of<AuthState>(context, listen: false);
      final Uint8List data = await _controller.toPngBytes();
      String tempPath = (await getTemporaryDirectory()).path;
      File file = File('$tempPath/signature.png');
      file.writeAsBytesSync(data);
      String key = DateTime.now().microsecondsSinceEpoch.toString();
      model.senderId=authstate.userId;

     if(widget.isEdit??false) {
     }
     else{
       model.key = key;

     }
      if(file!=null) {
        await state.uploadFile(file,model.key).then((imagePath) {
          if (imagePath != null) {
            model.signature = imagePath;

            model.description=descriptionList;
            model.serialNo=serionalNoList;
              state.createSignOffSheet(model);
            loader.hideLoader();
            Navigator.pop(context);
          }
        });
      }
      else{
        model.description=descriptionList;
        model.serialNo=serionalNoList;
          state.createSignOffSheet(model);




      }
      loader.hideLoader();
    }
  }
  List<Widget> _getUserDescriptionField() {
    List<Widget> DescriptionFields = [];
    for (int i = 0; i < descriptionList.length; i++) {
      DescriptionFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: descriptionFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == descriptionList.length - 1, i),
          ],
        ),
      ));
    }
    return DescriptionFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          descriptionList.insert(
              0,null);
          serionalNoList.insert(0, null);
        } else {
          descriptionList.removeAt(index);
          serionalNoList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class descriptionFields extends StatefulWidget {
  final int index;

  descriptionFields(this.index);

  @override
  _descriptionFieldsState createState() =>
      _descriptionFieldsState();
}

class _descriptionFieldsState
    extends State<descriptionFields> {
  //TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    //   _nameController = TextEditingController();
  }

  @override
  void dispose() {
    // _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          children: [
            Container(
              width: fullHeight(context)*0.17,
              height: 50,
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please fill out form";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _SignOffSheetState.descriptionList[widget.index] =
                      value;
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                ),
              ),
            ),
            Spacer(),
            Container(
              width: fullHeight(context)*0.2,
              height: 50,
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please fill out form";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _SignOffSheetState.serionalNoList[widget.index] =
                      value;
                },
                decoration: InputDecoration(
                  labelText: 'Serial No',
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                ),
              ),
            ),
          ],
        ),
      );
  }
}
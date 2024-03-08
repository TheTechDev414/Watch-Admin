import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma/model/jobshot.dart';
import 'package:rehnuma/model/signoffSheetModel.dart';
import 'package:rehnuma/model/submittedJob.dart';
import 'package:rehnuma/state/authState.dart';
import 'package:rehnuma/state/feedState.dart';
import 'package:rehnuma/state/searchState.dart';
import 'package:rehnuma/utils/constants.dart';
import 'package:rehnuma/utils/constants2.dart';
import 'package:rehnuma/utils/size_config.dart';
import 'package:rehnuma/widgets/customWidgets.dart';
import 'package:rehnuma/widgets/newWidget/customLoader.dart';

class JobCompletedPage extends StatefulWidget {
  final bool isEdit;
  final JobsHot job;

  const JobCompletedPage({Key key, this.isEdit, this.job}) : super(key: key);

  @override
  _JobCompletedPageState createState() => _JobCompletedPageState();
}

class _JobCompletedPageState extends State<JobCompletedPage> {
  bool passwordVisible;
  bool passwordVisibleConfirm;
  TextEditingController _jobname, _jobdescription;
  SignoffSheetModel selectedSheet;

  List<File> _recieptsimage = List<File>();
  List<File> _image = List<File>();
  CustomLoader loader;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    // TODO: implement initState
    super.initState();
    loader = CustomLoader();
    _jobname = TextEditingController();
    _jobdescription = TextEditingController();
    _jobname.text = widget.job.title;
    _jobdescription.text = widget.job.jobDescription;
    passwordVisible = false;
    passwordVisibleConfirm = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _jobdescription.dispose();
    _jobname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var state = Provider.of<FeedState>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PageTitle(
                titleText: 'Job Filling Form',
                fontSize: 30.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              CommonInputForm(
                labelText: 'Enter Job Name',
                controller: _jobname,
              ),
              CommonInputForm(
                labelText: 'Enter Job Description',
                controller: _jobdescription,
              ),
              Container(
                width: fullWidth(context),
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.white, width: 1.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<SignoffSheetModel>(
                    dropdownColor: Color(0xFF1d499f),
                    hint: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Icon(
                            FontAwesomeIcons.tag,
                            size: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          ' Signoff Sheets',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ],
                    ),
                    // value: state.signoffsheets == null
                    //     ? null
                    //     : state.signoffsheets[0],
                    items: state.signoffsheets == null
                        ? null
                        : state.signoffsheets.map((SignoffSheetModel value) {
                            return DropdownMenuItem<SignoffSheetModel>(
                              value: value,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      FontAwesomeIcons.tag,
                                      size: 22.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "   " + value.engineerName,
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSheet = value;
                      });
                      print(selectedSheet);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: new FlatButton.icon(
                  label: Text("Add Images",
                      style:
                          new TextStyle(fontSize: 22.0, color: Colors.white)),
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 32,
                  ),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  splashColor: Colors.white,
                  onPressed: () {
                    getImage(_image);
                    //loadAssets();
                  },
                ),
              ),
              if (_image != null)
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,

                  child: GridView.builder(
                    primary: false,
                    itemCount: _image == null ? 0 : _image.length,
                    itemBuilder: (cyx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GridTile(
                            child: GestureDetector(
                                onTap: () {}, child: Image.file(_image[index])),
                            footer: GridTileBar(
                              backgroundColor: Colors.black87,
                              title: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _image.removeAt(index);
                                    });
                                  }),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                  ),
                  //})
                ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: new FlatButton.icon(
                  label: Text("Add Receipt",
                      style:
                          new TextStyle(fontSize: 22.0, color: Colors.white)),
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 32,
                  ),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  splashColor: Colors.white,
                  onPressed: () {
                    getImage(_recieptsimage);
                    //loadAssets();
                  },
                ),
              ),
              if (_recieptsimage != null)
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,

                  child: GridView.builder(
                    primary: false,
                    itemCount:
                        _recieptsimage == null ? 0 : _recieptsimage.length,
                    itemBuilder: (cyx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GridTile(
                            child: GestureDetector(
                                onTap: () {},
                                child: Image.file(_recieptsimage[index])),
                            footer: GridTileBar(
                              backgroundColor: Colors.black87,
                              title: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _recieptsimage.removeAt(index);
                                    });
                                  }),
                              // trailing: IconButton(
                              //   icon: Icon(
                              //     Icons.edit,
                              //     color: Theme.of(context).accentColor,
                              //   ),
                              //   onPressed: () {
                              //
                              //   },
                              // ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                  ),
                  //})
                ),
              GestureDetector(
                onTap: () {
                  submitJob();
                  //                    _submitForm();
                },
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Theme.of(context).accentColor)),
                  child: Container(
                    color: Theme.of(context).accentColor,
                    child: GestureDetector(
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                        ),
                        title: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 50.0, bottom: 10.0),
                            child: Text(
                              'Submit',
                              style: kH2WTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     openGoogleMapForDirections()
      //     // Add your onPressed code here!
      //   },
      //   child: Icon(FontAwesomeIcons.searchLocation),
      //   backgroundColor: Colors.green,
      // ),
      // bottomNavigationBar: BottomInfoBar(),
    );
  }

  Future getImage(List<File> images) async {
    final pickedFile =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        images.add(File(pickedFile.path));

        customSnackBar(_scaffoldKey, "${images.length} image added");
      } else {
        print('No image selected.');
      }
    });
  }

  submitJob() async {
    if (_image.length < 0 || _recieptsimage.length < 0) {
      customSnackBar(_scaffoldKey, 'Please upload image and reciepts');

      return;
    }

    if (selectedSheet == null) {
      customSnackBar(_scaffoldKey, 'Please select any signoffsheet');
      return;
    }

    CustomLoader loader = CustomLoader();
    var authstate = Provider.of<AuthState>(context, listen: false);
    var searchState = Provider.of<SearchState>(context, listen: false);

    var feedState = Provider.of<FeedState>(context, listen: false);
    SubmittedJob submittedJob = SubmittedJob(
        jobNo: widget.job.key,
        companyName: widget.job.companyName,
        signoffUid: selectedSheet.key,
        submittedDate: DateTime.now().toString(),
        title: widget.job.title);

    loader.showLoader(context);
    for (int i = 0; i < _image.length; i++) {
      await feedState.uploadImageFile(_image[i],widget.job.key).then((imagePath) {
        if (imagePath != null) {
          print(imagePath);
          submittedJob.images.add(imagePath);

          /// If type of tweet is new tweet
        }
      });
    }    for (int i = 0; i < _recieptsimage.length; i++) {
      await feedState.uploadImageFile(_recieptsimage[i],widget.job.key).then((imagePath) {
        if (imagePath != null) {
          print(imagePath);
          submittedJob.reciepts.add(imagePath);

          /// If type of tweet is new tweet
        }
      });
    }

  print(submittedJob.images);
  bool status = searchState.addcompletedJobDetailsinDatabase(widget.job, submittedJob);
  if (status) {
    Navigator.pop(context);
  } else {}
  loader.hideLoader();


  }

}
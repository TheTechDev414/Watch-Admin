//
// import 'package:flutter_twitter_clone/helper/utility.dart';
// import 'package:flutter_twitter_clone/state/appState.dart';
//
// class AdminState extends AppState {
//

//
//
// }

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:watch_admin/helper/utility.dart';
import 'package:watch_admin/models/blog_model.dart';
import 'package:watch_admin/models/faq.dart';
import 'package:watch_admin/models/notifications.dart';
import 'package:watch_admin/models/query.dart' as q;
import 'package:watch_admin/models/user.dart';
import 'package:watch_admin/models/watch_model_Model.dart';
import 'package:watch_admin/screens/DrawerPages/blogs.dart';
import 'appState.dart';
import 'package:path/path.dart' as Path;

class AdminState extends AppState {
  List<Slider> _sliders = List<Slider>();
  String _terms_and_condition = "";
  List<Faqs> _faqs = List<Faqs>();

  // List<Map<String,dynamic>> _notifications=  List<Map<String,dynamic>>();
  String _termsconditionlink = "";
  String _privacylink = "";
  List<String> _brandnames = List<String>();
  List<UserModel> _winnerusers = List<UserModel>();
  List<watch_model_Model> _brandmodel = new List<watch_model_Model>();
  List<Notifications> _notifications = List<Notifications>();
  int _days, _hours, _mins, _secs;
  String _contestdate;
  bool _enablecontest;
  List<UserModel> _contestusers = List<UserModel>();
  List<q.Query> _queries = List<q.Query>();


  String get terms_and_conditions {
    if (_terms_and_condition == null) {
      return "";
    } else {
      return _terms_and_condition;
    }
  }

  List<UserModel> get winner_users {
    if (_winnerusers == null) {
      return null;
    } else {
      return _winnerusers;
    }
  }

  List<UserModel> get contestusers {
    if (_contestusers == null) {
      return null;
    } else {
      return _contestusers;
    }
  }

  String get contestdate {
    if (_contestdate == null) {
      return "";
    } else {
      return _contestdate;
    }
  }

  bool get enablecontest {
    if (_enablecontest == null) {
      return false;
    } else {
      return _enablecontest;
    }
  }

  int get days {
    if (_days == null) {
      return 0;
    } else {
      return _days;
    }
  }

  int get hours {
    if (_hours == null) {
      return 0;
    } else {
      return _hours;
    }
  }

  int get mins {
    if (_mins == null) {
      return 0;
    } else {
      return _mins;
    }
  }

  int get secs {
    if (_secs == null) {
      return 0;
    } else {
      return _secs;
    }
  }

  List<watch_model_Model> get brandmodels {
    if (_brandmodel == null) {
      return null;
    } else {
      return _brandmodel;
    }
  }

  String get terms_link {
    if (_termsconditionlink == null) {
      return "";
    } else {
      return _termsconditionlink;
    }
  }

  String get privacy_link {
    if (_privacylink == null) {
      return "";
    } else {
      return _privacylink;
    }
  }

  List<Notifications> get notification {
    if (_notifications == null) {
      return null;
    } else {
      return _notifications;
    }
  }

  List<Slider> get sliders {
    if (_sliders == null) {
      return null;
    } else {
      return _sliders;
    }
  }

  getContestSetting() async {
    var snapshot = await kDatabase.child('contestsetting').once();
    if (snapshot.value != null) {
      var map = snapshot.value;
      String date = map["validtill"] == null ? "" : map["validtill"];

      _enablecontest = map["enable"] == null ? false : map["enable"];

      var temp_date = DateTime.now().difference(DateTime.parse(date)).inDays;
      _contestdate = date;

      if (temp_date < 0) {
        _enablecontest = false;
      }
      notifyListeners();
    } else {
      return null;
    }
  }

  List<q.Query> get queries {
    if (_queries == null) {
      return null;
    } else {
      return _queries;
    }
  }

  List<String> get brandnames {
    if (_brandnames == null) {
      return null;
    } else {
      return _brandnames;
    }
  }

  List<Faqs> get faqs {
    if (_faqs == null) {
      return null;
    } else {
      return _faqs;
    }
  }

  getFaqs() async {
    var snapshot = await kDatabase.child('faqs').once();
    _faqs.clear();
    if (snapshot.value != null) {
      var map = snapshot.value;

      map.forEach((key, value) {
        Faqs temp = Faqs();
        temp.question = key;
        temp.answer = value;
        _faqs.add(temp);
      });
    } else {
      return null;
    }
  }

  getContestUsers() async {
    var snapshot = await kDatabase.child('contest').once();
    if (snapshot.value != null) {
      var map = snapshot.value;

      map.forEach((key, value) {
        _contestusers.add(UserModel.fromJson(value));
      });
    } else {
      return null;
    }
    notifyListeners();
  }

  getNotification() async {
    var snapshot = await kDatabase.child('notifications').once();
    if (snapshot.value != null) {
      var map = snapshot.value;

      map.forEach((key, value) {
        _notifications.add(Notifications.fromJson(value));
      });
    } else {
      return null;
    }
    notifyListeners();
  }

  getWinnerUsers() async {
    var snapshot = await kDatabase.child('winners').once();
    if (snapshot.value != null) {
      var map = snapshot.value;

      map.forEach((key, value) {
        _winnerusers.add(UserModel.fromJson(value));
      });
    } else {
      return null;
    }
    notifyListeners();
  }

  addNotification(Notifications model) async {
    try {
      String key = DateTime.now().millisecondsSinceEpoch.toString();
      model.key = key;
      kDatabase.child('notifications').child(key).set(model.toJson());
      _notifications.add(model);
      notifyListeners();
    } catch (e) {
      print("Error adding notifcation");
    }
  }

  addWinner(UserModel model) async {
    try {
      String key = DateTime.now().millisecondsSinceEpoch.toString();
      model.key = key;
      kDatabase.child('winners').child(key).set(model.toJson());
      _winnerusers.add(model);
      notifyListeners();
    } catch (e) {
      print("Error adding winner");
    }
  }

  deleteWinner(UserModel model) async {
    try {
      kDatabase.child('winners').child(model.key).remove();
      _winnerusers.remove(model);
      notifyListeners();
    } catch (e) {
      print("Error deleting winner");
    }
  }

  editNotification(Notifications model) async {
    try {
      kDatabase.child('notifications').child(model.key).set(model.toJson());
      var notification =
          _notifications.firstWhere((element) => element.key == model.key);
      int temp = _notifications.indexOf(notification);
      _notifications[temp] = model;
      notifyListeners();
    } catch (e) {
      print(e);
      print("Error adding notifcation");
    }
  }

  addFaqs(Faqs model) async {
    try {
      kDatabase.child('faqs').update({model.question: model.answer});
      getFaqs();
      notifyListeners();
    } catch (e) {
      print("Error adding Faqs");
    }
  }

  deleteFaq(Faqs model) async {
    try {
      kDatabase.child('faqs').child(model.question).remove();
      _faqs.remove(model);
      notifyListeners();
    } catch (e) {
      print("Error adding Faqs");
    }
  }

  deleteNotification(Notifications model) async {
    try {
      kDatabase.child('notifications').child(model.key).remove();
      _notifications.remove(model);
      notifyListeners();
    } catch (e) {
      print("Error removing notifcation");
    }
  }

  getterms_and_condition() async {
    var snapshot = await kDatabase.child('terms_and_conditions').once();
    if (snapshot.value != null) {
      _terms_and_condition = (snapshot.value["text"]).toString();

      _termsconditionlink = (snapshot.value["pdf_url"]).toString();

      _privacylink = (snapshot.value["privacy_url"]).toString();
    } else {
      return null;
    }
  }

  getBrandNames() async {
    var snapshot = await kDatabase.child('watchbrands').once();
    if (snapshot.value != null) {
      List<dynamic> brands = snapshot.value;
      for (int i = 0; i < brands.length; i++) {
        if (brands[i] != null) {
          _brandnames.add(brands[i].toString().toUpperCase());
          notifyListeners();
        }
      }
    } else {
      return null;
    }
  }

  addBrandNames(String brandname) async {
    try {
      kDatabase
          .child('watchbrands')
          .update({(_brandnames.length + 1).toString(): brandname});
      _brandnames.add(brandname.toUpperCase());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addBrandModel(String brandname, String modelnumber) async {
    try {
      watch_model_Model watch = watch_model_Model();
      watch.watch_model = modelnumber;
      watch.watch_brand = brandname.toUpperCase();
      watch.watch_model_description = "Oyster, 41 mm, Oystersteel";

      String key = DateTime.now().millisecondsSinceEpoch.toString();
      kDatabase
          .child('watchmodels')
          .child(brandname)
          .child(key)
          .set(watch.toJson());
      _brandmodel.add(watch);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getBrandModels() async {
    var snapshot = await kDatabase.child('watchmodels').once();
    if (snapshot.value != null) {
      var map = snapshot.value;

      map.forEach((key, value) {
        watch_model_Model temp = watch_model_Model();
        value.forEach((key1, value1) {
          temp = watch_model_Model.fromJson(value1);
          temp.watch_brand = key.toString().toUpperCase();
          _brandmodel.add(temp);
          notifyListeners();
        });
      });
    } else {
      return null;
    }
  }

  getslidersfromdatabase() async {
    _sliders.clear();
    var snapshot = await kDatabase.child('sliders').once();
    if (snapshot.value != null) {

      var map=snapshot.value;

      map.forEach((key, value) {

        _sliders.add(Slider.fromJson(value));


      });
    } else {
      return null;
    }


  }

  getqueries(List<UserModel> users) async {
    _queries.clear();
    var snapshot = await kDatabase.child('queries').once();
    if (snapshot.value != null) {
      snapshot.value.forEach((key, value) {
        q.Query que = q.Query.fromJson(value);
        que.key = key;
        que.usermodel =
            users[users.indexWhere((element) => element.userId == que.userid)];
        _queries.add(que);
        notifyListeners();
      });
    } else {
      return null;
    }
  }

  addSlider(Slider s) {
    try {
        String key=DateTime.now().millisecondsSinceEpoch.toString();
        s.key=key;
        kDatabase.child('sliders').child(key).set(s.toJson());

      _sliders.add(s);
//      getslidersfromdatabase();
      notifyListeners();
    } catch (e) {
      print(e);
      print("Error adding slider in database");
    }
  }

  updateSlider(Slider s) {
    try {
      kDatabase.child('sliders').child(s.key).set(s.toJson());
      getslidersfromdatabase();
    } catch (e) {
      print("Error adding slider in database");
    }
  }

  deleteSlider(Slider slider) {
    try {
      kDatabase.child('sliders').child(slider.key).remove();
      _sliders.remove(slider);
      //getslidersfromdatabase();
      notifyListeners();
    } catch (e) {
      print("Error adding slider in database");
    }
  }

  deleteQuery(q.Query que) {
    try {
      kDatabase.child('queries').child(que.key).remove();
      _queries.remove(que);
      notifyListeners();
    } catch (e) {
      print("Error adding slider in database");
    }
  }

  Future<String> uploadFile(File file) async {
    try {
      notifyListeners();
      var storageReference = FirebaseStorage.instance
          .ref()
          .child("sliders")
          .child(Path.basename(file.path));
      await storageReference.putFile(file);

      var url = await storageReference.getDownloadURL();
      if (url != null) {
        return url;
      }
      return null;
    } catch (error) {
      cprint(error, errorIn: 'uploadFile');
      return null;
    }
  }
}

class Slider {
  String slider_url;
  String link_url;
  String key;

  Slider();
  Slider.fromJson(Map<dynamic, dynamic> map) {
    slider_url=map["slider_url"].toString();
    link_url=map["link_url"]==null?"":map["link_url"].toString();
    key=map["key"]==null?"":map["key"];

  }
  Map<String, dynamic> toJson() => {
    "slider_url":slider_url,
    "link_url":link_url,
    "key":key
  };
}

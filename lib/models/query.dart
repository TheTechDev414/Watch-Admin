
import 'package:watch_admin/models/user.dart';

class Query {
  String key;
 String comment;
  String createdAt;
  String email;
  String userid;
  UserModel usermodel;

  Query(
      {this.key,
      this.email,
        this.userid,
        this.comment,
        this.createdAt
      });

  Query.fromJson(Map<dynamic, dynamic> map) {

    userid = (map['userId']);
    email=map["email"];
    createdAt=map["createdAt"]==null?"":map["createdAt"];
    comment=map["comment"];

  }

}

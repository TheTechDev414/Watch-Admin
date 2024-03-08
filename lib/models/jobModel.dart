
import 'package:watch_admin/models/user.dart';
class jobModel {
  String key;
  String amount;
  //List<String> appliedjobUids;
  String companyName;
  String deadlineDate;
  String experience;
  List<String> images;
  String jobDescription;
  String jobTitle;
  double lat;
  double long;
  String requirements;
  String selectedUserUid;
  String status;
  String uploadedDate;
  String uploadedUserUid;
  jobModel(
      {this.key,
        this.companyName,
        this.images,
        this.jobDescription,
        this.selectedUserUid,
        this.lat,
        this.uploadedUserUid,
        this.status,
        this.amount,
        this.long,
        this.experience,
        this.deadlineDate,
        this.uploadedDate,
        this.jobTitle,
        this.requirements
      });
  toJson() {
    return {
      "amount": amount,
      "companyName":companyName,
      "deadlineDate":deadlineDate,
      "experience":experience,
      "images":images,
      "jobDescription":jobDescription,
      "jobTitle":jobTitle,
      "lat":lat,
      "long":long,
      "requiremens":requirements,
      "selectedUserUid":selectedUserUid,
      "status":status,
      "uploadedDate":uploadedDate,
      "uploadedUserUid":uploadedUserUid
    //  "appliedjobUids":appliedjobUids
    };
  }

  jobModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    uploadedUserUid=map["uploadedUserUid"];
    uploadedDate=map["uploadedDate"];
    status=map["status"];
    companyName=map["companyName"];
    deadlineDate=map["deadlineDate"];
    experience=map["experience"];
    if(map["images"]!=null){
      images=List<String>();
      map["images"].forEach((value) {

        images.add(value);
      });
    }
    jobDescription=map["jobDescription"];
    jobTitle=map["jobTitle"];
    lat=map["lat"];
    long=map["long"];
    requirements=map["requirements"];
    selectedUserUid=map["selectedUserUid"];
    status=map["status"];
  }

}

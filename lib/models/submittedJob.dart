class SubmittedJob {
  String key;
  String jobNo;

  String title;
  String companyName;
  String submittedDate;
  List<String> images=List<String>();

  List<String> reciepts=List<String>();
  String signoffUid;
  SubmittedJob({
    this.title,
    this.companyName,
    this.jobNo,
    this.key,
    this.submittedDate,
    this.signoffUid
  });

  SubmittedJob.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    jobNo=map["jobNo"];
    submittedDate=map["submittedDate"];
    signoffUid=map["signoffUId"];
    key=map["key"];
    title = map['title'];
    companyName = map['companyName'];

    if (map['images'] != null) {
      images = List<String>();
      map['images'].forEach((value) {
        images.add(value);
      });
    }
    if (map['reciptimages'] != null) {
      reciepts = List<String>();
      map['reciptimages'].forEach((value) {
        reciepts.add(value);
      });
    }
  //  image = map['image'];
  }
  toJson(){

    return{

      "jobNo":jobNo,
      "title":title,
      "companyName":companyName,
      "signoffUid":signoffUid,
      "submittedDate":submittedDate,
      "images":images,
      "reciepts":reciepts

    };
  }
}

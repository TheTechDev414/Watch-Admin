
part 'signoffSheetModel.g.dart';

@JsonSerializable()


class SignoffSheetModel {

    String key;
    String senderId;
    String companyName;
    String companyLogo;
    String jobNo;
    String accountNo="";
    String siteName;
    String siteAddress;
    String postalCode;
    String telephoneNo;
    String siteContact;
    bool serviceCall=false;
    bool installation=false;
    bool delivery=false;
    bool survery=false;
    String comments;
    bool systemDemonstration=false;
    bool musicPlaying=false;
    bool visualScreen=false;
    bool volumeControls=false;
    bool additionalWork=false;
    bool cloudcastingOfficeConfirmation=false;
    List<String> description;
    List<String> serialNo;
    String engineerName;
    String date;
    String timeOfArrival;
    String departureTime;
    String signature;
    String createdAt;

    SignoffSheetModel({
      this.key,
      this.senderId,
      this.jobNo,
      this.accountNo,
      this.siteName,
      this.siteAddress,
      this.postalCode,
      this.telephoneNo,
      this.siteContact,
      this.serviceCall,
      this.installation,
      this.delivery,
      this.survery,
      this.comments,
      this.systemDemonstration,
      this.musicPlaying,
      this.visualScreen,
      this.volumeControls,
      this.additionalWork,
      this.cloudcastingOfficeConfirmation,
      this.description,
      this.serialNo,
      this.engineerName,
      this.date,
      this.timeOfArrival,
      this.departureTime,
      this.createdAt,
      this.companyName,
      this.companyLogo,
      this.signature});

    factory SignoffSheetModel.fromJson(Map<dynamic,dynamic> data) => _$SignoffSheetModelFromJson(data);

    Map<String,dynamic> toJson() => _$SignoffSheetModelToJson(this);
    // factory SignoffSheetModel.fromJson(Map<dynamic, dynamic> json) => SignoffSheetModel(
    //     key: json["key"],
    //     senderId: json["sender_id"],
    // );
    //
    // Map<String, dynamic> toJson() => {
    //     "key": key,
    //     "sender_id": senderId,
    // };
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signoffSheetModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignoffSheetModel _$SignoffSheetModelFromJson(Map<dynamic, dynamic> json) {
 List<String> serialNoList,descriptionNoList;
  if (json['serialNo'] != null) {
    serialNoList = List<String>();
    json['serialNo'].forEach((value) {
      serialNoList.add(value);
    });
  }
 if (json['description'] != null) {
   descriptionNoList = List<String>();
   json['description'].forEach((value) {
     descriptionNoList.add(value);
   });
 }
  return SignoffSheetModel(
   key:  json['key'] as String,
  senderId:  json['senderId'] as String,
    jobNo:  json['jobNo'] as String,
    accountNo: json['accountNo'] as String,
    siteName: json['siteName'] as String,
    siteAddress: json['siteAddress'] as String,
    postalCode: json['postalCode'] as String,
    telephoneNo: json['telephoneNo'] as String,
    siteContact: json['siteContact'] as String,
    serviceCall: json['serviceCall'] as bool,
    installation: json['installation'] as bool,
    delivery: json['delivery'] as bool,
    survery: json['survery'] as bool,
    comments: json['comments'] as String,
    systemDemonstration: json['systemDemonstration'] as bool,
    musicPlaying: json['musicPlaying'] as bool,
    visualScreen: json['visualScreen'] as bool,
    volumeControls: json['volumeControls'] as bool,
    additionalWork: json['additionalWork'] as bool,
    cloudcastingOfficeConfirmation: json['cloudcastingOfficeConfirmation'] as bool,

    description: descriptionNoList,
    serialNo:serialNoList,
    engineerName: json['engineerName'] as String,
    date: json['date'] as String,
    createdAt: json["createdAt"] as String,
    timeOfArrival: json['timeOfArrival'] as String,
    departureTime: json['departureTime'] as String,
    signature:   json['signature'] as String,
    companyName: json['companyName'] as String,

    companyLogo: json['companyLogo'] as String,
  );
}

Map<String, dynamic> _$SignoffSheetModelToJson(SignoffSheetModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'senderId': instance.senderId,
      'jobNo': instance.jobNo,
      'accountNo': instance.accountNo,
      'siteName': instance.siteName,
      'siteAddress': instance.siteAddress,
      'postalCode': instance.postalCode,
      'telephoneNo': instance.telephoneNo,
      'siteContact': instance.siteContact,
      'serviceCall': instance.serviceCall,
      'installation': instance.installation,
      'description':instance.description,
      'delivery': instance.delivery,
      'survery': instance.survery,
      'comments': instance.comments,
      'systemDemonstration': instance.systemDemonstration,
      'musicPlaying': instance.musicPlaying,
      'visualScreen': instance.visualScreen,
      'volumeControls': instance.volumeControls,
      'additionalWork': instance.additionalWork,
      'cloudcastingOfficeConfirmation': instance.cloudcastingOfficeConfirmation,
      'description': instance.description,
      'serialNo': instance.serialNo,
      'engineerName': instance.engineerName,
      'date': instance.date,
      'timeOfArrival': instance.timeOfArrival,
      'departureTime': instance.departureTime,
      'signature': instance.signature,
      'companyName':instance.companyName,
      'companyLogo':instance.companyLogo,
      'createdAt':DateTime.now().toString()
    };

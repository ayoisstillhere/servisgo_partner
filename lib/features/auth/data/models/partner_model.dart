import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/partner_entity.dart';

class PartnerModel extends PartnerEntity {
  const PartnerModel({
    required String partnerId,
    required String partnerName,
    required String partnerEmail,
    required String partnerPhone,
    required String status,
    required String serviceClass,
    required String partnerPfpURL,
  }) : super(
          partnerId,
          partnerName,
          partnerEmail,
          partnerPhone,
          status,
          serviceClass,
          partnerPfpURL,
        );

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      partnerId: json['partnerId'],
      partnerName: json['partnerName'],
      partnerEmail: json['partnerEmail'],
      partnerPhone: json['partnerPhone'],
      status: json['status'],
      serviceClass: json['serviceClass'],
      partnerPfpURL: json['partnerPfpURL'],
    );
  }

  factory PartnerModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return PartnerModel(
      partnerId: (documentSnapshot.data()! as dynamic)['partnerId'],
      partnerName: (documentSnapshot.data()! as dynamic)['partnerName'],
      partnerEmail: (documentSnapshot.data()! as dynamic)['partnerEmail'],
      partnerPhone: (documentSnapshot.data()! as dynamic)['partnerPhone'],
      status: (documentSnapshot.data()! as dynamic)['status'],
      serviceClass: (documentSnapshot.data()! as dynamic)['serviceClass'],
      partnerPfpURL: (documentSnapshot.data()! as dynamic)['partnerPfpURL'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "partnerId": partnerId,
      "partnerName": partnerName,
      "partnerEmail": partnerEmail,
      "partnerPhone": partnerPhone,
      "status": status,
      "serviceClass": serviceClass,
      "partnerPfpURL": partnerPfpURL,
    };
  }
}

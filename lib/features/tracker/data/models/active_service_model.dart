import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servisgo_partner/features/tracker/domain/entities/active_service_entity.dart';

class ActiveServiceModel extends ActiveServiceEntity {
  const ActiveServiceModel({
    required String id,
    required String customerId,
    required String partnerId,
    required String serviceClass,
    required String serviceStatus,
    required String scheduledDate,
    required String scheduledTime,
    required String servicePrice,
    required String serviceRating,
    required String additionalDetails,
    required String customerAddress,
    required double? latitudeCustomer,
    required double? longitudeCustomer,
    required double? latitudePartner,
    required double? longitudePartner,
  }) : super(
          id,
          customerId,
          partnerId,
          serviceClass,
          serviceStatus,
          scheduledDate,
          scheduledTime,
          servicePrice,
          serviceRating,
          additionalDetails,
          customerAddress,
          latitudeCustomer,
          longitudeCustomer,
          latitudePartner,
          longitudePartner,
        );

  factory ActiveServiceModel.fromJson(Map<String, dynamic> json) {
    return ActiveServiceModel(
      id: json['id'],
      customerId: json['customerId'],
      partnerId: json['partnerId'],
      serviceClass: json['serviceClass'],
      serviceStatus: json['serviceStatus'],
      scheduledDate: json['scheduledDate'],
      scheduledTime: json['scheduledTime'],
      servicePrice: json['servicePrice'],
      serviceRating: json['serviceRating'],
      additionalDetails: json['additionalDetails'],
      customerAddress: json['customerAddress'],
      latitudeCustomer: json['latitudeCustomer'],
      longitudeCustomer: json['longitudeCustomer'],
      latitudePartner: json['latitudePartner'],
      longitudePartner: json['longitudePartner'],
    );
  }

  factory ActiveServiceModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ActiveServiceModel(
      id: (documentSnapshot.data()! as dynamic)['id'],
      customerId: (documentSnapshot.data()! as dynamic)['customerId'],
      partnerId: (documentSnapshot.data()! as dynamic)['partnerId'],
      serviceClass: (documentSnapshot.data()! as dynamic)['serviceClass'],
      serviceStatus: (documentSnapshot.data()! as dynamic)['serviceStatus'],
      scheduledDate: (documentSnapshot.data()! as dynamic)['scheduledDate'],
      scheduledTime: (documentSnapshot.data()! as dynamic)['scheduledTime'],
      servicePrice: (documentSnapshot.data()! as dynamic)['servicePrice'],
      serviceRating: (documentSnapshot.data()! as dynamic)['serviceRating'],
      additionalDetails:
          (documentSnapshot.data()! as dynamic)['additionalDetails'],
      customerAddress: (documentSnapshot.data()! as dynamic)['customerAddress'],
      latitudeCustomer:
          (documentSnapshot.data()! as dynamic)['latitudeCustomer'],
      longitudeCustomer:
          (documentSnapshot.data()! as dynamic)['longitudeCustomer'],
      latitudePartner: (documentSnapshot.data()! as dynamic)['latitudePartner'],
      longitudePartner:
          (documentSnapshot.data()! as dynamic)['longitudePartner'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "id": id,
      "customerId": customerId,
      "partnerId": partnerId,
      "serviceClass": serviceClass,
      "serviceStatus": serviceStatus,
      "scheduledDate": scheduledDate,
      "scheduledTime": scheduledTime,
      "servicePrice": servicePrice,
      "serviceRating": serviceRating,
      "additionalDetails": additionalDetails,
      "customerAddress": customerAddress,
      "latitudeCustomer": latitudeCustomer,
      "longitudeCustomer": longitudeCustomer,
      "latitudePartner": latitudePartner,
      "longitudePartner": longitudePartner,
    };
  }
}

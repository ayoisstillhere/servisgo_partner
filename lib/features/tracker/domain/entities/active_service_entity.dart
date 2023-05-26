import 'package:equatable/equatable.dart';

class ActiveServiceEntity extends Equatable {
  final String id;
  final String customerId;
  final String partnerId;
  final String serviceClass;
  final String serviceStatus;
  final String scheduledDate;
  final String scheduledTime;
  final String servicePrice;
  final String serviceRating;
  final String additionalDetails;
  final String customerAddress;
  final double? latitudeCustomer;
  final double? longitudeCustomer;
  final double? latitudePartner;
  final double? longitudePartner;

  const ActiveServiceEntity(
    this.id,
    this.customerId,
    this.partnerId,
    this.serviceClass,
    this.serviceStatus,
    this.scheduledDate,
    this.scheduledTime,
    this.servicePrice,
    this.serviceRating,
    this.additionalDetails,
    this.customerAddress,
    this.latitudeCustomer,
    this.longitudeCustomer,
    this.latitudePartner,
    this.longitudePartner,
  );
  @override
  List<Object?> get props => [
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
      ];
}

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/accept_job_request_usecase.dart';

import '../../../domain/entities/accepted_service_entity.dart';
import '../../../domain/usecases/get_accepted_requests_usecase.dart';

part 'accepted_service_state.dart';

class AcceptedServiceCubit extends Cubit<AcceptedServiceState> {
  final AcceptJobRequestUsecase acceptJobRequestUsecase;
  final GetAcceptedRequestsUsecase getAcceptedRequestsUsecase;
  AcceptedServiceCubit({
    required this.acceptJobRequestUsecase,
    required this.getAcceptedRequestsUsecase,
  }) : super(AcceptedServiceInitial());

  Future<void> acceptJobRequest({
    required String customerId,
    required String serviceClass,
    required String serviceStatus,
    required String scheduledDate,
    required String scheduledTime,
    required String servicePrice,
    required double serviceRating,
    required String additionalDetails,
    required String customerAddress,
    required double? latitudeCustomer,
    required double? longitudeCustomer,
    required double? latitudePartner,
    required double? longitudePartner,
    required String jobRequestId,
  }) async {
    emit(AcceptedServiceLoading());
    try {
      await acceptJobRequestUsecase.call(
        customerId,
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
        jobRequestId,
      );
      emit(AcceptedServiceSuccess());
    } on SocketException catch (e) {
      emit(AcceptedServiceFailure(e.message));
    } catch (_) {
      emit(const AcceptedServiceFailure("Unable to Accept Job Request"));
    }
  }

  Future<void> getAcceptedRequests() async {
    try {
      final acceptedRequest = getAcceptedRequestsUsecase.call();
      acceptedRequest.listen((acceptedRequests) {
        emit(AcceptedServiceLoaded(acceptedRequests: acceptedRequests));
      });
    } on SocketException catch (_) {}
  }
}

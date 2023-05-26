import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:servisgo_partner/features/home/domain/entities/job_request_entity.dart';
import 'package:servisgo_partner/features/home/domain/usecases/get_job_requests.dart';

part 'job_requests_state.dart';

class JobRequestsCubit extends Cubit<JobRequestsState> {
  final GetJobRequestsUsecase getJobRequestsUsecase;
  JobRequestsCubit({
    required this.getJobRequestsUsecase,
  }) : super(JobRequestsInitial());

  Future<void> getJobRequests() async {
    try {
      final jobRequest = getJobRequestsUsecase.call();
      jobRequest.listen((jobRequests) {
        emit(JobRequestsLoaded(jobRequests: jobRequests));
      });
    } on SocketException catch (_) {}
  }
}

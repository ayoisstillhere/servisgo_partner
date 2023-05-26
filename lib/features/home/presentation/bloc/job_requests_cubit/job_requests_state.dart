part of 'job_requests_cubit.dart';

abstract class JobRequestsState extends Equatable {
  const JobRequestsState();
}

class JobRequestsInitial extends JobRequestsState {
  @override
  List<Object> get props => [];
}

class JobRequestsLoaded extends JobRequestsState {
  final List<JobRequestEntity> jobRequests;
  const JobRequestsLoaded({
    required this.jobRequests,
  });
  @override
  List<Object?> get props => [jobRequests];
}

class JobRequestsLoading extends JobRequestsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

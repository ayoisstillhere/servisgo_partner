import 'package:servisgo_partner/features/auth/domain/repositories/firebase_repository.dart';
import 'package:servisgo_partner/features/home/domain/entities/job_request_entity.dart';

class GetJobRequestsUsecase {
  final FirebaseRepository repository;
  GetJobRequestsUsecase({
    required this.repository,
  });

  Stream<List<JobRequestEntity>> call() => repository.getJobRequests();
}

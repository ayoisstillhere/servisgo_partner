import '../../../auth/domain/repositories/firebase_repository.dart';
import '../entities/job_request_entity.dart';

class GetJobRequestsUsecase {
  final FirebaseRepository repository;
  GetJobRequestsUsecase({
    required this.repository,
  });

  Stream<List<JobRequestEntity>> call() => repository.getJobRequests();
}

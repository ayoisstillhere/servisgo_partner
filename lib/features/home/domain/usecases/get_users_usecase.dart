import '../../../auth/domain/repositories/firebase_repository.dart';
import '../entities/user_entity.dart';

class GetUsersUsecase {
  final FirebaseRepository repository;
  GetUsersUsecase({
    required this.repository,
  });

  Stream<List<UserEntity>> call() => repository.getUsers();
}

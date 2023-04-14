import '../repositories/firebase_repository.dart';

class SetServiceClassUsecase {
  final FirebaseRepository repository;
  SetServiceClassUsecase({
    required this.repository,
  });

  Future<void> call(String serviceClass) async {
    repository.setServiceClass(serviceClass);
  }
}

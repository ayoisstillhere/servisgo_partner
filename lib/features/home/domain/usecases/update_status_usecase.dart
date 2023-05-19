import 'package:servisgo_partner/features/auth/domain/repositories/firebase_repository.dart';

class UpdateStatusUsecase {
  final FirebaseRepository repository;
  UpdateStatusUsecase({
    required this.repository,
  });

  Future<void> call(String status) async => await repository.updateStatus(status);
  
}

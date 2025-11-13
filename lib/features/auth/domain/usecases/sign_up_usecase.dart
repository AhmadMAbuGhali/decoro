import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';


class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await repository.signUp(name: name, email: email, password: password);
  }
}
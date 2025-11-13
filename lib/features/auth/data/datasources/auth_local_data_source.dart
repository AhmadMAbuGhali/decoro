
import '../../../../core/services/storage/local_storage_service.dart';

class AuthLocalDataSource {
  final LocalStorageService storage;
  AuthLocalDataSource(this.storage);

  Future<void> cacheToken(String token) => storage.setString('token', token);
  Future<String?> getToken() => storage.getString('token');
}
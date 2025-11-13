import '../../../../core/services/network/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient client;
  AuthRemoteDataSource(this.client);

  Future<Map<String, dynamic>> login(String email, String password) async {
    // placeholder
    final r = await client.post('/auth', {'email': email, 'password': password});
    return r.data;
  }
}
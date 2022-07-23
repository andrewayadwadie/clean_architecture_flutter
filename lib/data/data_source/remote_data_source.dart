import '../network/app_api.dart';
import '../network/requestd.dart';
import '../responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataDourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataDourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }
}

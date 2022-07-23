import '../network/error_handler.dart';

import '../data_source/remote_data_source.dart';
import '../mapper/mapper.dart';
import '../network/network_info.dart';
import 'package:dartz/dartz.dart';

import '../../domain/models/models.dart';
import '../../domain/repositry/repositry.dart';
import '../network/failure.dart';
import '../network/requestd.dart';

class RepositryImpl implements Repositry {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      //! it's connected to internet i's safe to call Api
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //!success
          //?return Either Right
          //? return Data
          return Right(response.toDomain());
        } else {
          //! failure -- business Error
          //? return Either Left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //! return Internet Connection Error
      //? return Either Left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}

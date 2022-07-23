import '../../data/network/requestd.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/models.dart';

abstract class Repositry {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}

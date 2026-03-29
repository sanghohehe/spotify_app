import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:taxi_app/core/configs/usecase/usecase.dart';
import 'package:taxi_app/domain/repository/auth/auth.dart';
import 'package:taxi_app/service_locator.dart';

class GetUserUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({ params}) async {
    return sl<AuthRepository>().getUser();
  }
}

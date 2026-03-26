import 'package:get_it/get_it.dart';
import 'package:taxi_app/data/repository/auth/auth_repository_impl.dart';
import 'package:taxi_app/data/sources/auth/auth_firebase_service.dart';
import 'package:taxi_app/domain/repository/auth/auth.dart';

final sl = GetIt.instance;

Future<void> inittilizeDependecies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}

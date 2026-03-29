import 'package:get_it/get_it.dart';
import 'package:taxi_app/data/repository/auth/auth_repository_impl.dart';
import 'package:taxi_app/data/repository/song/song_repository_impl.dart';
import 'package:taxi_app/data/sources/auth/auth_firebase_service.dart';
import 'package:taxi_app/data/sources/song/song_firebase_service.dart';
import 'package:taxi_app/domain/repository/auth/auth.dart';
import 'package:taxi_app/domain/repository/song/song.dart';
import 'package:taxi_app/domain/usecases/auth/get_user.dart';
import 'package:taxi_app/domain/usecases/auth/signin.dart';
import 'package:taxi_app/domain/usecases/auth/signup.dart';
import 'package:taxi_app/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:taxi_app/domain/usecases/song/get_favorite_songs.dart';
import 'package:taxi_app/domain/usecases/song/get_new_song.dart';
import 'package:taxi_app/domain/usecases/song/get_play_list.dart';
import 'package:taxi_app/domain/usecases/song/is_favorite_song.dart';

final sl = GetIt.instance;

Future<void> inittilizeDependecies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<SongRepository>(SongRepositoryImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
  sl.registerSingleton<GetNewSongUsecase>(GetNewSongUsecase());
  sl.registerSingleton<GetPlayListUsecase>(GetPlayListUsecase());
  sl.registerSingleton<AddOrRemoveFavoriteSongUsecase>(
    AddOrRemoveFavoriteSongUsecase(),
  );
  sl.registerSingleton<IsFavoriteSongUsecase>(IsFavoriteSongUsecase());
  sl.registerSingleton<GetUserUsecase>(GetUserUsecase());
  sl.registerSingleton<GetFavoriteSongsUsecase>(GetFavoriteSongsUsecase());
}

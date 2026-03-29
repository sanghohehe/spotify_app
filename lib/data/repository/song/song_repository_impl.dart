import 'package:dartz/dartz.dart';
import 'package:taxi_app/data/sources/song/song_firebase_service.dart';
import 'package:taxi_app/domain/repository/song/song.dart';
import 'package:taxi_app/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewSongs() async {
    return await sl<SongFirebaseService>().getNewSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    final result = await sl<SongFirebaseService>().isFavoriteSongs(songId);
    return result.fold((left) => false, (right) => right);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/data/model/song/song.dart';
import 'package:taxi_app/domain/entities/song/song.dart';
import 'package:taxi_app/domain/usecases/song/is_favorite_song.dart';
import 'package:taxi_app/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<Either> isFavoriteSongs(String songId);
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      var data =
          await FirebaseFirestore.instance
              .collection('Songs')
              .orderBy('releaseDate', descending: true)
              .limit(3)
              .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUsecase>().call(
          params: element.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left('An error occurred, Please try agian.');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data =
          await FirebaseFirestore.instance
              .collection('Songs')
              .orderBy('releaseDate', descending: true)
              .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUsecase>().call(
          params: element.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left('An error occurred, Please try agian.');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorite;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSongs =
          await firebaseFirestore
              .collection('Users')
              .doc(uId)
              .collection('Favorites')
              .where('songId', isEqualTo: songId)
              .get();

      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return Left('An Erorr occurred');
    }
  }

  @override
  Future<Either> isFavoriteSongs(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSongs =
          await firebaseFirestore
              .collection('Users')
              .doc(uId)
              .collection('Favorites')
              .where('songId', isEqualTo: songId)
              .get();

      if (favoriteSongs.docs.isNotEmpty) {
        return Right(true);
      } else {
        return Right(false);
      }
    } catch (e) {
      return Left('An error occurred');
    }
  }
}

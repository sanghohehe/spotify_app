import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taxi_app/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  double? duration;
  Timestamp? releaseDate;
  String? image;
  String? audio;
  bool? isFavorite;
  String? songId;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.image,
    required this.audio,
    required this.isFavorite,
    required this.songId,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
    image = data['image'];
    audio = data['audio'];
    isFavorite = data['isFavorite'];
    songId = data['songId'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseDate: releaseDate!,
      image: image!,
      audio: audio!,
      isFavorite: isFavorite!,
      songId: songId!,
    );
  }
}

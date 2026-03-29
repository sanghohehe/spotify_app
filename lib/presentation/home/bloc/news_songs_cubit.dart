import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/domain/usecases/song/get_new_song.dart';
import 'package:taxi_app/presentation/home/bloc/news_songs_state.dart';
import 'package:taxi_app/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewSongUsecase>().call();
    returnedSongs.fold(
      (l) {
        emit(NewSongsLoadFailure());
      },
      (data) {
        emit(NewSongsLoaded(songs: data));
      },
    );
  }
}

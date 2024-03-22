import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:music_player_app/models/song.dart';

class SpotifyService {
  final Dio dio;
  final String clientId = '383a2eb9c6b647c2bdd9bae8468da60b';
  final String clientSecret = '411257d836904c5d8a1c2dca251a0e0b';

  SpotifyService(this.dio);

  Future<String> _getAccessToken() async {
    final String credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));
    final response = await dio.post(
      'https://accounts.spotify.com/api/token',
      data: 'grant_type=client_credentials',
      options: Options(headers: {'Authorization': 'Basic $credentials', 'Content-Type': 'application/x-www-form-urlencoded'}),
    );
    return response.data['access_token'];
  }

  Future<List<Song>> getRecommendations() async {
    String accessToken = await _getAccessToken();

    var response = await dio.get(
      'https://api.spotify.com/v1/recommendations',
      queryParameters: {
        'seed_genres': genres,
        'limit': 100,
      },
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    List<Song> recommendations = [];

    for(var track in response.data['tracks']){
      final previewUrl = track['preview_url'];
      if(previewUrl != null) {
        recommendations.add(
          Song(
              name: track['name'],
              songUrl: track['preview_url'],
              imageUrl: track['album']['images'][0]['url'],
              duration: track['duration_ms'],
              artist: track['artists'][0]['name'] ?? '-'
          )
        );
      }
    }

    return recommendations;
  }

  Future<List<Song>> searchMusic(String query) async {
    String accessToken = await _getAccessToken();
    var response = await dio.get(
      'https://api.spotify.com/v1/search',
      queryParameters: {'q': query, 'type': 'track'},
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    List<Song> recommendations = [];

    if(response.data['tracks'] == null) return recommendations;

    Map<String,dynamic> tracksMap = response.data['tracks'];
    List<dynamic> tracks = tracksMap['items'];


    for(var track in tracks){
      final previewUrl = track['preview_url'];
      if(previewUrl != null) {
        recommendations.add(
            Song(
                name: track['name'],
                songUrl: track['preview_url'],
                imageUrl: track['album']['images'][0]['url'],
                duration: track['duration_ms'],
                artist: track['artists'][0]['name'] ?? '-'
            )
        );
      }
    }

    return recommendations;


  }

  Future<List<dynamic>> getMusicForCategory(String category) async {
    String accessToken = await _getAccessToken();
    var response = await dio.get(
      'https://api.spotify.com/v1/browse/categories/$category/playlists',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    return response.data['playlists']['items'];
  }
}

List<String> genres = [
  'acoustic',
  'afrobeat',
  'alt-rock',
  'alternative',
  'ambient',
  'anime',
  'black-metal',
  'bluegrass',
  'blues',
  'bossanova',
  'brazil',
  'breakbeat',
  'british',
  'cantopop',
  'chicago-house',
  'children',
  'chill',
  'classical',
  'club',
  'comedy',
  'country',
  'dance',
  'dancehall',
  'death-metal',
  'deep-house',
  'detroit-techno',
  'disco',
  'disney',
  'drum-and-bass',
  'dub',
  'dubstep',
  'edm',
  'electro',
  'electronic',
  'emo',
  'folk',
  'forro',
  'french',
  'funk',
  'garage',
  'german',
  'gospel',
  'goth',
  'grindcore',
  'groove',
  'grunge',
  'guitar',
  'happy',
  'hard-rock',
  'hardcore',
  'hardstyle',
  'heavy-metal',
  'hip-hop',
  'holidays',
  'honky-tonk',
  'house',
  'idm',
  'indian',
  'indie',
  'indie-pop',
  'industrial',
  'iranian',
  'j-dance',
  'j-idol',
  'j-pop',
  'j-rock',
  'jazz',
  'k-pop',
  'kids',
  'latin',
  'latino',
  'malay',
  'mandopop',
  'metal',
  'metal-misc',
  'metalcore',
  'minimal-techno',
  'movies',
  'mpb',
  'new-age',
  'new-release',
  'opera',
  'pagode',
  'party',
  'philippines-opm',
  'piano',
  'pop',
  'pop-film',
  'post-dubstep',
  'power-pop',
  'progressive-house',
  'psych-rock',
  'punk',
  'punk-rock',
  'r-n-b',
  'rainy-day',
  'reggae',
  'reggaeton',
  'road-trip',
  'rock',
  'rock-n-roll',
  'rockabilly',
  'romance',
  'sad',
  'salsa',
  'samba',
  'sertanejo',
  'show-tunes',
  'singer-songwriter',
  'ska',
  'sleep',
  'songwriter',
  'soul',
  'soundtracks',
  'spanish',
  'study',
  'summer',
  'swedish',
  'synth-pop',
  'tango',
  'techno',
  'trance',
  'trip-hop',
  'turkish',
  'work-out',
  'world-music'
];

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/screens/home_screen.dart';
import 'package:music_player_app/screens/now_playing_screen.dart';
import 'package:music_player_app/screens/podcast_screen.dart';
import 'package:music_player_app/screens/personal_settings_screen.dart';
import 'package:music_player_app/screens/search_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      GetMaterialApp(
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/', page: () => const HomeScreen()),
          GetPage(name: '/now_playing', page: () => const NowPLayingScreen()),
          GetPage(name: '/search', page: () => const SearchScreen()),
          GetPage(name: '/personal_settings', page: () => const PersonalSettingsScreen()),
          GetPage(name: '/podcast', page: () => const PodcastScreen()),
        ],
      )
  );
}

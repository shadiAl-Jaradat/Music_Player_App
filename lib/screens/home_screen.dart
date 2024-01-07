import 'package:flutter/material.dart';
import 'package:music_player_app/screens/all_songs_screen.dart';
import 'package:music_player_app/screens/podcast_screen.dart';
import 'package:music_player_app/screens/personal_settings_screen.dart';
import 'package:music_player_app/screens/search_screen.dart';
import 'package:music_player_app/shared_widgets/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Widget _tabBody;

  final List<Widget> _screens = [
    const AllSongsScreen(),
    const SearchScreen(),
    const SearchScreen(),
    const PodcastScreen(),
    const PersonalSettingsScreen(),
  ];

  @override
  void initState() {
    _tabBody = _screens.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xFF222932),
        child: SafeArea(child: Center(child: _tabBody)),
      ),
      bottomNavigationBar: CustomTabBar(onTabChange:(tabIndex) {
        print(tabIndex);
        setState(() {
          _tabBody = _screens[tabIndex];
        });
      },),
    );
  }
}

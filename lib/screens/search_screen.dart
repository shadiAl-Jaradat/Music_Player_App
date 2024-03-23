import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player_app/core/controllers.dart';
import 'package:music_player_app/core/spotify_service.dart';
import 'package:music_player_app/models/song.dart';
import 'package:music_player_app/screens/home_screen.dart';
import 'package:music_player_app/shared_widgets/song_item_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onTap});

  final Function() onTap;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AudioPlayerController audioPLayerController = Get.find();
  final SpotifyService spotifyService = SpotifyService(Dio());
  bool isSearching = false;
  bool noResults = false;
  TextEditingController searchController = TextEditingController();

  void getSongs(String value) async {
    setState(() {
      isSearching = true;
    });
    List<Song> result = await spotifyService.searchMusic(value);
    audioPLayerController.setSearchedSongs(result);
    setState(() {
      if (result.isEmpty) {
        noResults = true;
      } else {
        noResults = false;
      }
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: (searchController.value.text.isEmpty || noResults || isSearching)
            ? (audioPLayerController.searchedSongs.length - audioPLayerController.searchedSongs.length + 2)
            : audioPLayerController.searchedSongs.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search your song',
                    style: GoogleFonts.poppins(
                      color: MyColors.tertiaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        audioPLayerController.setSearchedSongs([]);
                        audioPLayerController.stop();
                        audioPLayerController.setSong(null);
                        setState(() {
                          noResults = false;
                        });
                      } else {
                        if (!isSearching) {
                          getSongs(value.trim());
                        }
                      }
                    },
                    style: GoogleFonts.poppins(
                      color: MyColors.tertiaryColor,
                    ),
                    cursorColor: MyColors.tertiaryColor,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(
                        color: MyColors.tertiaryColor.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: MyColors.tertiaryColor,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.tertiaryColor,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.tertiaryColor.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.tertiaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (isSearching) {
            return Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
              child: Center(
                child: CircularProgressIndicator(
                  color: MyColors.tertiaryColor,
                ),
              ),
            );
          }

          if (noResults) {
            return Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/noRes.json',
                      height: 150,
                      width: 150,
                      repeat: true
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No songs found',
                      style: GoogleFonts.poppins(
                        color: MyColors.tertiaryColor.withOpacity(0.5),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          }

          if(searchController.value.text.isEmpty){
            return const SizedBox();
          }

          return SongItemCard(
              song: audioPLayerController.searchedSongs[index - 1],
              onTap: () {
                setState(() {
                  audioPLayerController.setInSearchMode(true);
                  if (audioPLayerController.song.value != null) {
                    if (audioPLayerController.song.value == audioPLayerController.searchedSongs[index - 1]) {
                      audioPLayerController.resume();
                    }
                  }
                  audioPLayerController.currentIndex = (index - 1).obs;
                  audioPLayerController.setSong(audioPLayerController.searchedSongs[index - 1]);
                  audioPLayerController.play();
                });
                widget.onTap();
              });
        },
      ),
    );
  }
}

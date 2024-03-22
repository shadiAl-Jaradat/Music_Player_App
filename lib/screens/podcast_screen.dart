import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Podcast Screen\nComing Soon",
        style: GoogleFonts.poppins(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

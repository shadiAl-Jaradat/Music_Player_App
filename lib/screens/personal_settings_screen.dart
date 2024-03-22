import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalSettingsScreen extends StatefulWidget {
  const PersonalSettingsScreen({super.key});

  @override
  State<PersonalSettingsScreen> createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Personal Screen\nComing Soon",
        style: GoogleFonts.poppins(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

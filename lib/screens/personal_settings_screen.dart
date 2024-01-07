import 'package:flutter/material.dart';

class PersonalSettingsScreen extends StatefulWidget {
  const PersonalSettingsScreen({super.key});

  @override
  State<PersonalSettingsScreen> createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("Personal Settings Screen ....", style: TextStyle(color: Colors.white),);
  }
}

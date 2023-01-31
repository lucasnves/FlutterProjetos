import 'package:flutter/material.dart';
import 'package:teste_mediaquery/responsive/desktop_body.dart';
import 'package:teste_mediaquery/responsive/mobile_body.dart';
import 'package:teste_mediaquery/responsive/responsive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: const MyMobileBody(),
        desktopBody: const MyDesktopBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
// IMPORT BARU INI WAJIB ADA:
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/view/main_tab/main_tab_view.dart';
// import 'package:trackizer/view/login/welcome_view.dart'; // Gunakan jika perlu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trackizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        colorScheme: ColorScheme.fromSeed(
          seedColor: TColor.primary,
          background: TColor.gray80,
          surface: TColor.gray80,
          primary: TColor.primary,
          secondary: TColor.secondary,
          primaryContainer: TColor.gray60,
        ),
        useMaterial3: false,
      ),

      // --- TAMBAHKAN BAGIAN INI AGAR KALENDER TIDAK MERAH ---
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'), // Bahasa Indonesia
        Locale('en', 'US'), // Bahasa Inggris (Default)
      ],
      // ------------------------------------------------------

      home: const MainTabView(),
    );
  }
}

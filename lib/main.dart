import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/view/login/welcome_view.dart';
import 'package:trackizer/view/main_tab/main_tab_view.dart'; // Pastikan path ini benar sesuai struktur folder Anda

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
        // PERBAIKAN: Gunakan .copyWith untuk override warna spesifik
        colorScheme: ColorScheme.fromSeed(
          seedColor: TColor.primary,
        ).copyWith(
          primary: TColor.primary,
          primaryContainer: TColor.gray60,
          secondary: TColor.secondary,
          surface: TColor.gray80, // Pengganti 'background' di Flutter terbaru
          background: TColor
              .gray80, // Tetap disertakan untuk kompatibilitas versi lama jika perlu
        ),
        useMaterial3: false,
      ),
      home: const MainTabView(),
    );
  }
}

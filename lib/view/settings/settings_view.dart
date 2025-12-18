import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/color_extension.dart';
import '../../common/theme_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Jam Realtime
  late String _timeString;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Jam Realtime
    _timeString = _formatDateTime(DateTime.now());
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    if (mounted) {
      setState(() {
        _timeString = _formatDateTime(now);
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, isDarkMode, child) {
        var backgroundColor = isDarkMode ? TColor.gray : Colors.white;
        var textColor = isDarkMode ? TColor.white : TColor.gray;
        var subTextColor = isDarkMode ? TColor.gray30 : TColor.gray50;
        var containerColor =
            isDarkMode ? TColor.gray60.withOpacity(0.2) : Colors.grey.shade100;
        var borderColor =
            isDarkMode ? TColor.border.withOpacity(0.1) : Colors.grey.shade300;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // --- HEADER ---
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Pengaturan",
                              style: TextStyle(
                                  color: subTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  // --- JAM REALTIME ---
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text(
                          "Waktu Saat Ini",
                          style: TextStyle(
                              color: subTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _timeString,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                      ],
                    ),
                  ),

                  // --- MENU LIST ---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- DATA & LAPORAN ---
                        Padding(
                          padding: const EdgeInsets.only(top: 0, bottom: 8),
                          child: Text(
                            "Data & Laporan",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            color: containerColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Fitur Export CSV akan segera hadir")));
                                },
                                child: _customRowImage("Export ke Excel/CSV",
                                    "assets/img/chart.png", "Unduh", textColor),
                              ),
                              InkWell(
                                onTap: () {
                                  _showDeleteDialog(
                                      context, isDarkMode, textColor);
                                },
                                child: _customRowImage(
                                    "Hapus Semua Data",
                                    "assets/img/face_id.png",
                                    "Reset",
                                    textColor),
                              ),
                            ],
                          ),
                        ),

                        // --- LAINNYA ---
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 8),
                          child: Text(
                            "Lainnya",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            color: containerColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              _customSwitchRow(
                                  "Mode Gelap",
                                  Image.asset("assets/img/light_theme.png",
                                      width: 20, height: 20, color: textColor),
                                  isDarkMode, (val) {
                                themeNotifier.value = val;
                              }, textColor),
                              _customRowImage("Versi Aplikasi",
                                  "assets/img/font.png", "v1.0.0", textColor),
                            ],
                          ),
                        ),

                        const SizedBox(height: 50),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- WIDGET HELPER ---

  Widget _customRowImage(
      String title, String iconPath, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Image.asset(iconPath, width: 20, height: 20, color: color),
          const SizedBox(width: 15),
          Expanded(
            child: Text(title,
                style: TextStyle(
                    color: color, fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          Text(value,
              style: TextStyle(
                  color: color.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Image.asset("assets/img/next.png",
              width: 12, height: 12, color: color.withOpacity(0.7))
        ],
      ),
    );
  }

  Widget _customSwitchRow(String title, Widget iconWidget, bool value,
      Function(bool) onChanged, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          iconWidget,
          const SizedBox(width: 15),
          Expanded(
            child: Text(title,
                style: TextStyle(
                    color: color, fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: TColor.primary,
          )
        ],
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, bool isDarkMode, Color textColor) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: isDarkMode ? TColor.gray : Colors.white,
            title: Text("Hapus Data?", style: TextStyle(color: textColor)),
            content: const Text("Semua data transaksi akan hilang permanen.",
                style: TextStyle(color: Colors.grey)),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal")),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      const Text("Hapus", style: TextStyle(color: Colors.red))),
            ],
          );
        });
  }
}

import 'package:flutter/material.dart';
import '../common/color_extension.dart';

// PENTING: Import Theme Manager
import '../common/theme_manager.dart';

class StatusButton extends StatelessWidget {
  final String title;
  final String value;
  final Color statusColor;
  final VoidCallback onPressed;

  const StatusButton(
      {super.key,
      required this.title,
      required this.value,
      required this.statusColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // 1. LISTEN TEMA
    return ValueListenableBuilder<bool>(
        valueListenable: themeNotifier,
        builder: (context, isDarkMode, child) {
          // --- WARNA DINAMIS ---
          var bgColor =
              isDarkMode ? TColor.gray60.withOpacity(0.2) : Colors.white;
          var borderColor = isDarkMode
              ? TColor.border.withOpacity(0.15)
              : Colors.grey.shade300;
          var titleColor = isDarkMode ? TColor.gray40 : TColor.gray50;
          var valueColor = isDarkMode ? TColor.white : TColor.gray;

          // Shadow tipis untuk mode terang agar kotak terlihat
          var shadowList = isDarkMode
              ? <BoxShadow>[]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ];

          return InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 68,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColor,
                    ),
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: shadowList,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: titleColor, // Warna teks judul dinamis
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        value,
                        style: TextStyle(
                            color: valueColor, // Warna teks nilai dinamis
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                // Garis Status Warna (Tetap sesuai parameter)
                Container(
                  width: 60,
                  height: 1,
                  color: statusColor,
                ),
              ],
            ),
          );
        });
  }
}

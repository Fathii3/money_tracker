import 'package:flutter/material.dart';
import '../common/color_extension.dart';
// PENTING: Import Theme Manager agar widget ini tahu status mode gelap/terang
import '../common/theme_manager.dart';

class UpcomingBillRow extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;

  const UpcomingBillRow(
      {super.key, required this.sObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Membungkus dengan ValueListenableBuilder untuk mendeteksi perubahan tema
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, isDarkMode, child) {
        // --- LOGIKA WARNA DINAMIS ---
        var textColor = isDarkMode ? TColor.white : TColor.gray;
        var subTextColor = isDarkMode ? TColor.gray30 : TColor.gray50;

        // Warna kotak tanggal (Kiri)
        var dateBoxColor = isDarkMode
            ? TColor.gray70.withOpacity(0.5)
            : TColor.gray10.withOpacity(0.5);

        // Warna garis pinggir (Border)
        var borderColor = isDarkMode
            ? TColor.border.withOpacity(0.15)
            : TColor.gray30.withOpacity(0.3);

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onPressed,
            child: Container(
              height: 64,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor, // Border dinamis
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: dateBoxColor, // Background tanggal dinamis
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "Jun",
                          style: TextStyle(
                              color: subTextColor, // Teks bulan dinamis
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "25",
                          style: TextStyle(
                              color: subTextColor, // Teks tanggal dinamis
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      sObj["name"],
                      style: TextStyle(
                          color: textColor, // Nama langganan dinamis
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Rp${sObj["price"]}",
                    style: TextStyle(
                        color: textColor, // Harga dinamis
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

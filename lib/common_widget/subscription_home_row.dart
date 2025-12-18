import 'package:flutter/material.dart';
import '../common/color_extension.dart';
// PENTING: Import Theme Manager agar widget ini tahu status mode gelap/terang
import '../common/theme_manager.dart';

class SubScriptionHomeRow extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;

  const SubScriptionHomeRow(
      {super.key, required this.sObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Membungkus dengan ValueListenableBuilder untuk mendeteksi perubahan tema
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, isDarkMode, child) {
        // --- LOGIKA WARNA DINAMIS ---
        // Jika mode gelap: Teks Putih. Jika mode terang: Teks Abu Gelap/Hitam
        var textColor = isDarkMode ? TColor.white : TColor.gray;

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
                  Image.asset(
                    sObj["icon"],
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      sObj["name"],
                      style: TextStyle(
                          color: textColor, // Nama Langganan dinamis
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

import 'package:flutter/material.dart';
import '../common/color_extension.dart';

// PENTING: Import Theme Manager
import '../common/theme_manager.dart';

class SubScriptionCell extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;

  const SubScriptionCell(
      {super.key, required this.sObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // 1. LISTEN TEMA
    return ValueListenableBuilder<bool>(
        valueListenable: themeNotifier,
        builder: (context, isDarkMode, child) {
          // --- WARNA DINAMIS ---
          var textColor = isDarkMode ? TColor.white : TColor.gray;
          var bgColor =
              isDarkMode ? TColor.gray60.withOpacity(0.2) : Colors.white;
          var borderColor = isDarkMode
              ? TColor.border.withOpacity(0.1)
              : TColor.gray30.withOpacity(0.3);
          var shadowColor =
              isDarkMode ? Colors.transparent : Colors.black.withOpacity(0.05);

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: bgColor, // Background dinamis
                  border: Border.all(
                    color: borderColor, // Border dinamis
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    if (!isDarkMode) // Tambah bayangan tipis jika mode terang agar kotak terlihat
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                  ]),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    sObj["icon"],
                    width: 45,
                    height: 45,
                  ),
                  const Spacer(),
                  Text(
                    sObj["name"],
                    style: TextStyle(
                        color: textColor, // Warna Teks Nama (Hitam/Putih)
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    // Cek apakah ada key "price" di data, jika tidak gunakan default
                    "Rp${sObj["price"] ?? "0"}",
                    style: TextStyle(
                        color: textColor, // Warna Teks Harga (Hitam/Putih)
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          );
        });
  }
}

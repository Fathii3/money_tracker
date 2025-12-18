import 'package:flutter/material.dart';
import '../common/color_extension.dart';
import '../common/theme_manager.dart'; // Import Theme Manager

class BudgetsRow extends StatelessWidget {
  final Map bObj;
  final VoidCallback onPressed;

  const BudgetsRow({super.key, required this.bObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // 1. Dengarkan perubahan tema
    return ValueListenableBuilder<bool>(
        valueListenable: themeNotifier,
        builder: (context, isDarkMode, child) {
          // 2. Tentukan Warna Dinamis
          // Disini kita pastikan teks jadi hitam jika mode terang
          var textColor = isDarkMode ? TColor.white : Colors.black;
          var subTextColor = isDarkMode ? TColor.gray30 : TColor.gray50;
          var containerColor =
              isDarkMode ? TColor.gray60.withOpacity(0.2) : TColor.white;
          var borderColor = isDarkMode
              ? TColor.border.withOpacity(0.1)
              : TColor.gray30.withOpacity(0.3);

          var proColor = bObj["color"] as Color? ?? TColor.secondary;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onPressed,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor,
                  ),
                  color: containerColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            bObj["icon"],
                            width: 30,
                            height: 30,
                            color: TColor.gray40,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bObj["name"],
                                style: TextStyle(
                                    color: textColor, // Nama Item (Hitam/Putih)
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Sisa Rp${bObj["left_amount"]}",
                                style: TextStyle(
                                    color: subTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Rp${bObj["total_budget"]}",
                              style: TextStyle(
                                  color: textColor, // Total (Hitam/Putih)
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Rp${bObj["spend_amount"]}",
                              style: TextStyle(
                                  color: subTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LinearProgressIndicator(
                        backgroundColor: TColor.gray60,
                        valueColor: AlwaysStoppedAnimation(proColor),
                        minHeight: 3,
                        value: (double.tryParse(bObj["spend_amount"]) ?? 0) /
                            (double.tryParse(bObj["total_budget"]) ?? 1),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

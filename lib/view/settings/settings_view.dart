import 'package:flutter/material.dart';
import '../../common/color_extension.dart';
import '../../common_widget/icon_item_row.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isReminderEnabled = false;
  bool isDarkMode = true; // Variable untuk menyimpan status Dark Mode

  @override
  Widget build(BuildContext context) {
    // Tentukan warna berdasarkan status Dark Mode
    var backgroundColor = isDarkMode ? TColor.gray : Colors.white;
    var textColor = isDarkMode ? TColor.white : TColor.gray;
    var subTextColor = isDarkMode ? TColor.gray30 : TColor.gray50;
    var containerColor = isDarkMode
        ? TColor.gray60.withOpacity(0.2)
        : TColor.gray10.withOpacity(0.1);

    return Scaffold(
      backgroundColor: backgroundColor, // Background berubah dinamis
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // --- HEADER (JUDUL) ---
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

              // --- MENU PENGATURAN ---
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SECTION 1: PREFERENSI
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 8),
                      child: Text(
                        "Preferensi",
                        style: TextStyle(
                            color: textColor, // Warna teks berubah dinamis
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: TColor.border.withOpacity(0.1),
                        ),
                        color: containerColor, // Warna kotak berubah dinamis
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          IconItemRow(
                            title: "Awal Siklus Bulan",
                            icon: "assets/img/calendar.png",
                            value: "Tanggal 1",
                          ),
                          IconItemSwitchRow(
                            title: "Pengingat Harian",
                            icon: "assets/img/app_icon.png",
                            value: isReminderEnabled,
                            didChange: (newVal) {
                              setState(() {
                                isReminderEnabled = newVal;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // SECTION 2: DATA & LAPORAN
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 8),
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
                        border: Border.all(
                          color: TColor.border.withOpacity(0.1),
                        ),
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
                            child: const IconItemRow(
                              title: "Export ke Excel/CSV",
                              icon: "assets/img/chart.png",
                              value: "Unduh",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: isDarkMode
                                          ? TColor.gray
                                          : Colors.white,
                                      title: Text("Hapus Data?",
                                          style: TextStyle(color: textColor)),
                                      content: const Text(
                                          "Semua data transaksi akan hilang permanen.",
                                          style: TextStyle(color: Colors.grey)),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Batal")),
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Hapus",
                                                style: TextStyle(
                                                    color: Colors.red))),
                                      ],
                                    );
                                  });
                            },
                            child: const IconItemRow(
                              title: "Hapus Semua Data",
                              icon: "assets/img/face_id.png",
                              value: "Reset",
                            ),
                          ),
                        ],
                      ),
                    ),

                    // SECTION 3: LAINNYA
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
                        border: Border.all(
                          color: TColor.border.withOpacity(0.1),
                        ),
                        color: containerColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          // --- FITUR GANTI TEMA ---
                          IconItemSwitchRow(
                            title: "Mode Gelap", // Ganti Judul
                            icon: "assets/img/light_theme.png",
                            value: isDarkMode, // Menggunakan variabel state
                            didChange: (newVal) {
                              setState(() {
                                isDarkMode = newVal; // Ubah state saat diklik
                              });
                            },
                          ),
                          // ------------------------

                          IconItemRow(
                            title: "Versi Aplikasi",
                            icon: "assets/img/font.png",
                            value: "v1.0.0",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

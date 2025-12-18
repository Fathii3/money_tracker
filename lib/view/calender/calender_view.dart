import 'dart:math';

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/subscription_cell.dart';

// PENTING: Import Theme Manager
import '../../common/theme_manager.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  CalendarAgendaController calendarAgendaControllerNotAppBar =
      CalendarAgendaController();
  late DateTime selectedDateNotAppBBar;

  Random random = Random();

  List subArr = [
    {"name": "Spotify", "icon": "assets/img/spotify_logo.png", "price": "5.99"},
    {
      "name": "YouTube Premium",
      "icon": "assets/img/youtube_logo.png",
      "price": "18.99"
    },
    {
      "name": "Microsoft OneDrive",
      "icon": "assets/img/onedrive_logo.png",
      "price": "29.99"
    },
    {"name": "NetFlix", "icon": "assets/img/netflix_logo.png", "price": "15.00"}
  ];

  @override
  void initState() {
    super.initState();
    selectedDateNotAppBBar = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    // 1. LISTEN TEMA
    return ValueListenableBuilder<bool>(
        valueListenable: themeNotifier,
        builder: (context, isDarkMode, child) {
          // --- WARNA DINAMIS ---
          var bgColor = isDarkMode ? TColor.gray : Colors.white;
          var textColor = isDarkMode ? TColor.white : TColor.gray;
          var subTextColor = isDarkMode ? TColor.gray30 : TColor.gray50;

          // Warna header background (lingkaran atas)
          var headerBgColor = isDarkMode
              ? TColor.gray70.withOpacity(0.5)
              : TColor.gray10.withOpacity(0.5);

          // Warna background kalender baris (strip)
          var calendarBgColor =
              Colors.transparent; // Biarkan transparan agar ikut header

          // Warna Item Tanggal (Text)
          var dateColor = isDarkMode ? TColor.white : TColor.gray;
          var selectedDateColor = isDarkMode
              ? TColor.white
              : TColor.white; // Text saat dipilih putih

          // Warna Background Kotak Tanggal
          var dateBoxColor = isDarkMode
              ? TColor.gray60.withOpacity(0.2)
              : Colors.white.withOpacity(0.5); // Kotak tidak aktif

          // Warna Background Kotak Tanggal TERPILIH (Ubah Ungu jadi Abu/Hitam)
          var selectedDateBoxColor = isDarkMode
              ? TColor.gray60 // Dark Mode: Abu terang
              : TColor.gray; // Light Mode: Hitam/Abu Gelap

          // Warna box kecil "Januari"
          var monthBoxColor =
              isDarkMode ? TColor.gray60.withOpacity(0.2) : Colors.white;
          var monthTextColor = isDarkMode ? TColor.white : TColor.gray;

          // Warna Dot Event (Ubah Ungu jadi Abu/Putih)
          var eventDotColor = isDarkMode ? TColor.gray30 : TColor.gray50;
          var selectedEventDotColor = TColor.white; // Dot saat dipilih

          return Scaffold(
            backgroundColor: bgColor, // Background dinamis
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // BAGIAN HEADER
                  Container(
                    decoration: BoxDecoration(
                        color: headerBgColor, // Header dinamis
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Kalender",
                                          style: TextStyle(
                                              color: subTextColor,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Jadwal\nLangganan",
                                  style: TextStyle(
                                      color: textColor, // Judul dinamis
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "3 langganan hari ini",
                                      style: TextStyle(
                                          color: subTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),

                                    // DROPDOWN BULAN
                                    InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {
                                        calendarAgendaControllerNotAppBar
                                            .openCalender();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                TColor.border.withOpacity(0.1),
                                          ),
                                          color:
                                              monthBoxColor, // Box bulan dinamis
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Januari",
                                              style: TextStyle(
                                                  color: monthTextColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Icon(
                                              Icons.expand_more,
                                              color: monthTextColor,
                                              size: 16.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                          // WIDGET KALENDER
                          CalendarAgenda(
                            controller: calendarAgendaControllerNotAppBar,
                            backgroundColor: Colors.transparent,
                            fullCalendarBackgroundColor:
                                isDarkMode ? TColor.gray80 : Colors.white,
                            locale: 'id',
                            weekDay: WeekDay.short,
                            fullCalendarDay: WeekDay.short,

                            // Konfigurasi Warna Teks
                            selectedDateColor: selectedDateColor,
                            dateColor: dateColor,

                            initialDate: DateTime.now(),
                            calendarEventColor:
                                eventDotColor, // Warna dot event default

                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 140)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 140)),

                            events: List.generate(
                                100,
                                (index) => DateTime.now().subtract(
                                    Duration(days: index * random.nextInt(5)))),

                            onDateSelected: (date) {
                              setState(() {
                                selectedDateNotAppBBar = date;
                              });
                            },

                            // Style Container Tanggal (TIDAK DIPILIH)
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: TColor.border.withOpacity(0.15),
                              ),
                              color: dateBoxColor,
                              borderRadius: BorderRadius.circular(12),
                            ),

                            // Style Container Tanggal (TERPILIH)
                            selectDecoration: BoxDecoration(
                              border: Border.all(
                                color: TColor.border.withOpacity(0.15),
                              ),
                              color:
                                  selectedDateBoxColor, // Warna Background Abu/Hitam (Bukan Ungu)
                              borderRadius: BorderRadius.circular(12),
                            ),

                            // Dot Event pada tanggal TERPILIH
                            selectedEventLogo: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: selectedEventDotColor, // Putih
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),

                            // Dot Event pada tanggal BIASA
                            eventLogo: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: eventDotColor, // Abu-abu
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // BAGIAN LIST ITEM (Di Bawah Kalender)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Januari",
                              style: TextStyle(
                                  color: textColor, // Judul bulan dinamis
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rp24.98",
                              style: TextStyle(
                                  color: textColor, // Total harga dinamis
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "08.01.2023",
                              style: TextStyle(
                                  color: subTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "dalam tagihan mendatang",
                              style: TextStyle(
                                  color: subTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  // GRID ITEM LANGGANAN
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1),
                      itemCount: subArr.length,
                      itemBuilder: (context, index) {
                        var sObj = subArr[index] as Map? ?? {};

                        return SubScriptionCell(
                          sObj: sObj,
                          onPressed: () {},
                        );
                      }),
                  const SizedBox(
                    height: 130,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

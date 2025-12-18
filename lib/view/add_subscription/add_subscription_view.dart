import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/primary_button.dart';
import 'package:trackizer/common_widget/round_textfield.dart';
import 'package:trackizer/common_widget/simple_calculator.dart'; // 1. IMPORT KALKULATOR

import '../../common/theme_manager.dart';
import 'add_expense_view.dart';
import 'add_income_view.dart';

class AddSubScriptionView extends StatefulWidget {
  const AddSubScriptionView({super.key});

  @override
  State<AddSubScriptionView> createState() => _AddSubScriptionViewState();
}

class _AddSubScriptionViewState extends State<AddSubScriptionView> {
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtAmount = TextEditingController();

  // --- VARIABEL TANGGAL & JAM ---
  DateTime selectDate = DateTime.now();
  TimeOfDay selectTime = TimeOfDay.now();

  List subArr = [
    {"name": "HBO GO", "icon": "assets/img/hbo_logo.png"},
    {"name": "Spotify", "icon": "assets/img/spotify_logo.png"},
    {"name": "YouTube Premium", "icon": "assets/img/youtube_logo.png"},
    {"name": "Microsoft OneDrive", "icon": "assets/img/onedrive_logo.png"},
    {"name": "Canva", "icon": "assets/img/canva.png"},
    {"name": "NetFlix", "icon": "assets/img/netflix_logo.png"},
    {"name": "Lainnya", "icon": "assets/img/lainnya.png"}
  ];

  String get dateToString {
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mei",
      "Jun",
      "Jul",
      "Agus",
      "Sep",
      "Okt",
      "Nov",
      "Des"
    ];
    int monthIndex = (selectDate.month - 1).clamp(0, 11);
    return "${selectDate.day} ${months[monthIndex]} ${selectDate.year}";
  }

  String get timeToString {
    final hour = selectTime.hour.toString().padLeft(2, '0');
    final minute = selectTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return ValueListenableBuilder<bool>(
        valueListenable: themeNotifier,
        builder: (context, isDarkMode, child) {
          var bgColor = isDarkMode ? TColor.gray : Colors.white;
          var textColor = isDarkMode ? TColor.white : TColor.gray;
          var subTextColor = isDarkMode ? TColor.gray40 : TColor.gray50;
          var headerBgColor = isDarkMode
              ? TColor.gray70.withOpacity(0.5)
              : TColor.gray10.withOpacity(0.5);
          var inputBgColor = isDarkMode
              ? TColor.gray60.withOpacity(0.2)
              : Colors.grey.shade100;
          var borderColor = isDarkMode
              ? TColor.border.withOpacity(0.15)
              : Colors.grey.shade300;

          return Scaffold(
            backgroundColor: bgColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: headerBgColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Image.asset("assets/img/back.png",
                                          width: 25,
                                          height: 25,
                                          color: subTextColor))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Baru",
                                    style: TextStyle(
                                        color: subTextColor, fontSize: 16),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              height: 50,
                              width: media.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: TColor.gray70,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 2))
                                            ]),
                                        alignment: Alignment.center,
                                        child: Text("Langganan",
                                            style: TextStyle(
                                                color: TColor.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                const AddExpenseView(),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration:
                                                Duration.zero,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text("Pengeluaran",
                                            style: TextStyle(
                                                color: TColor.gray30,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                const AddIncomeView(),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration:
                                                Duration.zero,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text("Pemasukan",
                                            style: TextStyle(
                                                color: TColor.gray30,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "Tambah\nLangganan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 40,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: media.width,
                            height: media.width * 0.6,
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                autoPlay: false,
                                aspectRatio: 1,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true,
                                viewportFraction: 0.65,
                                enlargeFactor: 0.4,
                                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                              ),
                              itemCount: subArr.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                var sObj = subArr[itemIndex] as Map? ?? {};
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        sObj["icon"],
                                        width: media.width * 0.4,
                                        height: media.width * 0.4,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      const Spacer(),
                                      Text(
                                        sObj["name"],
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // INPUT TANGGAL & JAM
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tanggal",
                                  style: TextStyle(
                                      color: subTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: selectDate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    locale: const Locale('id', 'ID'),
                                    builder: (context, child) {
                                      return Theme(
                                        data: isDarkMode
                                            ? ThemeData.dark().copyWith(
                                                colorScheme: ColorScheme.dark(
                                                    primary: TColor.primary,
                                                    onPrimary: Colors.white,
                                                    surface: bgColor,
                                                    onSurface: textColor),
                                                dialogBackgroundColor: bgColor)
                                            : ThemeData.light().copyWith(
                                                colorScheme: ColorScheme.light(
                                                    primary: TColor.primary,
                                                    onPrimary: Colors.white,
                                                    surface: bgColor,
                                                    onSurface: textColor),
                                                dialogBackgroundColor: bgColor),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (picked != null && picked != selectDate) {
                                    setState(() {
                                      selectDate = picked;
                                    });
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: inputBgColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: borderColor),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    dateToString,
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jam",
                                  style: TextStyle(
                                      color: subTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () async {
                                  TimeOfDay? picked = await showTimePicker(
                                    context: context,
                                    initialTime: selectTime,
                                    builder: (context, child) {
                                      final themeData = isDarkMode
                                          ? ThemeData.dark().copyWith(
                                              colorScheme: ColorScheme.dark(
                                                  primary: TColor.primary,
                                                  onPrimary: Colors.white,
                                                  surface: bgColor,
                                                  onSurface: textColor),
                                              timePickerTheme:
                                                  TimePickerThemeData(
                                                      backgroundColor: bgColor))
                                          : ThemeData.light().copyWith(
                                              colorScheme: ColorScheme.light(
                                                  primary: TColor.primary,
                                                  onPrimary: Colors.white,
                                                  surface: bgColor,
                                                  onSurface: textColor),
                                              timePickerTheme:
                                                  TimePickerThemeData(
                                                      backgroundColor:
                                                          bgColor));
                                      return Theme(
                                          data: themeData,
                                          child: MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      alwaysUse24HourFormat:
                                                          true),
                                              child: child!));
                                    },
                                  );
                                  if (picked != null && picked != selectTime) {
                                    setState(() {
                                      selectTime = picked;
                                    });
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: inputBgColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: borderColor),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    timeToString,
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Text("Deskripsi",
                              style: TextStyle(
                                  color: subTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: inputBgColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: borderColor),
                            ),
                            child: TextField(
                              controller: txtDescription,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      )),

                  // --- INPUT HARGA + KALKULATOR (DIPERBARUI WARNA IKON) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          "Harga Bulanan",
                          style: TextStyle(
                              color: subTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: txtAmount,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0",
                                  hintStyle: TextStyle(
                                      color: subTextColor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                  prefixText: "Rp ",
                                  prefixStyle: TextStyle(
                                      color: textColor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),

                            // TOMBOL KALKULATOR DENGAN WARNA DINAMIS
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return SimpleCalculator(
                                        onDone: (String val) {
                                          setState(() {
                                            txtAmount.text = val;
                                          });
                                        },
                                      );
                                    });
                              },
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    // BG Kotak: Abu gelap jika dark, abu muda jika light
                                    color: isDarkMode
                                        ? TColor.gray70
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: TColor.border.withOpacity(
                                            isDarkMode ? 0.2 : 0.1))),
                                child: Icon(
                                  Icons.calculate_rounded,
                                  // Ikon: Putih jika dark, Abu gelap/Hitam jika light
                                  color:
                                      isDarkMode ? Colors.white : TColor.gray,
                                  size: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 150,
                          height: 1,
                          color: TColor.gray70,
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrimaryButton(
                        title: "Tambahkan Platform", onPressed: () {}),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }
}

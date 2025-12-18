import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/primary_button.dart';
import 'package:trackizer/common_widget/round_textfield.dart';
import 'package:trackizer/common_widget/simple_calculator.dart'; // 1. IMPORT KALKULATOR

// PENTING: Import Theme Manager & View Lain untuk Navigasi
import '../../common/theme_manager.dart';
import 'add_subscription_view.dart';
import 'add_income_view.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtAmount = TextEditingController();

  // --- VARIABEL BARU: TANGGAL & JAM ---
  DateTime selectDate = DateTime.now();
  TimeOfDay selectTime = TimeOfDay.now();

  // MENGGUNAKAN ICON BAWAAN FLUTTER
  List expenseArr = [
    {"name": "Makanan", "icon": Icons.fastfood_rounded},
    {"name": "Transportasi", "icon": Icons.directions_car_rounded},
    {"name": "Belanja", "icon": Icons.shopping_bag_rounded},
    {"name": "Rumah", "icon": Icons.home_rounded},
    {"name": "Hiburan", "icon": Icons.movie_rounded},
    {"name": "Kesehatan", "icon": Icons.local_hospital_rounded},
    {"name": "Pendidikan", "icon": Icons.school_rounded},
    {"name": "Lainnya", "icon": Icons.category_rounded},
  ];

  // --- HELPER FORMAT TANGGAL ---
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

  // --- HELPER FORMAT JAM (24 Jam) ---
  String get timeToString {
    final hour = selectTime.hour.toString().padLeft(2, '0');
    final minute = selectTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    // LISTEN TEMA (Mode Gelap/Terang)
    return ValueListenableBuilder<bool>(
        valueListenable: themeNotifier,
        builder: (context, isDarkMode, child) {
          // --- WARNA DINAMIS ---
          var bgColor = isDarkMode ? TColor.gray : Colors.white;
          var textColor = isDarkMode ? TColor.white : TColor.gray;
          var subTextColor = isDarkMode ? TColor.gray30 : TColor.gray50;
          var headerBgColor = isDarkMode
              ? TColor.gray70.withOpacity(0.5)
              : TColor.gray10.withOpacity(0.5);
          var boxColor = isDarkMode
              ? TColor.gray60.withOpacity(0.2)
              : Colors.grey.shade100;
          var borderColor = isDarkMode
              ? TColor.border.withOpacity(0.1)
              : Colors.grey.shade300;
          var inputBgColor = isDarkMode
              ? TColor.gray60.withOpacity(0.2)
              : Colors.grey.shade100;

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
                          // --- HEADER ---
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

                          // --- TOMBOL TOGGLE (3 MENU) ---
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
                                  // 1. TOMBOL LANGGANAN
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                const AddSubScriptionView(),
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
                                        child: Text("Langganan",
                                            style: TextStyle(
                                                color: TColor.gray30,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),

                                  // 2. TOMBOL PENGELUARAN (AKTIF)
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: TColor.gray70, // Warna Aktif
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 2))
                                            ]),
                                        alignment: Alignment.center,
                                        child: Text("Pengeluaran",
                                            style: TextStyle(
                                                color:
                                                    TColor.white, // Teks Aktif
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),

                                  // 3. TOMBOL PEMASUKAN
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
                            "Tambah\nPengeluaran",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 40,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 20),

                          // --- CAROUSEL SLIDER ---
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
                              itemCount: expenseArr.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                var sObj = expenseArr[itemIndex] as Map? ?? {};

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: boxColor, // Dinamis
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        )
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        sObj["icon"],
                                        size: media.width * 0.25,
                                        color: isDarkMode
                                            ? TColor.white
                                            : TColor.secondary,
                                      ),
                                      const Spacer(),
                                      Text(
                                        sObj["name"],
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
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

                  // --- INPUT TANGGAL & JAM ---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        // INPUT TANGGAL
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tanggal",
                                style: TextStyle(
                                    color: subTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: selectDate,
                                    firstDate: DateTime(2000), // Range Aman
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
                                                  onSurface: textColor,
                                                ),
                                                dialogTheme: DialogThemeData(
                                                    backgroundColor: bgColor),
                                              )
                                            : ThemeData.light().copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: TColor.primary,
                                                  onPrimary: Colors.white,
                                                  surface: bgColor,
                                                  onSurface: textColor,
                                                ),
                                                dialogTheme: DialogThemeData(
                                                    backgroundColor: bgColor),
                                              ),
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

                        // INPUT JAM
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jam",
                                style: TextStyle(
                                    color: subTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
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
                                                onSurface: textColor,
                                              ),
                                              timePickerTheme:
                                                  TimePickerThemeData(
                                                backgroundColor: bgColor,
                                              ))
                                          : ThemeData.light().copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: TColor.primary,
                                                onPrimary: Colors.white,
                                                surface: bgColor,
                                                onSurface: textColor,
                                              ),
                                              timePickerTheme:
                                                  TimePickerThemeData(
                                                backgroundColor: bgColor,
                                              ));
                                      return Theme(
                                        data: themeData,
                                        child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        ),
                                      );
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

                  // --- INPUT DESKRIPSI ---
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Text(
                            "Deskripsi",
                            style: TextStyle(
                                color: subTextColor, // Label (Abu-abu)
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
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
                                  color: textColor, // Input Text
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      )),

                  // --- INPUT NOMINAL & KALKULATOR ---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          "Nominal",
                          style: TextStyle(
                              color: subTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 1. TEXTFIELD (Expanded)
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
                                  hintText: "Rp0",
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

                            // 2. TOMBOL KALKULATOR
                            IconButton(
                              onPressed: () {
                                // TAMPILKAN MODAL KALKULATOR
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    // PENTING: AGAR BISA DIGESER KE ATAS & FULL SCREEN
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return SimpleCalculator(
                                        onDone: (String val) {
                                          // Update textfield saat OK ditekan
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

                  // --- BUTTON SIMPAN ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrimaryButton(
                        title: "Tambahkan Pengeluaran", onPressed: () {}),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }
}

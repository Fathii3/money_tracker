import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../common_widget/custom_arc_painter.dart';
import '../../common_widget/segment_button.dart';
import '../../common_widget/status_button.dart';
import '../../common_widget/subscription_home_row.dart';
import '../../common_widget/upcoming_bill_row.dart';

// PENTING: Import Theme Manager agar Home bisa berubah warna
import '../../common/theme_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSubscription = true;

  List subArr = [
    {
      "name": "Spotify",
      "icon": "assets/img/spotify_logo.png",
      "price": "60.000"
    },
    {
      "name": "YouTube Premium",
      "icon": "assets/img/youtube_logo.png",
      "price": "190.000"
    },
    {
      "name": "Microsoft OneDrive",
      "icon": "assets/img/onedrive_logo.png",
      "price": "300.000"
    },
    {
      "name": "NetFlix",
      "icon": "assets/img/netflix_logo.png",
      "price": "150.000"
    }
  ];

  List bilArr = [
    {"name": "Spotify", "date": DateTime(2023, 07, 25), "price": "60.000"},
    {
      "name": "YouTube Premium",
      "date": DateTime(2023, 07, 25),
      "price": "190.000"
    },
    {
      "name": "Microsoft OneDrive",
      "date": DateTime(2023, 07, 25),
      "price": "300.000"
    },
    {"name": "NetFlix", "date": DateTime(2023, 07, 25), "price": "Rp 150.000"}
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    // 1. DENGARKAN PERUBAHAN TEMA
    return ValueListenableBuilder<bool>(
        valueListenable: themeNotifier,
        builder: (context, isDarkMode, child) {
          // --- DEFINISI WARNA DINAMIS ---
          var bgColor = isDarkMode ? TColor.gray : Colors.white;
          var textColor = isDarkMode ? TColor.white : TColor.gray;
          var subTextColor = isDarkMode ? TColor.gray40 : TColor.gray50;

          var headerBgColor = isDarkMode
              ? TColor.gray70.withOpacity(0.5)
              : TColor.gray10.withOpacity(0.5);

          var buttonBgColor =
              isDarkMode ? TColor.gray60.withOpacity(0.3) : Colors.white;
          var buttonBorderColor = isDarkMode
              ? TColor.border.withOpacity(0.15)
              : TColor.gray30.withOpacity(0.5);

          var segmentContainerColor =
              isDarkMode ? Colors.black : Colors.grey.shade200;

          return Scaffold(
            backgroundColor: bgColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: media.width * 1.1,
                    decoration: BoxDecoration(
                        color: headerBgColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/img/home_bg.png",
                            color: isDarkMode
                                ? null
                                : Colors.white.withOpacity(0.6)),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(bottom: media.width * 0.05),
                              width: media.width * 0.72,
                              height: media.width * 0.72,
                              child: CustomPaint(
                                painter: CustomArcPainter(
                                  end: 220,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: media.width * 0.05),
                            Image.asset("assets/img/app_logo.png",
                                width: media.width * 0.25, fit: BoxFit.contain),
                            SizedBox(height: media.width * 0.07),
                            Text(
                              "Rp 2.500.000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: media.width * 0.055),
                            Text(
                              "Tagihan bulan ini",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: subTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: media.width * 0.07),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => const GrafikPopup(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: buttonBorderColor,
                                  ),
                                  color: buttonBgColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  "Lihat anggaran Anda",
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: StatusButton(
                                      title: "Langganan\nAktif",
                                      value: "3",
                                      statusColor: TColor.secondary,
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: StatusButton(
                                      title: "Pengeluaran\nLangganan",
                                      value: "Rp 500.000",
                                      statusColor: TColor.primary10,
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: StatusButton(
                                      title: "Pengeluaran\nKeuangan",
                                      value: "Rp 2.500.000",
                                      statusColor: TColor.secondaryG,
                                      onPressed: () {},
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    height: 50,
                    decoration: BoxDecoration(
                        color: segmentContainerColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Expanded(
                          child: SegmentButton(
                            title: "Langganan Anda",
                            isActive: isSubscription,
                            onPressed: () {
                              setState(() {
                                isSubscription = !isSubscription;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: SegmentButton(
                            title: "Transaksi Terbaru",
                            isActive: !isSubscription,
                            onPressed: () {
                              setState(() {
                                isSubscription = !isSubscription;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  // --- LIST ITEM ---
                  if (isSubscription)
                    ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: subArr.length,
                        itemBuilder: (context, index) {
                          var sObj = subArr[index] as Map? ?? {};
                          return SubScriptionHomeRow(
                            sObj: sObj,
                            onPressed: () {},
                          );
                        }),

                  // --- PERUBAHAN DI SINI: UpcomingBillRow Custom ---
                  // Saya memodifikasi tampilan item di sini agar icon tanggal berubah jadi icon Add
                  if (!isSubscription)
                    ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: subArr.length,
                        itemBuilder: (context, index) {
                          var sObj = subArr[index] as Map? ?? {};

                          // KITA BUAT WIDGET CUSTOM DI SINI LANGSUNG AGAR SESUAI PERMINTAAN
                          // Menggantikan UpcomingBillRow standar
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {},
                              child: Container(
                                height: 64,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDarkMode
                                        ? TColor.border.withOpacity(0.15)
                                        : TColor.gray30.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    // --- ICON TANGGAL DIGANTI ICON ADD ---
                                    Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.all(
                                          10), // Padding disesuaikan untuk icon
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? TColor.gray70.withOpacity(0.5)
                                            : TColor.gray10.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        "assets/img/add.png", // Icon Add
                                        width: 20,
                                        height: 20,
                                        color:
                                            subTextColor, // Warna mengikuti tema
                                      ),
                                    ),
                                    // -------------------------------------

                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        sObj["name"],
                                        style: TextStyle(
                                            color:
                                                textColor, // Warna Teks Dinamis
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
                                          color:
                                              textColor, // Warna Harga Dinamis
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  const SizedBox(
                    height: 110,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// ============================================================================
// WIDGET POP UP GRAFIK (TIDAK PERLU DIUBAH LAGI KARENA SUDAH BENAR)
// ============================================================================

class GrafikPopup extends StatefulWidget {
  const GrafikPopup({super.key});

  @override
  State<GrafikPopup> createState() => _GrafikPopupState();
}

class _GrafikPopupState extends State<GrafikPopup> {
  DateTime _selectedDate = DateTime.now();
  List _allTransactions = [];
  bool _isLoading = true;
  double _totalIncome = 0;
  double _totalExpense = 0;
  Map<String, double> _expenseCategories = {};

  final Map<String, Color> categoryColors = {
    'Makanan': TColor.secondary,
    'Belanja': TColor.primary10,
    'Transportasi': const Color(0xFF66BB6A),
    'Hiburan': TColor.secondaryG,
    'Kesehatan': const Color(0xFF26C6DA),
    'Pendidikan': const Color(0xFFFFCA28),
    'Lainnya': TColor.gray30,
  };

  Color _getCategoryColor(String category) =>
      categoryColors[category] ?? TColor.gray30;

  IconData _getIconByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Icons.restaurant_rounded;
      case 'belanja':
        return Icons.shopping_bag_rounded;
      case 'transportasi':
        return Icons.motorcycle_rounded;
      case 'hiburan':
        return Icons.movie_rounded;
      case 'kesehatan':
        return Icons.local_hospital_rounded;
      case 'pendidikan':
        return Icons.school_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDummyData();
  }

  void _loadDummyData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    var dummyData = [
      {
        'date': DateTime.now().toString(),
        'amount': 5000000,
        'type': 'income',
        'category': 'Gaji'
      },
      {
        'date': DateTime.now().toString(),
        'amount': 150000,
        'type': 'expense',
        'category': 'Makanan'
      },
      {
        'date': DateTime.now().toString(),
        'amount': 50000,
        'type': 'expense',
        'category': 'Transportasi'
      },
      {
        'date': DateTime.now().toString(),
        'amount': 300000,
        'type': 'expense',
        'category': 'Belanja'
      },
      {
        'date': DateTime.now().toString(),
        'amount': 100000,
        'type': 'expense',
        'category': 'Hiburan'
      },
    ];
    if (mounted) {
      setState(() {
        _allTransactions = dummyData;
        _isLoading = false;
        _calculateData();
      });
    }
  }

  void _calculateData() {
    double income = 0;
    double expense = 0;
    Map<String, double> categories = {};
    for (var item in _allTransactions) {
      DateTime date = DateTime.parse(item['date'].toString());
      if (date.month == _selectedDate.month &&
          date.year == _selectedDate.year) {
        double amount = double.parse(item['amount'].toString());
        if (item['type'] == 'income') {
          income += amount;
        } else {
          expense += amount;
          String catName = item['category'] ?? 'Lainnya';
          categories[catName] = (categories[catName] ?? 0) + amount;
        }
      }
    }
    setState(() {
      _totalIncome = income;
      _totalExpense = expense;
      _expenseCategories = categories;
    });
  }

  void _changeMonth(int offset) {
    setState(() {
      _selectedDate =
          DateTime(_selectedDate.year, _selectedDate.month + offset);
      _calculateData();
    });
  }

  String _formatRupiah(double number) {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
        .format(number);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: themeNotifier,
        builder: (context, isDarkMode, child) {
          var bgColor = isDarkMode ? TColor.gray : Colors.white;
          var textColor = isDarkMode ? TColor.white : TColor.gray;
          var subTextColor = isDarkMode ? TColor.gray40 : TColor.gray50;

          var headerBg = isDarkMode
              ? TColor.gray70.withOpacity(0.5)
              : TColor.gray10.withOpacity(0.5);
          var containerColor = isDarkMode
              ? TColor.gray60.withOpacity(0.2)
              : Colors.grey.shade100;
          var borderColor = isDarkMode
              ? TColor.border.withOpacity(0.15)
              : Colors.grey.shade300;

          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              child: Stack(
                children: [
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: headerBg,
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(30)),
                    ),
                  ),
                  Column(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: TColor.gray30,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: Text(
                          'Laporan Keuangan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          color: containerColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios_rounded,
                                  size: 18, color: textColor),
                              onPressed: () => _changeMonth(-1),
                            ),
                            Text(
                              "${_selectedDate.month}/${_selectedDate.year}",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios_rounded,
                                  size: 18, color: textColor),
                              onPressed: () => _changeMonth(1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: containerColor,
                                            border:
                                                Border.all(color: borderColor),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Pemasukan",
                                                        style: TextStyle(
                                                            color: subTextColor,
                                                            fontSize: 12)),
                                                    Text(
                                                      _formatRupiah(
                                                          _totalIncome),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  width: 1,
                                                  height: 30,
                                                  color: TColor.gray30
                                                      .withOpacity(0.5)),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Pengeluaran",
                                                        style: TextStyle(
                                                            color: subTextColor,
                                                            fontSize: 12)),
                                                    Text(
                                                      _formatRupiah(
                                                          _totalExpense),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          height: 220,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: containerColor,
                                            border:
                                                Border.all(color: borderColor),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: _totalExpense == 0
                                              ? Center(
                                                  child: Text(
                                                      "Belum ada pengeluaran",
                                                      style: TextStyle(
                                                          color: subTextColor)))
                                              : PieChart(
                                                  PieChartData(
                                                    sections: _expenseCategories
                                                        .entries
                                                        .map((e) {
                                                      return PieChartSectionData(
                                                        color:
                                                            _getCategoryColor(
                                                                e.key),
                                                        value: e.value,
                                                        title:
                                                            '${(e.value / _totalExpense * 100).toStringAsFixed(0)}%',
                                                        radius: 50,
                                                        titleStyle: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                TColor.white),
                                                      );
                                                    }).toList(),
                                                    centerSpaceRadius: 40,
                                                    sectionsSpace: 2,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Detail Kategori",
                                        style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children:
                                          _expenseCategories.entries.map((e) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: containerColor,
                                            border:
                                                Border.all(color: borderColor),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color:
                                                      _getCategoryColor(e.key)
                                                          .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Icon(
                                                    _getIconByCategory(e.key),
                                                    color: _getCategoryColor(
                                                        e.key)),
                                              ),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                child: Text(e.key,
                                                    style: TextStyle(
                                                        color: textColor,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                              Text(_formatRupiah(e.value),
                                                  style: TextStyle(
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 15,
                    right: 20,
                    child: IconButton(
                      icon: Icon(Icons.close, color: textColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

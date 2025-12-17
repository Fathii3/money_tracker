import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/primary_button.dart';
import 'package:trackizer/common_widget/round_textfield.dart';

// PENTING: Import file Subscription agar bisa kembali
import 'add_subscription_view.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtAmount = TextEditingController();

  // Data Kategori Pengeluaran (Ganti icon sesuai aset kamu)
  List expenseArr = [
    {"name": "Food & Drink", "icon": "assets/img/netflix_logo.png"},
    {"name": "Transportation", "icon": "assets/img/spotify_logo.png"},
    {"name": "Shopping", "icon": "assets/img/youtube_logo.png"},
    {"name": "Housing", "icon": "assets/img/onedrive_logo.png"},
    {"name": "Entertainment", "icon": "assets/img/hbo_logo.png"}
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
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
                                    color: TColor.gray30))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Baru", // Terjemahan "New"
                              style:
                                  TextStyle(color: TColor.gray30, fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),

                    // --- TOMBOL TOGGLE (EXPENSE AKTIF) ---
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        height: 50,
                        width: media.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            // Tombol Langganan (TIDAK AKTIF - KLIK PINDAH)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // Pindah ke Subscription View
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const AddSubScriptionView(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                      "Langganan", // Terjemahan "Subscription"
                                      style: TextStyle(
                                          color: TColor.gray30,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                            // Tombol Pengeluaran (AKTIF)
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: TColor.gray70, // Warna Aktif
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                      "Pengeluaran", // Terjemahan "Expense"
                                      style: TextStyle(
                                          color: TColor.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Text(
                      "Tambah\nPengeluaran", // Terjemahan "Add new expense"
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.white,
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
                        itemCount: expenseArr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var sObj = expenseArr[itemIndex] as Map? ?? {};
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
                                      color: TColor.white,
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
            Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: RoundTextField(
                  title: "Deskripsi", // Terjemahan "Description"
                  titleAlign: TextAlign.center,
                  controller: txtDescription,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "Nominal", // Terjemahan "Amount"
                    style: TextStyle(
                        color: TColor.gray40,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: media.width * 0.7,
                    child: TextField(
                      controller: txtAmount,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Rp0",
                        hintStyle: TextStyle(
                            color: TColor.gray30,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                        prefixText: "Rp ",
                        prefixStyle: TextStyle(
                            color: TColor.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
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
                  title: "Tambahkan Pengeluaran",
                  onPressed: () {}), // Terjemahan Button
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

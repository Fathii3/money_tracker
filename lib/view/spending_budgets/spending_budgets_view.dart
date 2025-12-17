import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/budgets_row.dart';
import 'package:trackizer/common_widget/custom_arc_180_painter.dart';

class SpendingBudgetsView extends StatefulWidget {
  const SpendingBudgetsView({super.key});

  @override
  State<SpendingBudgetsView> createState() => _SpendingBudgetsViewState();
}

class _SpendingBudgetsViewState extends State<SpendingBudgetsView> {
  // DATA DUMMY DISESUAIKAN DENGAN FORMAT RUPIAH (ANGKA MURNI STRING AGAR TIDAK ERROR)
  List budgetArr = [
    {
      "name": "Otomotif & Transpor",
      "icon": "assets/img/auto_&_transport.png",
      "spend_amount": "250000", // 250 Ribu
      "total_budget": "500000", // 500 Ribu
      "left_amount": "250000", // Sisa 250 Ribu
      "color": TColor.secondaryG
    },
    {
      "name": "Hiburan",
      "icon": "assets/img/entertainment.png",
      "spend_amount": "300000", // 300 Ribu
      "total_budget": "600000", // 600 Ribu
      "left_amount": "300000", // Sisa 300 Ribu
      "color": TColor.secondary50
    },
    {
      "name": "Keamanan",
      "icon": "assets/img/security.png",
      "spend_amount": "100000", // 100 Ribu
      "total_budget": "200000", // 200 Ribu
      "left_amount": "100000", // Sisa 100 Ribu
      "color": TColor.primary10
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: media.width * 0.5,
                  height: media.width * 0.30,
                  child: CustomPaint(
                    painter: CustomArc180Painter(
                      drwArcs: [
                        ArcValueModel(color: TColor.secondaryG, value: 20),
                        ArcValueModel(color: TColor.secondary, value: 45),
                        ArcValueModel(color: TColor.primary10, value: 70),
                      ],
                      end: 50,
                      width: 12,
                      bgWidth: 8,
                    ),
                  ),
                ),
                Column(
                  children: [
                    // TOTAL PENGELUARAN (SESUAI TOTAL DATA DIATAS: 250k + 300k + 100k = 650k)
                    Text(
                      "Rp 650.000",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    // TOTAL ANGGARAN (SESUAI TOTAL DATA DIATAS: 500k + 600k + 200k = 1.3jt)
                    Text(
                      "dari anggaran Rp 1.300.000",
                      style: TextStyle(
                          color: TColor.gray30,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TColor.border.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Anggaran Anda sesuai rencana 👍",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: budgetArr.length,
                itemBuilder: (context, index) {
                  var bObj = budgetArr[index] as Map? ?? {};

                  return BudgetsRow(
                    bObj: bObj,
                    onPressed: () {},
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const AddBudgetPopup(),
                  );
                },
                child: DottedBorder(
                  dashPattern: const [5, 4],
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(16),
                  color: TColor.border.withOpacity(0.1),
                  child: Container(
                    height: 64,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tambah kategori baru ",
                          style: TextStyle(
                              color: TColor.gray30,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Image.asset(
                          "assets/img/add.png",
                          width: 12,
                          height: 12,
                          color: TColor.gray30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET POP UP TAMBAH ANGGARAN
// ============================================================================

class AddBudgetPopup extends StatefulWidget {
  const AddBudgetPopup({super.key});

  @override
  State<AddBudgetPopup> createState() => _AddBudgetPopupState();
}

class _AddBudgetPopupState extends State<AddBudgetPopup> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _awalController = TextEditingController();

  bool _isSending = false;
  int _selectedIconIndex = 0;

  final List<String> _iconAssets = [
    "assets/img/auto_&_transport.png",
    "assets/img/entertainment.png",
    "assets/img/security.png",
    "assets/img/home.png",
    "assets/img/calendar.png",
    "assets/img/chart.png",
    "assets/img/money.png",
    "assets/img/settings.png"
  ];

  Future<void> _simpanData() async {
    setState(() => _isSending = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isSending = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: TColor.gray,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: TColor.gray30,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: TColor.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    'Tambah Kategori Anggaran',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: TColor.white,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Nama Kategori"),
                  _buildTextField(
                    controller: _namaController,
                    hint: "Contoh: Makanan, Transportasi",
                    icon: Icons.category,
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("Batas Anggaran (Rp)"),
                  _buildTextField(
                    controller: _targetController,
                    hint: "0",
                    icon: Icons.monetization_on_outlined,
                    isNumber: true,
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("Terpakai Saat Ini (Opsional)"),
                  _buildTextField(
                    controller: _awalController,
                    hint: "0",
                    icon: Icons.account_balance_wallet_outlined,
                    isNumber: true,
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("Pilih Ikon"),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: _iconAssets.asMap().entries.map((entry) {
                        int index = entry.key;
                        String iconPath = entry.value;
                        final isSelected = _selectedIconIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedIconIndex = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? TColor.secondary
                                      : TColor.gray60.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: isSelected
                                          ? TColor.secondary
                                          : TColor.border.withOpacity(0.15))),
                              child: Image.asset(
                                iconPath,
                                width: 24,
                                height: 24,
                                color:
                                    isSelected ? TColor.white : TColor.gray30,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: _isSending ? null : _simpanData,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/img/primary_btn.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: TColor.secondary.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ]),
                      alignment: Alignment.center,
                      child: _isSending
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: TColor.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "SIMPAN",
                              style: TextStyle(
                                color: TColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600, color: TColor.gray40, fontSize: 14),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isNumber = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: TColor.gray60.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TColor.border.withOpacity(0.15)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: TextStyle(color: TColor.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: TColor.gray30, fontSize: 14),
          icon: Icon(icon, color: TColor.gray30),
        ),
      ),
    );
  }
}

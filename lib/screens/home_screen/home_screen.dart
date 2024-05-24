// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mtracker/constants/bottom_nav_widget.dart';
import 'package:mtracker/constants/constant.dart';
import 'package:mtracker/constants/loader_widget.dart';
import 'package:mtracker/models/transaction_model.dart';
import 'package:mtracker/routes/route.dart';
import 'package:mtracker/screens/home_screen/components/history_list.dart';
import 'package:mtracker/screens/home_screen/components/total_amount.dart';
import 'package:mtracker/services/gsheet_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalAmount = 0.0;
  // Map<String, String> totalAmount = {
  //   "Month Spend": "0.0",
  // };
  List<TransactionModel> historyList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> total = await GSheetService.getTotal();
    List<TransactionModel> list = await TransactionModel.getMonthTransaction();
    setState(() {
      totalAmount = double.parse(total["Month Spend"]!);
      historyList = list;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isLoading
          ? null
          : BottomNavWidget(
              onClick: (id) {
                switch (id) {
                  case Buttons.stats:
                    Navigator.pushReplacementNamed(
                      context,
                      MTrackerRoutes.stats,
                    );
                    break;
                  case Buttons.add:
                    Navigator.pushReplacementNamed(
                      context,
                      MTrackerRoutes.add,
                    );
                    break;
                  default:
                }
              },
            ),
      body: _isLoading
          ? const LoaderWidget()
          : Padding(
              padding: const EdgeInsets.all(20),
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  Navigator.pushReplacementNamed(
                    context,
                    MTrackerRoutes.add,
                  );
                },
                builder: MaterialIndicatorDelegate(
                  clipBehavior: Clip.antiAlias,
                  backgroundColor: Colors.deepPurple,
                  builder: (context, controller) {
                    return Transform.scale(
                      scale: controller.value,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "( Drag down to add )",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 8,
                        ),
                      ),
                    ),
                    TotalAmountWidget(total: totalAmount),
                    Row(
                      children: [
                        const Text(
                          "Month History",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () async {
                            _loadData();
                          },
                          child: const Text("Refresh"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Image.asset(Assets.assetsImagesRefreshLoader),
                    Column(
                      children: List.generate(
                          historyList.length,
                          (index) => historyListGenerator(
                              historyList[index], index)).reversed.toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget historyListGenerator(TransactionModel transactionModel, int index) {
    return Dismissible(
      key: Key(transactionModel.id),
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.update,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          Navigator.pushNamed(
            context,
            MTrackerRoutes.update,
            arguments: transactionModel,
          ).then((value) => _loadData());
          return false; // Prevent dismissing for the update action
        }
        return true;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          TransactionModel.deleteTransaction(transactionModel);
          setState(() {
            historyList.removeAt(index);
            if (transactionModel.type == TransactionType.debit.name) {
              totalAmount -= double.parse(transactionModel.amount);
            }
          });
        }
      },
      child: HistoryList(transactionModel: transactionModel),
    );
  }
}

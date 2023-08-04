// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mtracker/constants/assets.dart';
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
  Map<String, String> totalAmount = {
    "Month Spend": "0.0",
  };
  List<TransactionModel> historyList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> total = await GSheetService.getTotal();
    List<TransactionModel> list = await TransactionModel.getMonthTransaction();
    setState(() {
      totalAmount = total;
      historyList = list;
      _isLoading = false;
    });
  }

  Future<void> _navAdd(BuildContext context) async {
    Navigator.pushNamed(context, MTrackerRoutes.add).then(
      (value) => _loadData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isLoading
          ? null
          : FloatingActionButton.small(
              onPressed: () {
                _navAdd(context);
              },
              child: const Icon(Icons.add),
            ),
      body: _isLoading
          ? Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.2,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset(
                    Assets.assetsImagesRefreshLoader,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: CustomRefreshIndicator(
                onRefresh: () async {
                  _navAdd(context);
                },
                builder: MaterialIndicatorDelegate(
                  clipBehavior: Clip.antiAlias,
                  builder: (context, controller) {
                    return Image.asset(
                      Assets.assetsImagesRefreshLoader,
                      fit: BoxFit.cover,
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
                    Column(
                      children: List.generate(
                              historyList.length,
                              (index) =>
                                  historyListGenerator(historyList[index]))
                          .reversed
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget historyListGenerator(TransactionModel transactionModel) {
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
          TransactionModel.deleteTransaction(transactionModel).then(
            (value) => _loadData(),
          );
        }
      },
      child: HistoryList(transactionModel: transactionModel),
    );
  }
}

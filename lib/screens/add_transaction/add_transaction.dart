import 'package:flutter/material.dart';
import 'package:mtracker/constants/bottom_nav_widget.dart';
import 'package:mtracker/constants/bottom_sheet_widget.dart';
import 'package:mtracker/constants/constant.dart';
import 'package:mtracker/constants/loader_widget.dart';

import 'package:mtracker/models/account_model.dart';
import 'package:mtracker/models/transaction_model.dart';
import 'package:mtracker/routes/route.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String category = defaultCatagory;
  TransactionType type = defaultTransactionType;
  String fromAccount = defaultFromAccount;
  String toAccount = defaultToAccount;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  onPressSave() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      DateTime dt = DateTime.now();
      TransactionModel transactionModel = TransactionModel(
        id: 'ID${dt.microsecondsSinceEpoch}',
        category: category,
        note: _noteController.text,
        amount: _amountController.text,
        dateTime: formatDateTime(dt),
        fromAccount: fromAccount,
        toAccount: toAccount,
        type: type.name,
      );
      TransactionModel.addTransaction(transactionModel).then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value) {
          Navigator.pushReplacementNamed(
            context,
            MTrackerRoutes.home,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isLoading
          ? null
          : BottomNavWidget(
              onClick: (id) {
                switch (id) {
                  case Buttons.home:
                    Navigator.pushReplacementNamed(
                      context,
                      MTrackerRoutes.home,
                    );
                    break;
                  case Buttons.stats:
                    Navigator.pushReplacementNamed(
                      context,
                      MTrackerRoutes.stats,
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
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              MTrackerRoutes.home,
                            );
                          },
                          child: const Text("Home"),
                        ),
                        const Spacer()
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          TextFormField(
                            autofocus: true,
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            showCursor: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a amount';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixText: '₹ ',
                              prefixStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: '0.0',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                            ),
                            cursorColor: Colors.transparent,
                            style: const TextStyle(fontSize: 35),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: TransactionType.values
                          .map(
                            (TransactionType typeElement) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      type = typeElement;
                                      if (type == TransactionType.debit) {
                                        toAccount = "🚪.General";
                                        fromAccount = "🏦.HDFC";
                                      }
                                      if (type == TransactionType.credit) {
                                        fromAccount = "🚪.General";
                                        toAccount = "🏦.HDFC";
                                      }
                                      if (type == TransactionType.transfer) {
                                        category = "🔂.Transfer";
                                      }
                                    });
                                  },
                                  color: type == typeElement
                                      ? Colors.purple
                                      : Colors.grey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: FittedBox(
                                      child:
                                          Text(typeElement.name.toUpperCase()),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              AccountModel.getAllAccount().then((accountList) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BottomSheetWidget(
                                      title: "Accounts",
                                      listData: accountList
                                          .map((e) => e.account)
                                          .toList(),
                                      dbLink: AccountModel.dbLink,
                                    );
                                  },
                                ).then((selected) async {
                                  if (selected == "new") {
                                    await launchUrlString(
                                      AccountModel.dbLink,
                                    );
                                  } else {
                                    setState(() {
                                      fromAccount = selected;
                                      if (type == TransactionType.transfer) {
                                        category = "🔂.Transfer";
                                      } else if (type ==
                                          TransactionType.credit) {
                                        category = selected;
                                      }
                                    });
                                  }
                                });
                              });
                            },
                            child: Text(fromAccount),
                          ),
                        ),
                        const Text("to"),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              AccountModel.getAllAccount().then((accountList) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BottomSheetWidget(
                                      title: "Accounts",
                                      listData: accountList
                                          .map((e) => e.account)
                                          .toList(),
                                      dbLink: AccountModel.dbLink,
                                    );
                                  },
                                ).then((selected) async {
                                  if (selected == "new") {
                                    await launchUrlString(
                                      AccountModel.dbLink,
                                    );
                                  } else {
                                    setState(() {
                                      toAccount = selected;
                                      if (type == TransactionType.transfer) {
                                        category = "🔂.Transfer";
                                      } else if (type ==
                                          TransactionType.debit) {
                                        category = selected;
                                      }
                                    });
                                  }
                                });
                              });
                            },
                            child: Text(toAccount),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // TextButton(
                        //   onPressed: type == TransactionType.transfer
                        //       ? null
                        //       : () {
                        //           CategoryModel.getAllCategory()
                        //               .then((categoryList) {
                        //             showModalBottomSheet(
                        //               context: context,
                        //               builder: (BuildContext context) {
                        //                 return BottomSheetWidget(
                        //                   title: "Categories",
                        //                   listData: categoryList
                        //                       .map((e) => e.category)
                        //                       .toList(),
                        //                   dbLink: CategoryModel.dbLink,
                        //                 );
                        //               },
                        //             ).then((selected) async {
                        //               if (selected == "new") {
                        //                 await launchUrlString(
                        //                   AccountModel.dbLink,
                        //                 );
                        //               } else {
                        //                 setState(() {
                        //                   category = selected;
                        //                 });
                        //               }
                        //             });
                        //           });
                        //         },
                        //   child: Text(category),
                        // ),
                        // const Text("-"),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: TextFormField(
                              controller: _noteController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a note';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Note',
                                hintStyle: TextStyle(fontSize: 15),
                                border: InputBorder.none,
                              ),
                              cursorColor: Theme.of(context).primaryColor,
                              style: const TextStyle(fontSize: 15),
                              onEditingComplete: () {
                                onPressSave();
                              },
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onPressSave();
                          },
                          child: const Text("Save"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

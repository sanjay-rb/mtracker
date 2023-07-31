import 'package:flutter/material.dart';
import 'package:mtracker/models/transaction.dart';
import 'package:mtracker/services/gsheet_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateTransaction extends StatefulWidget {
  final TransactionModel transaction;
  const UpdateTransaction({super.key, required this.transaction});

  @override
  State<UpdateTransaction> createState() => _UpdateTransactionState();
}

class _UpdateTransactionState extends State<UpdateTransaction> {
  String category = "🍔.Food";
  int sign = -1;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      category = widget.transaction.category;
      sign = double.parse(widget.transaction.amount).isNegative ? -1 : 1;
      _amountController.text =
          (double.parse(widget.transaction.amount).isNegative
                  ? double.parse(widget.transaction.amount) * -1
                  : double.parse(widget.transaction.amount))
              .toString();
      _noteController.text = widget.transaction.note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Amount",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autofocus: true,
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
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
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                sign = -1;
                              });
                            },
                            color:
                                sign.isNegative ? Colors.purple : Colors.grey,
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "Spend",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                sign = 1;
                              });
                            },
                            color:
                                sign.isNegative ? Colors.grey : Colors.purple,
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "Credit",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          GSheetService.getAllCategory().then(
                            (categoryList) =>
                                _showBottomSheet(context, categoryList),
                          );
                        },
                        child: Text(category),
                      ),
                      const Text("-"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
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
                            cursorColor: Colors.transparent,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              TransactionModel transactionModel =
                                  widget.transaction.copyWith(
                                category: category,
                                amount: (double.parse(_amountController.text) *
                                        sign.toDouble())
                                    .toString(),
                                note: _noteController.text,
                                when: DateTime.now().toIso8601String(),
                              );
                              GSheetService.updateTransaction(transactionModel)
                                  .then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                if (value) {
                                  Navigator.pop(context);
                                }
                              });
                            }
                          },
                          child: const Text("Save"))
                    ],
                  )
                ],
              ),
            ),
    );
  }

  void _showBottomSheet(BuildContext context, List<String> categoryList) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text("Categories"),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: categoryList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < categoryList.length) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            category = categoryList[index];
                          });
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                categoryList[index].split('.')[0],
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                categoryList[index].split('.')[1],
                                style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.fade,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () async {
                          await launchUrlString(
                              GSheetService.categorySheetLink);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "➕",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.fade,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

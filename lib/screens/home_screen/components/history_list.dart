import 'package:flutter/material.dart';
import 'package:mtracker/constants/constant.dart';
import 'package:mtracker/models/transaction_model.dart';

class HistoryList extends StatelessWidget {
  final TransactionModel transactionModel;

  const HistoryList({
    Key? key,
    required this.transactionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Text(
                      transactionModel.category.split('.')[0],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionModel.category.split('.')[1],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        transactionModel.note,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${transactionModel.fromAccount.split('.')[1]} to ${transactionModel.toAccount.split('.')[1]}",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Text(
                        "₹ ${formatCurrency(double.parse(transactionModel.amount))}",
                        style: TextStyle(
                          color: transactionModel.type ==
                                  TransactionType.credit.name
                              ? Colors.green
                              : transactionModel.type ==
                                      TransactionType.debit.name
                                  ? Colors.red
                                  : Colors.blue,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formatDateTimeInWords(
                          formatDBDateTime(transactionModel.dateTime),
                        ),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

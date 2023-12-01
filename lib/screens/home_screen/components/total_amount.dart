import 'package:flutter/material.dart';
import 'package:mtracker/constants/constant.dart';
import 'package:mtracker/models/account_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TotalAmountWidget extends StatelessWidget {
  const TotalAmountWidget({
    super.key,
    required this.total,
  });
  final double total;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Spend this Month",
            style: TextStyle(color: Colors.grey),
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "₹ ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                  ),
                ),
                TextSpan(
                  text: formatCurrency(total).split('.')[0],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
                TextSpan(
                  text: ".${formatCurrency(total).split('.')[1]}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              await launchUrlString(AccountModel.dbLink);
            },
            child: const Text("Amount Balance"),
          ),
        ],
      )),
    );
  }
}

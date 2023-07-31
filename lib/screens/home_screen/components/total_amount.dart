import 'package:flutter/material.dart';
import 'package:mtracker/constants/constant.dart';

class TotalAmountWidget extends StatelessWidget {
  const TotalAmountWidget({
    super.key,
    required this.total,
  });
  final Map<String, String> total;

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
                  text: formatCurrency(double.parse(total['Month Spend']!))
                      .split('.')[0],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
                TextSpan(
                  text:
                      ".${formatCurrency(double.parse(total['Month Spend']!)).split('.')[1]}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            endIndent: MediaQuery.of(context).size.width * 0.1,
            indent: MediaQuery.of(context).size.width * 0.1,
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "₹ ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: formatCurrency(double.parse(total['Total Balance']!))
                      .split('.')[0],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                TextSpan(
                  text:
                      ".${formatCurrency(double.parse(total['Total Balance']!)).split('.')[1]}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "(Total Balance)",
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      )),
    );
  }
}

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
        ],
      )),
    );
  }
}

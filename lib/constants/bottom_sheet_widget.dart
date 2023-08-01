// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  final String title;
  final List<String> listData;
  final String dbLink;
  const BottomSheetWidget({
    Key? key,
    required this.title,
    required this.listData,
    required this.dbLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(title),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: listData.length + 1,
              itemBuilder: (context, index) {
                if (index < listData.length) {
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context, listData[index]);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            listData[index].split('.')[0],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            listData[index].split('.')[1],
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
                      Navigator.pop(context, 'new');
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
  }
}

class Transaction {
  String? id;
  int? amount;
  String? type;
  String? rule;
  DateTime? date;
  String? note;
  String? fromBucket;
  String? toBucket;

  Transaction(
      {this.id,
      this.amount,
      this.type,
      this.rule,
      this.date,
      this.note,
      this.fromBucket,
      this.toBucket});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    type = json['type'];
    rule = json['rule'];
    date = json['date'];
    note = json['note'];
    fromBucket = json['from_bucket'];
    toBucket = json['to_bucket'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['type'] = type;
    data['rule'] = rule;
    data['date'] = date;
    data['note'] = note;
    data['from_bucket'] = fromBucket;
    data['to_bucket'] = toBucket;
    return data;
  }
}

class TransactionRecord {
  static const tableName = "transaction_record";

  String? id;
  double? amount;
  String? type;
  String? rule;
  String? dateTime;
  String? note;
  String? account;
  String? category;

  TransactionRecord(
      {this.id,
      this.amount,
      this.type,
      this.rule,
      this.dateTime,
      this.note,
      this.account,
      this.category});

  TransactionRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    type = json['type'];
    rule = json['rule'];
    dateTime = json['date_time'];
    note = json['note'];
    account = json['account'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['type'] = type;
    data['rule'] = rule;
    data['date_time'] = dateTime;
    data['note'] = note;
    data['account'] = account;
    data['category'] = category;
    return data;
  }
}

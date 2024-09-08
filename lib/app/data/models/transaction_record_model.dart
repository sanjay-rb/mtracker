class TransactionRecord {
  static const TABLE_NAME = 'transaction_record';

  String? id;
  String? type;
  double? amount;
  String? note;
  String? sourceAccount;
  String? targetAccount;
  String? category;
  String? rule;
  String? dateTime;

  TransactionRecord(
      {this.id,
      this.type,
      this.amount,
      this.note,
      this.sourceAccount,
      this.targetAccount,
      this.category,
      this.rule,
      this.dateTime});

  TransactionRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    amount = json['amount'];
    note = json['note'];
    sourceAccount = json['source_account'];
    targetAccount = json['target_account'];
    category = json['category'];
    rule = json['rule'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['amount'] = amount;
    data['note'] = note;
    data['source_account'] = sourceAccount;
    data['target_account'] = targetAccount;
    data['category'] = category;
    data['rule'] = rule;
    data['date_time'] = dateTime;
    return data;
  }
}

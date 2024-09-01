class Account {
  static const tableName = "account";
  String? name;
  String? emoji;
  double? balance;

  Account({this.name, this.emoji, this.balance});

  Account.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    emoji = json['emoji'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['emoji'] = emoji;
    data['balance'] = balance;
    return data;
  }
}

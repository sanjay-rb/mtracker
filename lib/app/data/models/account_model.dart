class Account {
  static const tableName = "account";
  String? id;
  String? name;
  String? emoji;
  double? balance;

  Account({this.id, this.name, this.emoji, this.balance});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emoji'] = emoji;
    data['balance'] = balance;
    return data;
  }
}

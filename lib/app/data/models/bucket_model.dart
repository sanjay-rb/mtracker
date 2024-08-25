class Bucket {
  String? name;
  String? emoji;
  double? balance;
  String? label;

  Bucket({this.name, this.emoji, this.balance, this.label});

  Bucket.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    emoji = json['emoji'];
    balance = json['balance'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['emoji'] = emoji;
    data['balance'] = balance;
    data['label'] = label;
    return data;
  }
}

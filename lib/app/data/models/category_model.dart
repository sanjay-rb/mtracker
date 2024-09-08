class Category {
  static const TABLE_NAME = "category";

  String? id;
  String? name;
  String? emoji;
  String? rule;
  String? type;

  Category({this.id, this.name, this.emoji, this.rule, this.type});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    rule = json['rule'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emoji'] = emoji;
    data['rule'] = rule;
    data['type'] = type;
    return data;
  }
}

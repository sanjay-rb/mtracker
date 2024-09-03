class Category {
  static const tableName = "category";
  String? id;
  String? name;
  String? emoji;
  String? defaultRuleBucket;
  String? defaultRecordType;

  Category(
      {this.id,
      this.name,
      this.emoji,
      this.defaultRuleBucket,
      this.defaultRecordType});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    defaultRuleBucket = json['default_rule_bucket'];
    defaultRecordType = json['default_record_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emoji'] = emoji;
    data['default_rule_bucket'] = defaultRuleBucket;
    data['default_record_type'] = defaultRecordType;
    return data;
  }
}

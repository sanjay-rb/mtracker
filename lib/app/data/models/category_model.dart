class Category {
  static const tableName = 'category';
  String? name;
  String? emoji;
  String? defaultRuleBucket;
  String? defaultRecordType;

  Category(
      {this.name, this.emoji, this.defaultRuleBucket, this.defaultRecordType});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    emoji = json['emoji'];
    defaultRuleBucket = json['default_rule_bucket'];
    defaultRecordType = json['default_record_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['emoji'] = emoji;
    data['default_rule_bucket'] = defaultRuleBucket;
    data['default_record_type'] = defaultRecordType;
    return data;
  }
}

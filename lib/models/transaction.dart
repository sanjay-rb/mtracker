// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionModel {
  static const idKey = 'id';
  static const categoryKey = 'category';
  static const noteKey = 'note';
  static const amountKey = 'amount';
  static const whenKey = 'when';

  static const getKeys = [idKey, categoryKey, noteKey, amountKey, whenKey];

  String id;
  String category;
  String note;
  String amount;
  String when;
  TransactionModel({
    required this.id,
    required this.category,
    required this.note,
    required this.amount,
    required this.when,
  });

  TransactionModel copyWith({
    String? id,
    String? category,
    String? note,
    String? amount,
    String? when,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      category: category ?? this.category,
      note: note ?? this.note,
      amount: amount ?? this.amount,
      when: when ?? this.when,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'note': note,
      'amount': amount,
      'when': when,
    };
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(id: $id, category: $category, note: $note, amount: $amount, when: $when)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.category == category &&
        other.note == note &&
        other.amount == amount &&
        other.when == when;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        note.hashCode ^
        amount.hashCode ^
        when.hashCode;
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      category: map['category'] as String,
      note: map['note'] as String,
      amount: map['amount'] as String,
      when: map['when'] as String,
    );
  }
}

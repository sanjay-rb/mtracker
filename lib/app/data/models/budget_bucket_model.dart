class BudgetBucket {
  static const tableName = "budget_bucket";
  String? id;
  String? yearMonth;
  double? totalCredit;
  double? needs;
  double? wants;
  double? saves;
  double? totalDebit;

  BudgetBucket(
      {this.id,
      this.yearMonth,
      this.totalCredit,
      this.needs,
      this.wants,
      this.saves,
      this.totalDebit});

  BudgetBucket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    yearMonth = json['year_month'];
    totalCredit = json['total_credit'];
    needs = json['needs'];
    wants = json['wants'];
    saves = json['saves'];
    totalDebit = json['total_debit'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['year_month'] = yearMonth;
    data['total_credit'] = totalCredit;
    data['needs'] = needs;
    data['wants'] = wants;
    data['saves'] = saves;
    data['total_debit'] = totalDebit;
    return data;
  }
}

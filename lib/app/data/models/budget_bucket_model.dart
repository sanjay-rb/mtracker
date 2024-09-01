class BudgetBucket {
  String? yearMonth;
  double? totalCredit;
  double? needs;
  double? wants;
  double? saves;
  double? totalDebit;

  BudgetBucket(
      {this.yearMonth,
      this.totalCredit,
      this.needs,
      this.wants,
      this.saves,
      this.totalDebit});

  BudgetBucket.fromJson(Map<String, dynamic> json) {
    yearMonth = json['year_month'];
    totalCredit = json['total_credit'];
    needs = json['needs'];
    wants = json['wants'];
    saves = json['saves'];
    totalDebit = json['total_debit'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['year_month'] = yearMonth;
    data['total_credit'] = totalCredit;
    data['needs'] = needs;
    data['wants'] = wants;
    data['saves'] = saves;
    data['total_debit'] = totalDebit;
    return data;
  }
}

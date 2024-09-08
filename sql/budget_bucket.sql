CREATE TABLE [budget_bucket] (
  [id] TEXT,
  [year_month] TEXT,
  [total_credit] REAL,
  [needs] REAL,
  [wants] REAL,
  [saves] REAL,
  [total_debit] REAL
);
INSERT INTO [budget_bucket] (
    [id],
    [year_month],
    [total_credit],
    [needs],
    [wants],
    [saves],
    [total_debit]
  )
VALUES ('BB20240903104201', 'YYYYMM', 0, 0, 0, 0, 0);
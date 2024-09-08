CREATE TABLE [category] (
  [id] TEXT,
  [name] TEXT,
  [emoji] TEXT,
  [rule] TEXT NULL,
  [type] TEXT
);
INSERT INTO [category] ([id], [name], [emoji], [rule], [type])
VALUES (
    'C20240903104201',
    'Salary',
    '💵',
    'NR',
    'CREDIT'
  ),
  (
    'C20240903104202',
    'Food',
    '🍔',
    'WANTS',
    'DEBIT'
  ),
  (
    'C20240903104203',
    'Grocery',
    '🛒',
    'NEEDS',
    'DEBIT'
  ),
  (
    'C20240903104204',
    'Gold',
    '💰',
    'SAVES',
    'DEBIT'
  ),
  (
    'C20240903104205',
    'Stocks',
    '📈',
    'SAVES',
    'DEBIT'
  );
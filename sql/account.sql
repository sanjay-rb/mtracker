CREATE TABLE [account] (
  [id] TEXT,
  [name] TEXT,
  [emoji] TEXT,
  [balance] REAL
);
INSERT INTO [account] ([id], [name], [emoji], [balance])
VALUES ('A20240903104201', 'Primary Account', '🏦', 0),
  ('A20240903104202', 'Secondary Account', '🏦', 0),
  ('A20240903104203', 'Wallet', '👛', 0),
  (
    'A20240903104204',
    'Primary Credit Card',
    '💳',
    0
  ),
  (
    'A20240903104205',
    'Secondary Credit Card',
    '💳',
    0
  );
CREATE TABLE [transaction_record] (
    [id] TEXT,
    [amount] REAL,
    [note] TEXT,
    [category] TEXT,
    [date_time] TEXT
);
INSERT INTO [transaction_record] (
        [id],
        [amount],
        [note],
        [category],
        [date_time]
    )
VALUES (
        'R20240903104201',
        'DEBIT',
        10,
        'Food',
        'A20240903104201',
        'A20240903104201',
        'C20240903104202',
        'NEEDS',
        '2024-08-24 21:08:32'
    );
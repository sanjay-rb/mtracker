CREATE TABLE [transaction_record] (
    [id] TEXT,
    [type] TEXT,
    [amount] REAL,
    [note] TEXT,
    [source_account] TEXT,
    [target_account] TEXT,
    [category] TEXT,
    [rule] TEXT,
    [date_time] TEXT
);
INSERT INTO [transaction_record] (
        [id],
        [type],
        [amount],
        [note],
        [source_account],
        [target_account],
        [category],
        [rule],
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
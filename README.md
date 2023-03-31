# ₹ Tracker : My personal money traker app 

# Database Desgin
1. **Accounts collection**: 

    This collection would store information about the user's financial accounts, such as their bank account or credit card information. Each account document could have the following fields:
    - *account_id*: Unique identifier for the account (string)
    - *name*: Account name (string)
    - *type*: Account type (string)
    - *balance*: Current balance in the account (float)
    - *created_at*: Date and time the account was created (timestamp)
    - *updated_at*: Date and time the account was last updated (timestamp)

1. **Transactions collection**: 
    
    This collection would store information about all the transactions made by the user, including the date, time, amount, category, and account used for the transaction. Each transaction document could have the following fields:
    - *transaction_id*: Unique identifier for the transaction (string)
    - *account_id*: Account ID associated with the transaction (string)
    - *category*: Category of the transaction (string)
    - *amount*: Amount of the transaction (float)
    - *date*: Date of the transaction (timestamp)
    - *created_at*: Date and time the transaction was created (timestamp)
    - *updated_at*: Date and time the transaction was last updated (timestamp)

1. **Categories collection**: 
    
    This collection would store information about the categories used to classify transactions, such as food, transportation, entertainment, etc. Each category document could have the following fields:
    - *category_id*: Unique identifier for the category (string)
    - *name*: Name of the category (string)
    - *created_at*: Date and time the category was created (timestamp)
    - *updated_at*: Date and time the category was last updated (timestamp)

**The relationships between these collections could be as follows:**

- Each account can have multiple transactions, and each transaction belongs to only one account.
- Each category can be used for multiple transactions, and each transaction belongs to only one category.
/* Assignment C++: 2
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#include "Account.h"

// The Account class represents a basic bank account
// It manages account information and basic transactions

Account::Account(const std::string& number, const std::string& holder, double initialBalance)
    : accountNumber(number), accountHolder(holder), balance(initialBalance) {}

// Deposit method: Adds money to the account
// Throws an exception if the amount is not positive
void Account::deposit(double amount) {
    if (amount < 0) {
        throw "Deposit amount must be positive.";
    }
    balance += amount;
}

// Withdraw method: Removes money from the account
// Throws exceptions for invalid amount or insufficient funds
void Account::withdraw(double amount) {
    if (amount <= 0) {
        throw "Withdrawal amount must be positive.";
    }
    if (amount > balance) {
        throw "Insufficient funds.";
    }
    balance -= amount;
}

// Returns the current balance of the account
double Account::getBalance() const {
    return balance;
}

// Prints account details to the provided output stream
void Account::print(std::ostream& os) const {
    os << "Account Number: " << accountNumber << std::endl;
    os << "Account Holder: " << accountHolder << std::endl;
    os << "Balance: $" << balance << std::endl;
}

// Overloaded << operator for easy printing of account details
std::ostream& operator<<(std::ostream& os, const Account& account) {
    account.print(os);
    return os;
}

// Returns the account holder's name
std::string Account::getHolder(){
    return accountHolder;
}

// Returns the account number
std::string Account::getNumber(){
    return accountNumber;
}
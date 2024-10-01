/* Assignment C++: 2
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/ 
#include "CheckingAccount.h"

/**
 * Constructor for CheckingAccount.
 * @param number Account number.
 * @param holder Name of the account holder.
 * @param initialBalance Initial balance of the account.
 * @param overdraft Overdraft limit.
 */
CheckingAccount::CheckingAccount(const std::string& number, const std::string& holder, double initialBalance, double overdraft)
    : Account(number, holder, initialBalance), overdraftLimit(overdraft) {
		if (overdraft < 0){
			throw "Overdraft must be positive.";
		}
	}

/**
 * Deposits an amount into the account.
 * @param amount Amount to deposit.
 */
void CheckingAccount::deposit(double amount) {
    if (amount < 0) {
        throw "Deposit amount must be positive.";
    }
    balance += amount;
}

/**
 * Withdraws an amount from the account.
 * @param amount Amount to withdraw.
 */
void CheckingAccount::withdraw(double amount) {
    if (amount < 0) {
        throw "Withdrawal amount must be positive.";
    }
	// Check if withdrawal amount exceeds balance plus overdraft limit
    if (amount > balance + overdraftLimit) {
        throw "Withdrawal amount exceeds overdraft limit.";
    }
    balance -= amount;
}

/**
 * Prints the account details.
 * @param os Output stream to print to.
 */
void CheckingAccount::print(std::ostream& os) const {
 //   os << "Checking Account" << std::endl;
    Account::print(os);
 //   os << "Overdraft Limit: $" << overdraftLimit << std::endl;
}

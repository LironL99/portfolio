/* Assignment C++: 2
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/ 

#ifndef CHECKINGACCOUNT_H
#define CHECKINGACCOUNT_H

#include "Account.h"

/**
 * Class representing a checking account with overdraft protection.
 */
class CheckingAccount : public Account {
private:
    double overdraftLimit; // Overdraft limit

public:
    /**
     * Constructor for CheckingAccount.
     * @param number Account number.
     * @param holder Name of the account holder.
     * @param initialBalance Initial balance of the account.
     * @param overdraft Overdraft limit.
     */
    CheckingAccount(const std::string& number, const std::string& holder, double initialBalance, double overdraft);

    /**
     * Deposits an amount into the account.
     * @param amount Amount to deposit.
     */
    void deposit(double amount) override;

    /**
     * Withdraws an amount from the account.
     * @param amount Amount to withdraw.
     */
    void withdraw(double amount) override;

    /**
     * Prints the account details.
     * @param os Output stream to print to.
     */
    void print(std::ostream& os) const override;
};

#endif

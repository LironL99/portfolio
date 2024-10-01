/* Assignment C++: 2
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#ifndef SAVINGSACCOUNT_H
#define SAVINGSACCOUNT_H

#include "Account.h"
#include <chrono>

/**
 * Class representing a savings account with interest calculation.
 * Extends the basic Account class with interest calculation functionality
 */
class SavingsAccount : public Account {
private:
    double annualInterestRate; // Annual interest rate for the account
    std::chrono::steady_clock::time_point lastTransactionTime; // Time of the last transaction

public:
    /**
     * Constructor for SavingsAccount.
     * Initializes a new savings account with the given details and interest rate
     * @param number Account number.
     * @param holder Name of the account holder.
     * @param initialBalance Initial balance of the account.
     * @param annualRate Annual interest rate.
     */
    SavingsAccount(const std::string& number, const std::string& holder, double initialBalance, double annualRate);

    /**
     * Deposits an amount into the account after updating interest.
     * Overrides the base class method to include interest calculation
     * @param amount Amount to deposit.
     */
    void deposit(double amount) override;

    /**
     * Withdraws an amount from the account after updating interest.
     * Overrides the base class method to include interest calculation
     * @param amount Amount to withdraw.
     */
    void withdraw(double amount) override;

    /**
     * Calculates and updates the interest based on the time elapsed.
     * Uses compound interest formula to update the balance
     */
    void calculateInterest();

    /**
     * Prints the account details.
     * Overrides the base class method to include savings account specific information
     * @param os Output stream to print to.
     */
    void print(std::ostream& os) const override;
};

#endif
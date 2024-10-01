/* Assignment C++: 2
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/ 

#include "SavingsAccount.h"
#include <cmath> // Include for pow function
#include <iostream>

/**
 * Constructor for SavingsAccount.
 * @param number Account number.
 * @param holder Name of the account holder.
 * @param initialBalance Initial balance of the account.
 * @param annualRate Annual interest rate.
 */
SavingsAccount::SavingsAccount(const std::string& number, const std::string& holder, double initialBalance, double annualRate)
    : Account(number, holder, initialBalance), annualInterestRate(annualRate), lastTransactionTime(std::chrono::steady_clock::now()) {}

/**
 * Deposits an amount into the account after updating interest.
 * @param amount Amount to deposit.
 */
void SavingsAccount::deposit(double amount) {
    calculateInterest(); // Update interest before depositing
    Account::deposit(amount);
}

/**
 * Withdraws an amount from the account after updating interest.
 * @param amount Amount to withdraw.
 */
void SavingsAccount::withdraw(double amount) {
    calculateInterest(); // Update interest before withdrawing
    Account::withdraw(amount);
}

/**
 * Calculates and updates the interest based on the time elapsed.
 */
void SavingsAccount::calculateInterest() {
    auto now = std::chrono::steady_clock::now(); // Get current time
    std::chrono::duration<double> elapsed_seconds = now - lastTransactionTime; // Calculate elapsed time in seconds
    double years = elapsed_seconds.count(); // Each real second is considered a year
	std::cout << std::endl << std::endl;
    balance *= std::pow(1 + annualInterestRate, years); // Apply compound interest formula
    lastTransactionTime = now; // Update the last transaction time
}

/**
 * Prints the account details.
 * @param os Output stream to print to.
 */
void SavingsAccount::print(std::ostream& os) const {
    Account::print(os);
}

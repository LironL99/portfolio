/* Assignment C++: 2
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#ifndef ACCOUNT_H
#define ACCOUNT_H

#include <iostream>
#include <string>

// The Account class defines the interface for basic bank account operations
// It serves as a base class for more specific account types
class Account {
protected:
    std::string accountNumber;
    std::string accountHolder;
    double balance;

public:
    // Constructor to initialize account details
    Account(const std::string& number, const std::string& holder, double initialBalance);
    virtual ~Account() {}

    // Virtual methods for deposit and withdrawal, allowing for polymorphic behavior
    virtual void deposit(double amount);
    virtual void withdraw(double amount);

    // Getter for the account balance
    virtual double getBalance() const;

    // Virtual print method for displaying account details
    virtual void print(std::ostream& os) const;
    
    // Overloaded << operator for easy printing
    friend std::ostream& operator<<(std::ostream& os, const Account& account);
    
    // Getters for account holder and number
    std::string getHolder();
    std::string getNumber();
};

#endif
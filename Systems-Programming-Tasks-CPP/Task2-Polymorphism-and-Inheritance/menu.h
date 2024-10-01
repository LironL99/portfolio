/* Assignment C++: 2
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#ifndef MENU_H
#define MENU_H

#include "Array.h"
#include "Account.h"
#include "SavingsAccount.h"
#include "CheckingAccount.h"

// The Menu class provides a user interface for managing bank accounts
// It handles user input and performs operations on the accounts
class Menu {
private:
    Array<Account*> accounts; // Array of account pointers to store different account types

public:
    void showMenu();        // Displays the main menu and handles user input
    void addAccount();      // Adds a new account based on user input
    void deposit();         // Deposits an amount into an account based on user input
    void withdraw();        // Withdraws an amount from an account based on user input
    void deleteAccount();   // Deletes an account based on user input
    void printAccounts();   // Prints the details of all accounts
};

#endif

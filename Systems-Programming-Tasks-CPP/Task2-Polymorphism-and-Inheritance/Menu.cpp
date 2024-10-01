/* Assignment C++: 2
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#include "Menu.h"
#include <iostream>

// The Menu class provides a user interface for managing bank accounts
// It allows users to perform various operations on accounts

// Displays the main menu and handles user input
void Menu::showMenu() {
    int choice;
    do {
        // Display menu options
        std::cout << "====== Main Menu ======\n";
        std::cout << "1 - Add a new account\n";
        std::cout << "2 - Deposit (index, amount)\n";
        std::cout << "3 - Withdraw (index, amount)\n";
        std::cout << "4 - Delete an account (index)\n";
        std::cout << "5 - Print details of all accounts\n";
        std::cout << "6 - Exit\n";
        std::cout << "=======================================\n";
        std::cout << "Enter your choice: ";
        std::cin >> choice;

        // Handle user's choice
        try {
            switch (choice) {
                case 1:
                    addAccount();
                    break;
                case 2:
                    deposit();
                    break;
                case 3:
                    withdraw();
                    break;
                case 4:
                    deleteAccount();
                    break;
                case 5:
                    printAccounts();
                    break;
                case 6:
                    std::cout << "Exiting...\n";
                    break;
                default:
                    std::cout << "Invalid choice. Please try again.\n";
            }
        } catch (const char* msg) {
            std::cerr << "Error: " << msg << std::endl;
        }
    } while (choice != 6);
}

// Adds a new account based on user input
void Menu::addAccount() {
    std::string number, holder, type;
    double initialBalance, rate, overdraft;

    // Gather account information from user
    std::cout << "Enter account number: ";
    std::cin >> number;
    std::cout << "Enter account holder name: ";
    std::cin >> holder;
    std::cout << "Enter initial balance: ";
    std::cin >> initialBalance;
    std::cout << "Enter account type (S for Savings, C for Checking): ";
    std::cin >> type;

    try {
        // Create appropriate account type based on user input
        if (type == "S" || type == "s") {
            std::cout << "Enter annual interest rate: ";
            std::cin >> rate;
            accounts.insert(new SavingsAccount(number, holder, initialBalance, rate));
            std::cout << "Account added successfully.\n";
        } else if (type == "C" || type == "c") {
            std::cout << "Enter overdraft limit: ";
            std::cin >> overdraft;
            accounts.insert(new CheckingAccount(number, holder, initialBalance, overdraft));
            std::cout << "Account added successfully.\n";
        } else {
            throw "Invalid account type.";
        }
    } catch (const char* msg) {
        std::cerr << "Error: " << msg << std::endl;
    }
}

// Deposits an amount into an account based on user input
void Menu::deposit() {
    int index;
    double amount;
    std::cout << "Enter account index: ";
    std::cin >> index;
    std::cout << "Enter deposit amount: ";
    std::cin >> amount;

    try {
        // Validate index and perform deposit
        if (index < 0 || index >= accounts.getSize()) {
            throw "Index out of range.";
        }
        accounts[index]->deposit(amount);
        // Display updated account information
        std::cout << "Account Number: " << accounts[index]->getNumber() << std::endl;
        std::cout << "Account Holder: " << accounts[index]->getHolder() << std::endl;
        std::cout << "Balance: $" << accounts[index]->getBalance() << std::endl;
    } catch (const char* msg) {
        std::cerr << "Error: " << msg << std::endl;
    }
}

// Withdraws an amount from an account based on user input
void Menu::withdraw() {
    int index;
    double amount;
    std::cout << "Enter account index: ";
    std::cin >> index;
    std::cout << "Enter withdrawal amount: ";
    std::cin >> amount;

    try {
        // Validate index and perform withdrawal
        if (index < 0 || index >= accounts.getSize()) {
            throw "Index out of range.";
        }
        accounts[index]->withdraw(amount);
        // Display updated account information
        std::cout << "Withdrawn $" << amount << std::endl;
        std::cout << "Account Number: " << accounts[index]->getNumber() << std::endl;
        std::cout << "Account Holder: " << accounts[index]->getHolder() << std::endl;
        std::cout << "Balance: $" << accounts[index]->getBalance() << std::endl;
    } catch (const char* msg) {
        std::cerr << "Error: " << msg << std::endl;
    }
}

// Deletes an account based on user input
void Menu::deleteAccount() {
    int index;
    std::cout << "Enter account index to delete: ";
    std::cin >> index;

    try {
        // Validate index and remove account
        if (index < 0 || index >= accounts.getSize()) {
            throw "Index out of range.";
        }
        delete accounts.remove(index);
        std::cout << "Account deleted successfully.\n";
    } catch (const char* msg) {
        std::cerr << "Error: " << msg << std::endl;
    }
}

// Prints the details of all accounts
void Menu::printAccounts() {
    std::cout << "====== Account Details ======\n";
    for (int i = 0; i < accounts.getSize(); i++) {
        // Calculate interest for savings accounts before printing
        if (SavingsAccount* sa = dynamic_cast<SavingsAccount*>(accounts[i])) {
            sa->calculateInterest();
        }
        std::cout << "Array index " << i << ":\n";
        std::cout << *accounts[i];
    }
}
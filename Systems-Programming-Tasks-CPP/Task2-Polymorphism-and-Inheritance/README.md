# Task 2: Inheritance, Polymorphism, and Exception Handling

### Task Overview
This task focuses on implementing a banking system using classes that demonstrate inheritance, polymorphism, and exception handling in C++. The task involves creating an abstract data type (ADT) for a dynamic stack, implementing bank account classes, and managing user interactions through a menu system.

### Part A: Implementing Stack with Templates
- **Class: Array<T>**
  - A template class representing a dynamic array with methods to insert and remove elements, get the size, and perform input/output operations using overloaded operators.
  - Private members include the number of elements and a pointer to the first element.
  
- **Methods:**
  - `insert`: Adds an element to the end of the array.
  - `remove`: Deletes an element at a specified index, returning the removed value.
  - `getSize`: Returns the current size of the array.
  - Overloaded operators for printing and accessing elements.

### Part B: Banking System Implementation
- **Class: Account**
  - Represents a bank account with fields for account number, holder name, and balance.
  - Abstract methods for deposit and withdraw operations, along with methods to retrieve balance and print account details.

- **Class: SavingsAccount**
  - Inherits from `Account` and includes additional fields for annual interest rate and last transaction time.
  - Implements methods to deposit and withdraw funds, updating interest as necessary.

- **Class: CheckingAccount**
  - Inherits from `Account` and includes a field for overdraft limit.
  - Implements methods for depositing and withdrawing funds.

### Part C: Menu Management
- **Class: Menu**
  - Manages user interactions by presenting options for account management, including adding accounts, depositing and withdrawing funds, and printing account details.
  - Maintains an array of `Account*` to handle multiple accounts and operations.

### Exception Handling
- Input values are validated to ensure they fall within appropriate ranges.
- Exceptions are thrown for invalid operations, and appropriate messages are displayed to the user, allowing for re-input.

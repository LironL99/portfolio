/* Assignment C++: 1
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#ifndef STACK_H
#define STACK_H

#include "StackNode.h"
#include <iostream>
#include <climits>

class Stack {
private:
    StackNode* top;  // Pointer to the top node of the stack.

public:
    Stack();  // Constructor to initialize the stack.
    ~Stack();  // Destructor to clean up the stack.

    void push(int value);  // Pushes a value onto the stack.
    void pop();  // Pops the top value from the stack.
    bool isEmpty() const;  // Checks if the stack is empty.
    int peek() const;  // Returns the top value without popping it.

    Stack operator+(const Stack& other) const;  // Concatenates two stacks.
    Stack operator+(int value) const;  // Adds a value to the stack.
    friend Stack operator+(int value, const Stack& stack);  // Adds a value to the stack (friend function).
    Stack& operator+=(int value);  // Adds a value to the stack (in-place).
    bool operator==(const Stack& other) const;  // Checks if two stacks are equal.
    friend std::ostream& operator<<(std::ostream& os, const Stack& stack);  // Outputs the stack to a stream.
};

#endif // STACK_H

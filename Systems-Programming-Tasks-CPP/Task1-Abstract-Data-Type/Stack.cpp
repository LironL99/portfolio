/* Assignment C++: 1
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#include "Stack.h"

// Constructor to initialize the stack.
Stack::Stack() : top(nullptr) {}

// Destructor to clean up the stack.
Stack::~Stack() {
    while (!isEmpty()) {
        pop();
    }
}

// Pushes a value onto the stack.
void Stack::push(int value) {
    StackNode* newNode = new StackNode(value);
    newNode->setNext(top);
    top = newNode;
}

// Pops the top value from the stack.
void Stack::pop() {
    if (isEmpty()) {
        std::cout << "Stack is empty" << std::endl;
        return;
    }
    StackNode* temp = top;
    top = top->getNext();
    delete temp;
}

// Checks if the stack is empty.
bool Stack::isEmpty() const {
    return top == nullptr;
}

// Returns the top value without popping it.
int Stack::peek() const {
    if (isEmpty()) {
        return INT_MIN;
    }
    return top->getData();
}

// Concatenates two stacks.
Stack Stack::operator+(const Stack& other) const {
    Stack result;
    Stack temp1 = *this;
    Stack temp2 = other;

    while (!temp1.isEmpty()) {
        result.push(temp1.peek());
        temp1.pop();
    }
    while (!temp2.isEmpty()) {
        result.push(temp2.peek());
        temp2.pop();
    }

    Stack reversedResult;
    while (!result.isEmpty()) {
        reversedResult.push(result.peek());
        result.pop();
    }

    return reversedResult;
}

// Adds a value to the stack.
Stack Stack::operator+(int value) const {
    Stack result = *this;
    result.push(value);
    return result;
}

// Adds a value to the stack (friend function).
Stack operator+(int value, const Stack& stack) {
    Stack result;
    StackNode* current = stack.top;

    while (current != nullptr) {
        result.push(current->getData());
        current = current->getNext();
    }

    result.push(value);

    Stack reversedResult;
    while (!result.isEmpty()) {
        reversedResult.push(result.peek());
        result.pop();
    }

    return reversedResult;
}

// Adds a value to the stack (in-place).
Stack& Stack::operator+=(int value) {
    push(value);
    return *this;
}

// Checks if two stacks are equal.
bool Stack::operator==(const Stack& other) const {
    StackNode* temp1 = top;
    StackNode* temp2 = other.top;

    while (temp1 != nullptr && temp2 != nullptr) {
        if (temp1->getData() != temp2->getData()) {
            return false;
        }
        temp1 = temp1->getNext();
        temp2 = temp2->getNext();
    }

    return (temp1 == nullptr && temp2 == nullptr);
}

// Outputs the stack to a stream.
std::ostream& operator<<(std::ostream& os, const Stack& stack) {
    StackNode* current = stack.top;
    int index = 1;

	if (current == nullptr){
		std::cout << "The stack is empty" << std::endl;
	}
	else{
		os << "Stack elements:" << std::endl;
	};
    while (current != nullptr) {
        os << index << ". " << current->getData() << std::endl;
        current = current->getNext();
        index++;
    }
    return os;
}

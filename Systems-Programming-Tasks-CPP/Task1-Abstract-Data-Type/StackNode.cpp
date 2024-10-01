/* Assignment C++: 1
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#include "StackNode.h"

// Constructor to initialize the node with data and set the next pointer to nullptr.
StackNode::StackNode(int data) : data(data), next(nullptr) {}

// Returns the data stored in the node.
int StackNode::getData() const {
    return data;
}

// Returns the next node in the stack.
StackNode* StackNode::getNext() const {
    return next;
}

// Sets the next node in the stack.
void StackNode::setNext(StackNode* nextNode) {
    next = nextNode;
}

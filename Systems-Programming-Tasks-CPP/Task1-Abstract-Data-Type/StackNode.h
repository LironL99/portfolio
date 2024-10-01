/* Assignment C++: 1
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#ifndef STACKNODE_H
#define STACKNODE_H

class StackNode {
private:
    int data;            // The data stored in the node.
    StackNode* next;     // Pointer to the next node in the stack.

public:
    StackNode(int data); // Constructor to initialize the node with data.
    int getData() const; // Returns the data stored in the node.
    StackNode* getNext() const; // Returns the next node in the stack.
    void setNext(StackNode* nextNode); // Sets the next node in the stack.
};

#endif // STACKNODE_H

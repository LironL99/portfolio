/* Assignment C++: 1
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#ifndef MYQUEUE_H
#define MYQUEUE_H

#include <vector>

// MyQueue class implements a queue using a vector
class MyQueue {
private:
    std::vector<int> queue;
    int maxQ;

public:
    // Constructor initializes the queue with a maximum size
    MyQueue(int maxQ) : maxQ(maxQ) {}

    // Adds an element to the back of the queue
    bool enQueue(int val);

    // Removes an element from the front of the queue
    bool deQueue();

    // Checks if the queue is empty
    bool isEmpty() const;

    // Returns the front element of the queue without removing it
    int peek() const;

    // Prints the contents of the queue
    void print() const;
};

#endif // MYQUEUE_H
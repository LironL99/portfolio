/* Assignment C++: 1
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#include "MyQueue.h"
#include <iostream>

bool MyQueue::enQueue(int val) {
    // Check if there's space in the queue
    if (queue.size() < maxQ) {
        queue.push_back(val); // Add the new element to the back of the queue
        return true;
    }
    return false; // Queue is full
}

bool MyQueue::deQueue() {
    if (queue.empty()) {
        return false; // Queue is already empty
    }
    queue.erase(queue.begin()); // Remove the front element
    if (!queue.empty()) {
        // Print the updated queue
        std::cout << "The new queue:" << std::endl;
        for (size_t i = 0; i < queue.size(); ++i) {
            std::cout << queue[i];
            if (i != queue.size() - 1) {
                std::cout << " <- ";
            }
        }
        std::cout << std::endl;
    }
    return true;
}

bool MyQueue::isEmpty() const {
    return queue.empty(); // Check if the queue has no elements
}

int MyQueue::peek() const {
    if (queue.empty()) {
        return -1; // Return -1 if the queue is empty
    }
    return queue.front(); // Return the front element without removing it
}

void MyQueue::print() const {
    if (queue.empty()) {
        std::cout << "The queue is empty" << std::endl;
    } else {
        // Print all elements in the queue
        for (size_t i = 0; i < queue.size(); ++i) {
            std::cout << queue[i];
            if (i != queue.size() - 1) {
                std::cout << " <- ";
            }
        }
        std::cout << std::endl;
    }
}
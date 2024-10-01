/* Assignment C++: 1
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#include "Menu.h"
#include "Stack.h"
#include "MyQueue.h"
#include <iostream>

void Menu::mainMenu() {
    int choice;
    do {
        std::cout << "(1) Integer Stack" << std::endl;
        std::cout << "(2) Integer Queue Menu" << std::endl;
        std::cout << "(3) Exit" << std::endl;
        std::cin >> choice;

        switch (choice) {
        case 1:
            stackMenu();
            break;
        case 2:
            queueMenu();
            break;
        case 3:
            std::cout << "Goodbye!" << std::endl;
            break;
        default:
            std::cout << "Invalid selection." << std::endl;
        }
    } while (choice != 3);
}

void Menu::stackMenu() {
    Stack stack;
    int choice, value;
    do {
        // Display menu options for stack operations
        std::cout << "*** Manage your integer stack ***" << std::endl;
        std::cout << "1 Push new element" << std::endl;
        std::cout << "2 Pop element" << std::endl;
        std::cout << "3 Check if empty" << std::endl;
        std::cout << "4 Print stack elements" << std::endl;
        std::cout << "5 to exit" << std::endl;
        std::cin >> choice;
        switch (choice) {
            case 1:
                // Push operation: Add a new element to the top of the stack
                std::cout << "Please insert the new element: ";
                std::cin >> value;
                stack.push(value);
                break;
            case 2:
                // Pop operation: Remove the top element from the stack
                if (!stack.isEmpty()) {
                    int removedValue = stack.peek(); // First, peek at the top element
                    std::cout << "Removing " << removedValue << std::endl;
                    stack.pop(); // Then, remove the top element
                } else {
                    std::cout << "Stack empty" << std::endl;
                }
                break;
            case 3:
                // Check if the stack is empty
                std::cout << (stack.isEmpty() ? "The stack is empty" : "The stack is not empty") << std::endl;
                break;
            case 4:
                // Print all elements in the stack
                std::cout << stack;
                break;
            case 5:
                std::cout << "Thank you!" << std::endl;
                break;
            default:
                std::cout << "Invalid selection." << std::endl;
        }
    } while (choice != 5);
}

void Menu::queueMenu() {
    int maxQ;
    std::cout << "Enter the size of the queue: ";
    std::cin >> maxQ;
    MyQueue queue(maxQ);
    int choice, value;
    do {
        // Display menu options for queue operations
		std::cout << std::endl;
        std::cout << "*** Welcome to Queue Menu ***" << std::endl;
        std::cout << "To select an item, enter" << std::endl;
        std::cout << "1 Show Queue" << std::endl;
        std::cout << "2 Insert new element" << std::endl;
        std::cout << "3 Remove element" << std::endl;
        std::cout << "4 Check the first element" << std::endl;
        std::cout << "5 to exit" << std::endl;
        std::cin >> choice;
        switch (choice) {
            case 1:
                // Print all elements in the queue
                queue.print();
                break;
            case 2:
                // Enqueue operation: Add a new element to the back of the queue
                std::cout << "insert new element: ";
                std::cin >> value;
                if (!queue.enQueue(value)) {
                    std::cout << "Queue is full" << std::endl;
                }
				else{
					std::cout << "The new queue:" << std::endl;
					queue.print();
				}
                break;
            case 3:
                // Dequeue operation: Remove the front element from the queue
                if (!queue.deQueue() or queue.isEmpty()) {
                    std::cout << "Queue is empty" << std::endl;
                }
                break;
            case 4:
                // Peek operation: Check the front element without removing it
                value = queue.peek();
                if (value == -1) {
                    std::cout << "Queue is empty" << std::endl;
                } else {
                    std::cout << value << std::endl;
                }
                break;
            case 5:
                break;
            default:
                std::cout << "Invalid selection." << std::endl;
        }
    } while (choice != 5);
}
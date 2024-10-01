/* Assignment C++: 1
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/

#ifndef MENU_H
#define MENU_H

// Menu class handles the user interface for stack and queue operations
class Menu {
public:
    // Displays the main menu and handles user input
    void mainMenu();
    
    // Displays the stack menu and manages stack operations
    void stackMenu();
    
    // Displays the queue menu and manages queue operations
    void queueMenu();
};

#endif // MENU_H
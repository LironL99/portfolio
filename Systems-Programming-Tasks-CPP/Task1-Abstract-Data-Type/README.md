# Task 1: Class Implementation - Stack and Queue

### Task Overview
This task focuses on implementing an abstract data type (ADT) for a stack and a queue using C++. 
The implementation includes constructors, destructors, public and private members, operator overloading, 
and the design of a menu class to manage user interactions.

### Part A: Stack Implementation
- **StackNode Class**:
  - **Private Members**: 
    - `data` (int)
    - `next` (StackNode*)
  - **Public Methods**:
    - Default constructor and destructor.
  
- **Stack Class**:
  - **Private Members**:
    - `top` (StackNode*)
  - **Public Methods**:
    - `Stack()`: Initializes top to NULL.
    - `push(int)`: Inserts a new element at the top of the stack.
    - `pop()`: Removes the top element from the stack.
    - `isEmpty()`: Returns true if the stack is empty; otherwise, false.
    - `peek()`: Returns the top element without removing it.
  
- **Operator Overloading**:
  - Overloaded operators for concatenation, comparison, and insertion for easy printing.

### Part B: Queue Implementation
- **MyQueue Class**:
  - **Private Members**:
    - `vector<int>`: Contains the elements inside the queue.
    - `maxQ`: Capacity of the queue.
  - **Public Methods**:
    - `MyQueue(int maxQ)`: Initializes the queue with a specified maximum size.
    - `enQueue(int val)`: Inserts a new element at the end of the queue.
    - `deQueue()`: Removes the next element from the queue.
    - `isEmpty()`: Returns true if the queue is empty; otherwise, false.
    - `peek()`: Returns the value of the first element in the queue.

### Part C: Menu Class
- **Menu Class**:
  - Manages user interaction through a command-line interface.
  - **Methods include**:
    - `mainMenu()`: Displays the main menu options.
    - `stackMenu()`: Provides options for stack operations.
    - `queueMenu()`: Provides options for queue operations.

### Collaboration
This task was completed in collaboration with a partner, enhancing the understanding of data structures and C++ programming.

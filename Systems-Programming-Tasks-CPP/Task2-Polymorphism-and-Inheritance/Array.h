/* Assignment C++: 2
   Author: Liron Leibovich, ID: 209144773
   Author: Mishel Abramov, ID: 206421109
*/ 

#ifndef ARRAY_H
#define ARRAY_H

#include <iostream>

template<typename T>
class Array {
private:
    T* data;          // Pointer to the array's first element
    int size;         // Current size of the array
    int capacity;     // Current capacity of the array

    void resize() {   // Resizes the array when capacity is reached
        capacity *= 2; // Double the capacity
        T* newData = new T[capacity];
        for (int i = 0; i < size; i++) {
            newData[i] = data[i]; // Copy old data to new array
        }
        delete[] data; // Delete old array
        data = newData; // Point to new array
    }

public:
    Array() : size(0), capacity(10) {
        data = new T[capacity]; // Initialize array with default capacity
    }

    ~Array() {
        delete[] data; // Release allocated memory
    }

    void insert(const T& item) {
        if (size == capacity) {
            resize(); // Resize array if capacity is reached
        }
        data[size++] = item; // Add new item and increment size
    }

    T remove(int index) {
        if (index < 0 || index >= size) {
            throw "Index out of range"; // Throw error message
        }
        T removedItem = data[index]; // Save the item to be removed
        for (int i = index; i < size - 1; i++) {
            data[i] = data[i + 1]; // Shift items to the left
        }
        size--; // Decrement size
        return removedItem; // Return removed item
    }

    int getSize() const {
        return size; // Return current size of the array
    }

    T& operator[](int index) {
        if (index < 0 || index >= size) {
            throw "Index out of range"; // Throw error message
        }
        return data[index]; // Return reference to the specified index
    }

    template<typename U>
    friend std::ostream& operator<<(std::ostream& os, const Array<U>& array);
};

template<typename T>
std::ostream& operator<<(std::ostream& os, const Array<T>& array) {
    for (int i = 0; i < array.size; i++) {
        os << array.data[i] << std::endl; // Output each element
    }
    return os;
}

#endif

# K-Nearest Neighbors (KNN) and K-Means Clustering Implementation

## Overview
This project provides a Python implementation of two important machine learning algorithms: **K-Nearest Neighbors (KNN)** and **K-Means Clustering**. These algorithms are fundamental for supervised and unsupervised learning tasks, respectively. This implementation is a part of my portfolio, showcasing my proficiency in Python, machine learning techniques, and understanding of algorithmic structures.

### Task 1: K-Nearest Neighbors (KNN)
K-Nearest Neighbors is a simple, yet powerful supervised learning algorithm used for both classification and regression tasks. In this project, we focus on the classification task, where the goal is to predict the label of an unseen sample based on the labels of the nearest samples in the training dataset.

#### File: `knn.py`

### Constructor
- Parameters:
  - `k`: Number of nearest neighbors to consider.

### Methods
- `fit(x_train, y_train)`:
  - Description: This method stores the training data (samples and labels) so that predictions can be made based on the stored neighbors.
  - Parameters:
    - `x_train`: 2D NumPy array of training samples (integers).
    - `y_train`: 1D NumPy array of corresponding labels (integers).
  - Returns: None.
  
- `predict(x_test)`:
  - Description: Predicts the labels for a set of test samples by computing the distance from each test sample to all training samples, selecting the k-nearest neighbors, and using the majority label among those neighbors.
  - Parameters:
    - `x_test`: 2D NumPy array of test samples (integers).
  - Returns: 1D NumPy array of predicted labels.

### Task 2: K-Means Clustering
K-Means is an unsupervised learning algorithm used for clustering. It works by partitioning a dataset into k clusters, with each cluster represented by its centroid. The algorithm iteratively refines these centroids to minimize the Within-Cluster Sum of Squares (WCSS), a measure of how tightly the samples are clustered around the centroid.

#### File: `k_means.py`

### Constructor
- Parameters:
  - `k`: Number of clusters to form.
  - `max_iter`: Maximum number of iterations to perform during clustering.

### Methods
- `initialize(centroids)`:
  - Description: Initializes the centroids at given starting points.
  - Parameters:
    - `centroids`: 2D NumPy array representing the initial coordinates of the centroids (floats).
  - Returns: None.
  
- `fit(x_train)`:
  - Description: Performs the K-Means clustering algorithm by iteratively assigning points to clusters and updating centroid positions until convergence or reaching the maximum number of iterations.
  - Parameters:
    - `x_train`: 2D NumPy array of training samples (floats).
  - Returns: A dictionary with cluster IDs as keys and the final centroid positions as values.

- `predict(x_test)`:
  - Description: Assigns each test sample to the nearest cluster centroid based on Euclidean distance.
  - Parameters:
    - `x_test`: 2D NumPy array of test samples (floats).
  - Returns: 1D NumPy array of assigned cluster IDs.

- `wcss()`:
  - Description: Computes the Within-Cluster Sum of Squares (WCSS), which quantifies how similar the points in each cluster are to their respective centroid. Lower values indicate more compact clusters.
  - Returns: A float representing the WCSS of the model.

## Data Types
- KNN: The features and labels in this implementation are integers.
- K-Means: The features are represented as floats.

## Key Considerations
- **KNN**: This algorithm can be computationally expensive as it involves calculating distances between all training samples and each test sample. To optimize performance, methods like using KD-trees or Ball-trees can be integrated for large datasets.
  
- **K-Means**: The results of K-Means can depend on the initial placement of centroids. It’s common practice to run the algorithm multiple times with different centroid initializations and select the best result based on WCSS. This implementation allows flexibility in initializing centroids manually.

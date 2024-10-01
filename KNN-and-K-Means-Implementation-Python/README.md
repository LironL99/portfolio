#KNN and K-Means Implementation in Python

## Task Overview
### Task 1: K-Nearest Neighbors (KNN)

**File**: `knn.py`

#### Implementation Requirements
- **Constructor**:
  - Accepts a single argument named `k`, which dictates the number of neighbors considered.
  
- **Methods**:
  - **fit**:
    - Accepts a NumPy array of samples (`x_train`) and a corresponding 1-D NumPy array of labels (`y_train`).
    - This method does not return anything.
    
  - **predict**:
    - Accepts a NumPy array of samples to predict labels.
    - Returns a 1-D NumPy array of predicted labels.

#### Data Types
- The underlying data type for features and labels will be integers.

---

### Task 2: K-Means Clustering

**File**: `k_means.py`

#### Implementation Requirements
- **Constructor**:
  - Accepts two arguments: `k` (the number of clusters) and `max_iter` (the maximum number of iterations during fitting).

- **Methods**:
  - **initialize**:
    - Accepts a 2-D NumPy array representing initial centroid coordinates.
  
  - **fit**:
    - Accepts a NumPy array of samples (`x_train`).
    - Performs the K-Means algorithm to find centroids and returns a dictionary with cluster IDs as keys and corresponding centroid arrays as values.
  
  - **predict**:
    - Accepts a NumPy array of samples for clustering.
    - Returns a 1-D NumPy array of assigned cluster IDs.

  - **wcss**:
    - Returns the WCSS (Within-Cluster Sum of Squares) of the model calculated during the fit stage.

#### Data Types
- The underlying data type for features will be floats.

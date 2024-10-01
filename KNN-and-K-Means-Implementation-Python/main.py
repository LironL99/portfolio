import numpy as np
from knn import KNN
from k_means import KMeans

# Load training and test data for KNN
train = np.genfromtxt('mnist_train_min.csv', delimiter=',', skip_header=1, dtype=np.int_)
test = np.genfromtxt('mnist_test_min.csv', delimiter=',', skip_header=1, dtype=np.int_)

# Prepare training data
y_train = train[:, 0]
X_train = train[:, 1:]

# Prepare test data
y_test = test[:, 0]
X_test = test[:, 1:]

# Initialize and train KNN model
knn_model = KNN(k=10)
knn_model.fit(X_train, y_train)

# Make predictions using KNN
knn_predictions = knn_model.predict(X_test)

# Load data for KMeans
iris_data = np.genfromtxt('iris.csv', delimiter=',', skip_header=1, dtype=np.float_)[:, 1:4]

# Initialize centroids based on the means of the classes
c1 = np.mean(iris_data[:50], axis=0)
c2 = np.mean(iris_data[50:100], axis=0)
c3 = np.mean(iris_data[100:], axis=0)

# Shuffle data to ensure randomness
rng = np.random.default_rng()
rng.shuffle(iris_data, axis=0)  # Shuffle data rows

# Split data into training and test sets
train_kmeans = iris_data[:100]
test_kmeans = iris_data[100:]

# Initialize and fit KMeans model
kmeans_model = KMeans(k=3, max_iter=100)
kmeans_model.initialize(np.array([c1, c2, c3]))
class_centers = kmeans_model.fit(train_kmeans)

# Print WCSS (Within-Cluster Sum of Squares)
print("WCSS:", kmeans_model.wcss())

# Make predictions using KMeans
kmeans_classification = kmeans_model.predict(test_kmeans)

import numpy as np
from collections import Counter

def euclidean_distance(x1, x2):
    """Calculate the Euclidean distance between two points."""
    return np.sqrt(np.sum((x1 - x2) ** 2))

class KNN:
    def __init__(self, k: int) -> None:
        """Initialize the KNN classifier with the number of neighbors."""
        self.k = k
        self.x_train = None
        self.y_train = None

    def fit(self, x_train: np.ndarray, y_train: np.ndarray) -> None:
        """Fit the model using the training data."""
        self.x_train = x_train
        self.y_train = y_train

    def predict(self, x_test: np.ndarray) -> np.ndarray:
        """Predict the class labels for the provided test samples."""
        predicted_labels = [self._predict_single(sample) for sample in x_test]
        return np.array(predicted_labels)

    def _predict_single(self, x: np.ndarray) -> int:
        """Predict the class label for a single sample."""
        # Compute distances between the test sample and all training samples
        distances = np.array([euclidean_distance(x, x_train_sample) for x_train_sample in self.x_train])
        
        # Get the indices of the k nearest samples
        k_indices = np.argsort(distances)[:self.k]
        
        # Gather the labels of the k nearest samples
        k_nearest_labels = self.y_train[k_indices]
        
        # Determine the most common label among the k nearest labels
        most_common = Counter(k_nearest_labels).most_common(1)[0][0]
        
        return most_common

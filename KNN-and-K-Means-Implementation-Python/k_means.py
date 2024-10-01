import numpy as np

def euclidean_distance(x1, x2):
    """Calculate the Euclidean distance between two points."""
    return np.sqrt(np.sum((x1 - x2) ** 2))

class KMeans:
    def __init__(self, k: int, max_iter: int) -> None:
        """Initialize the KMeans algorithm with the number of clusters and max iterations."""
        self.k = k
        self.max_iter = max_iter
        self.centroids = None
        self.X_train = None
        self.clusters = [[] for _ in range(self.k)]

    def initialize(self, centroids: np.ndarray) -> None:
        """Initialize centroids for clustering."""
        self.centroids = centroids

    def wcss(self) -> float:
        """Calculate the within-cluster sum of squares."""
        total_sum = 0
        for sample in self.X_train:
            centroid_index = self._closest_centroid(sample, self.centroids)
            total_sum += euclidean_distance(self.centroids[centroid_index], sample) ** 2
        return total_sum

    def _closest_centroid(self, sample: np.ndarray, centroids: np.ndarray) -> int:
        """Find the index of the closest centroid to a sample."""
        distances = [euclidean_distance(sample, centroid) for centroid in centroids]
        return np.argmin(distances)

    def _new_clusters(self) -> list:
        """Assign samples to the nearest centroids and return new clusters."""
        clusters = [[] for _ in range(self.k)]
        for index, sample in enumerate(self.X_train):
            centroid_index = self._closest_centroid(sample, self.centroids)
            clusters[centroid_index].append(index)
        return clusters

    def _get_centroids(self) -> np.ndarray:
        """Calculate the new centroids based on current clusters."""
        centroids = np.zeros((self.k, self.n_cols))
        for cluster_index, cluster in enumerate(self.clusters):
            centroids[cluster_index] = np.mean(self.X_train[cluster], axis=0)
        return centroids

    def _is_it_converged_yet(self, old_centroids: np.ndarray) -> bool:
        """Check for convergence of centroids."""
        distances = [euclidean_distance(old_centroids[i], self.centroids[i]) for i in range(self.k)]
        return np.all(np.array(distances) == 0)

    def _get_cluster_labels(self) -> np.ndarray:
        """Get the cluster labels for each test sample."""
        labels = np.empty(self.test_n_samples, dtype=int)
        for count, sample in enumerate(self.X):
            labels[count] = self._closest_centroid(sample, self.centroids)
        return labels

    def fit(self, X_train: np.ndarray) -> dict:
        """Perform the KMeans clustering algorithm on the training data."""
        self.X_train = X_train
        self.n_samples, self.n_cols = X_train.shape
        
        for _ in range(self.max_iter):
            self.clusters = self._new_clusters()
            old_centroids = self.centroids.copy() if self.centroids is not None else None
            self.centroids = self._get_centroids()

            if old_centroids is not None and self._is_it_converged_yet(old_centroids):
                break

        return {i: self.centroids[i] for i in range(self.k)}

    def predict(self, X: np.ndarray) -> np.ndarray:
        """Predict the cluster labels for new data."""
        self.X = X
        self.test_n_samples, self.test_n_cols = X.shape
        return self._get_cluster_labels()

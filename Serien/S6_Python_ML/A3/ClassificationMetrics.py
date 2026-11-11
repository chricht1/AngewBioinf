
import numpy as np

class ClassificatorMetrics:
	def __init__(self, labels, predictions):
		self.labels = np.array(labels)
		self.predictions = np.array(predictions)

		self.tp = np.sum((self.labels == 1) & (self.predictions == 1))
		self.tn = np.sum((self.labels == -1) & (self.predictions == -1))
		self.fp = np.sum((self.labels == -1) & (self.predictions == 1))
		self.fn = np.sum((self.labels == 1) & (self.predictions == -1))
		
	def sensitivity(self):
		return self.tp / (self.tp + self.fn)

	def precision(self):
		return self.tp / (self.tp + self.fp)
    
	def f1Score(self):
		return (2 * self.tp) / (2 * self.tp + self.fp + self.fn)

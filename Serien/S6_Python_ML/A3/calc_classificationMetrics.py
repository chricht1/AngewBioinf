
from ClassificationMetrics import ClassificatorMetrics


def load_data(fPath):
	with open(fPath, 'r') as f:
		lines = f.readlines()
		labels = []
		all_Pedictions = []

		for line in lines:
			values = line.strip().split()
			labels.append(int(values[0]))
			all_Pedictions.append([int(i) for i in values[1:]])

	predictions = [[] for _ in range(len(all_Pedictions[0]))]

	for dataPointPreds in all_Pedictions:
		for idx, pred in enumerate(dataPointPreds):
			predictions[idx].append(pred)
		
	return labels, predictions


def main():
	fPath = "Klassifikation.tsv"
	labels, predsClassifictors = load_data(fPath)

	for idx, predsClassifictor in enumerate(predsClassifictors):
		print("\n--- Classificator " + str(idx + 1) + " ---\n")
		metrics = ClassificatorMetrics(labels, predsClassifictor)
		print(f"Sensitivity:    {metrics.sensitivity():.3f}")
		print(f"Precision:      {metrics.precision():.3f}")
		print(f"F1-Score:       {metrics.f1Score():.3f}")

if __name__ == "__main__":
    main()

import numpy as np
import pandas as pd
from sklearn.svm import SVC

train_data = pd.read_csv("cells_train.tsv", sep="\t", header=None)
X_train = train_data.iloc[:, 1:]
y_train = train_data.iloc[:, 0]

X_test = pd.read_csv("cells_test.tsv", sep="\t", header=None)

kernel = 'rbf'
c = 2

svc = SVC(gamma='scale', kernel=kernel, C=c)
svc.fit(X_train, y_train)
predictions = svc.decision_function(X_test)

np.savetxt("predictions_aufg_1.txt", predictions, fmt="%f")

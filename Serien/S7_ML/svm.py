import numpy as np
import pandas as pd
from sklearn.svm import SVC
from sklearn.model_selection import cross_validate
import json
import matplotlib.pyplot as plt

from src.utils import *

    
np.random.seed(13625)

train_data = pd.read_csv("cells_train.tsv",sep="\t", header=None)

X_train = train_data.iloc[:, 1:]
y_train = train_data.iloc[:, 0]


kernels = ['linear', 'poly', 'rbf', 'sigmoid']
Cs = [1,1.2,1.5,1.75,2,3]
n_tests = len(kernels)*len(Cs)
print(f'testing {n_tests} hyperparameter settings')
cv_results = nested_dd()
for kernel in kernels:
    for c in Cs:
        svc = SVC(gamma='scale', kernel=kernel, C=c)
        scores = cross_validate(svc, X_train, y_train, scoring='roc_auc', cv=5)
        cv_results[kernel][f'C: {c}'] = np.mean(scores['test_score'])



cv_res_arr = dfltdict_vals_to_arr(cv_results)
cv_res_arr_fl = cv_res_arr.flatten()
best_params_idx = np.argmax(cv_res_arr)

best1stSetting_idx = np.floor(best_params_idx / len(kernels))
best2ndSetting_idx = best_params_idx % len(Cs)

res_info = f'highest score: {cv_res_arr_fl[best_params_idx]} at index {best_params_idx}\n \
        for kernel {best1stSetting_idx} and C {best2ndSetting_idx}'
print(res_info)

plt.plot(cv_res_arr_fl)
plt.title('SVM CV Results')
plt.xlabel('Hyperparameter Setting Index')
plt.ylabel('ROC AUC Score')
plt.savefig('svm_cv.png')

cv_results["cv_result"] = res_info

with open("svm_cv.json", "w") as f:
    json.dump(cv_results, f, indent=4)

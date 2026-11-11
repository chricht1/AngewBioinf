import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import cross_validate
from collections import defaultdict
import json
import matplotlib.pyplot as plt

from src.utils import *

random_state = 13625

np.random.seed(random_state)
train_data = pd.read_csv("cells_train.tsv",sep="\t", header=None)

X_train = train_data.iloc[:, 1:]
y_train = train_data.iloc[:, 0]

n_estimators_list = [50, 100, 200, 300]
max_depths = [5, 10, 20, None]

n_tests = len(n_estimators_list) * len(max_depths)
print(f'testing {n_tests} hyperparameter settings')


for n_estimators in n_estimators_list:
    for max_depth in max_depths:
        rfc = RandomForestClassifier(n_estimators=n_estimators, max_depth=max_depth, random_state=random_state)
        scores = cross_validate(rfc, X_train, y_train, scoring='roc_auc', cv=5)
        cv_results[f'n_estimators: {n_estimators}'][f'max_depth: {max_depth}'] = np.mean(scores['test_score'])



cv_res_arr = dfltdict_vals_to_arr(cv_results)
cv_res_arr_fl = cv_res_arr.flatten()
best_params_idx = np.argmax(cv_res_arr_fl)

best1stSetting_idx = int(np.floor(best_params_idx / len(max_depths)))
best2ndSetting_idx = best_params_idx % len(max_depths)

best_n_estimators = n_estimators_list[best1stSetting_idx]
best_max_depth = max_depths[best2ndSetting_idx]

res_info = f'highest score: {cv_res_arr_fl[best_params_idx]} at index {best_params_idx}\n' \
           f'for n_estimators {best_n_estimators} and max_depth {best_max_depth}'
print(res_info)

plt.plot(cv_res_arr_fl)
plt.title('Random Forest CV Results')
plt.xlabel('Hyperparameter Setting Index')
plt.ylabel('ROC AUC Score')
plt.savefig('randomForest_cv.png')

cv_results["cv_result"] = res_info

with open("rf_cv.json", "w") as f:
    json.dump(cv_results, f, indent=4)

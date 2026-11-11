from numpy import genfromtxt
from numpy.random import shuffle
import numpy as np
import sys
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import roc_auc_score,accuracy_score
from sklearn.ensemble import AdaBoostClassifier
from sklearn.model_selection import cross_validate
from sklearn.svm import SVC
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import export_text
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import KFold

temp = genfromtxt(sys.argv[1], delimiter="\t")

Y = temp[:,0]
X = temp[:,1:]

#model = KNeighborsClassifier(n_neighbors=5,weights='distance')
#model = GaussianNB()
#model = LogisticRegression(l1_ratio=0,C=1)
#model = DecisionTreeClassifier(max_depth=5)
#model = SVC(gamma='scale',probability=True)
model = RandomForestClassifier(max_depth=5,n_estimators=1000)

print(model)

#return_train_score=True
score = cross_validate(model, X, Y, cv=5, scoring=["roc_auc","accuracy"],return_train_score=True)
print("CV: {0}".format(score))

model.fit(X,Y)


temp = genfromtxt(sys.argv[2], delimiter="\t")

Ytest = temp[:,0]
Xtest = temp[:,1:]

preds = model.predict_proba(Xtest)[:,1]
auc = roc_auc_score(Ytest,preds)
preds2 = model.predict(Xtest)
acc = accuracy_score(Ytest,preds2)
print("AUC: {0}, Acc: {1}".format(auc,acc))

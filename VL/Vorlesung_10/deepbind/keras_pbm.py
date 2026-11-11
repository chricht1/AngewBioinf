import numpy as np
from numpy import genfromtxt
from keras.models import Sequential
from keras.layers import Dense, Dropout, Conv1D, GlobalMaxPooling1D, GlobalAveragePooling1D

import sys

data = genfromtxt(sys.argv[1], delimiter="\t")

Y = np.log(data[:,0]+1)

X = data[:,1:]

# notwendig, da Conv1D "Bild" erwartet, hier eine "Bildzeile"
X = X.reshape((X.shape[0],X.shape[1],1))


model = Sequential()
model.add(Conv1D(5, 32, strides=4, activation='relu', input_shape=(164, 1)))
model.add(GlobalMaxPooling1D())
#model1.add(Dense(10,activation="relu"))
model.add(Dense(1))


model.compile(loss="mean_squared_error",optimizer="adam")

model.summary()

mod = model.fit(X,Y,epochs=50,batch_size=100)

pred = model.predict(X)


print("Corr (train): {0}".format(np.corrcoef(pred[:,0],Y)[1,0]))



data = genfromtxt(sys.argv[2], delimiter="\t")

Y = np.log(data[:,0]+1)

X = data[:,1:]

X = X.reshape((X.shape[0],X.shape[1],1))

pred = model.predict(X)

print("Corr (test): {0}".format(np.corrcoef(pred[:,0],Y)[1,0]))




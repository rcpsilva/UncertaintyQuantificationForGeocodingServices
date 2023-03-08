from sklearn.datasets import make_friedman2
from sklearn.gaussian_process import GaussianProcessRegressor
from sklearn.gaussian_process.kernels import DotProduct, WhiteKernel
from sklearn.gaussian_process.kernels import ConstantKernel, RBF
import pandas as pd
import numpy as np
import pickle

#nohup python script_amelia.py > output.log & 

df = pd.read_csv('modeloJoinville.csv')

df = df.dropna()
df = df.sample(n = 1000)

X = df[['lat', 'lon']].to_numpy()
y1 = df['lat_api'].to_numpy()
y2 = df['lon_api'].to_numpy()

regressorLat = GaussianProcessRegressor()
regressorLon = GaussianProcessRegressor()

regressorLat.fit(X, y1)
regressorLon.fit(X, y2)

with open('models.pkl', 'wb') as file:
    pickle.dump(regressorLat, file)
    pickle.dump(regressorLon, file)

file.close()


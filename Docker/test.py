import tensorflow as tf
import numpy
print(numpy.__version__)

import influxdb_client
import ccxt

print(tf.__version__)
print(tf.test.is_gpu_available())
assert (tf.test.is_gpu_available())


import talib
from hyperopt import Trials, STATUS_OK, tpe, rand
from hyperas import optim
from hyperas.distributions import choice, uniform

import optuna
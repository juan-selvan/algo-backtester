from tqdm import tqdm
from opt.stockdata import StockData
from opt.portfolio cimport Portfolio
import inspect 
import numpy as np

cdef class CythonAlgorithm:

    def __init__(self):
        self.indicator_parameters = dict()

    @classmethod
    def indicator_functions(cls):
        # TODO: filter by only functions
        return {k:v for k, v in inspect.getmembers(cls) 
                if callable(v) and hasattr(getattr(cls, k), 'indicator') and not k.startswith('__')}
    
    def set_indicator_params(self, params):
        # TODO raise error if not dict
        self.indicator_parameters.update(params)


#    def add_indicator(self, name, func):
#        if not callable(func):
#            raise ValueError(
#                f'add_indicator expects a function, not {type(func)}')
#
#        self._indicator_funcs[name] = func

    def run_on_data(self, curr_prices, data, portfolio):
        portfolio.curr_prices = curr_prices
        self.on_data(data, portfolio)

    # to override
    def on_data(self, data: dict, portfolio: Portfolio):
        return

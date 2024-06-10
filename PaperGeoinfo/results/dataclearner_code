import pandas as pd
from sklearn.preprocessing import MinMaxScaler, OneHotEncoder

class DataCleaner:

    def __init__(self, df):
        self.df = df

    def fill_missing_values(self, method='mean'):
        if method == 'mean':
            self.df.fillna(self.df.mean(), inplace=True)
        elif method == 'median':
            self.df.fillna(self.df.median(), inplace=True)
        elif method == 'mode':
            self.df.fillna(self.df.mode().iloc[0], inplace=True)
        return self.df

    def drop_missing_values(self):
        self.df.dropna(inplace=True)
        return self.df

    def normalize_data(self, columns):
        scaler = MinMaxScaler()
        self.df[columns] = scaler.fit_transform(self.df[columns])
        return self.df

    def remove_duplicates(self):
        self.df.drop_duplicates(inplace=True)
        return self.df
    

if __name__ == '__main__':

    import pandas as pd

    # Sample DataFrame
    data = {'col1': [1, 2, None, 4], 'col2': [0.24, None, 0.15, 0.18]}
    df = pd.DataFrame(data)

    # Using the API
    cleaner = DataCleaner(df)
    cleaner.fill_missing_values(method='mean')
    cleaner.remove_duplicates()
    cleaner.normalize_data(['col1'])
    print(cleaner.df)
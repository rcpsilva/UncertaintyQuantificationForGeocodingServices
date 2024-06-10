from setuptools import setup, find_packages

setup(
    name='DataCleaning',
    version='0.1',
    packages=find_packages(),
    url='https://github.com/rcpsilva/DataCleaning',
    license='MIT',
    author='Rodrigo Silva',
    author_email='rcpsilva@gmail.com',
    description='A simple data cleaner API for python',
    install_requires=[
        'pandas >= 2.1',
        'scikit-learn >= 1.3',
    ],
    python_requires='>=3.6'
)
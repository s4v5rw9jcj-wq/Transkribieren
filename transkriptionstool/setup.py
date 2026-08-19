#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Setup-Skript für das Transkriptionstool
"""

from setuptools import setup, find_packages

with open('requirements.txt') as f:
    requirements = f.read().splitlines()

setup(
    name='transkriptionstool',
    version='1.0.0',
    description='Ein Tool zum Transkribieren von MP4-Dateien in Word-Dokumente',
    author='Transkriptionstool',
    packages=find_packages(),
    install_requires=requirements,
    entry_points={
        'console_scripts': [
            'transkriptionstool=transkriptionstool.__main__:main',
        ],
    },
    python_requires='>=3.7',
    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: End Users/Desktop',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
        'Programming Language :: Python :: 3.11',
        'Programming Language :: Python :: 3.12',
    ],
)

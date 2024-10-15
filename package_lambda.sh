#!/bin/bash
pip install --target ./package -r requirements.txt
cd package
zip -r ../lambda_function.zip .
cd ..
zip -g lambda_function.zip lambda_function.py

#!/bin/bash
set -e

echo "=== Running Education Profiling & Cleaning ==="
jupyter nbconvert --to notebook --execute notebooks/education_profiling&cleaning.ipynb --output /tmp/edu_out.ipynb

echo "=== Running Crime Profiling & Cleaning ==="
jupyter nbconvert --to notebook --execute notebooks/crime_profiling&cleaning.ipynb --output /tmp/crime_out.ipynb

echo "=== Running Data Integration ==="
jupyter nbconvert --to notebook --execute notebooks/data_integration.ipynb --output /tmp/integration_out.ipynb

echo "=== Running Analysis Notebook ==="
jupyter nbconvert --to notebook --execute notebooks/analysis.ipynb --output /tmp/analysis_out.ipynb

echo "=== Workflow Complete! ==="

#!/bin/bash

echo "🧹 Cleaning up Airflow deployment..."
echo "===================================="

# Delete the deployment
echo "🗑️  Removing Airflow deployment..."
kubectl delete deployment airflow --ignore-not-found=true

# Delete the service
echo "🗑️  Removing Airflow service..."
kubectl delete service airflow-service --ignore-not-found=true

# Check status
echo "📊 Remaining Airflow resources:"
kubectl get all -l app=airflow

echo ""
echo "✅ Airflow cleanup complete!"
echo ""
echo "   All resources have been removed."

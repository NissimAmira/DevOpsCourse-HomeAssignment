#!/bin/bash

echo "🧹 Cleaning up Superset deployment..."
echo "===================================="

# Delete the deployment
echo "🗑️  Removing Superset deployment..."
kubectl delete deployment superset --ignore-not-found=true

# Delete the service
echo "🗑️  Removing Superset service..."
kubectl delete service superset-service --ignore-not-found=true

# Delete the ConfigMap
echo "🗑️  Removing Superset configuration..."
kubectl delete configmap superset-config --ignore-not-found=true

# Check status
echo "📊 Remaining Superset resources:"
kubectl get all -l app=superset

echo ""
echo "✅ Superset cleanup complete!"

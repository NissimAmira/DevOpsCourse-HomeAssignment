#!/bin/bash

echo "🐘 Deploying PostgreSQL Database..."
echo "=================================="

# Apply the PostgreSQL deployment
echo "📦 Creating PostgreSQL deployment..."
kubectl apply -f postgres-deployment.yaml

# Apply the PostgreSQL service
echo "🌐 Creating PostgreSQL service..."
kubectl apply -f postgres-service.yaml

# Wait for the deployment to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/postgres

# Get the status
echo "📊 PostgreSQL status:"
kubectl get pods -l app=postgres
kubectl get services -l app=postgres

echo ""
echo "✅ PostgreSQL deployment complete!"
echo "🔗 Database accessible at: postgres-service:5432"
echo "📝 Credentials:"
echo "   - Database: postgres"
echo "   - Username: postgres"
echo "   - Password: postgres"
echo ""
echo "💡 The database will be used by both Superset and Airflow"
echo "   Each application will create its own database schemas"

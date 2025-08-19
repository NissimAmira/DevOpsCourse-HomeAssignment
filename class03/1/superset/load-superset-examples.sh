#!/bin/bash

echo "🎯 Loading Superset with Example Data..."
echo "========================================"

# Get the superset pod name
SUPERSET_POD=$(kubectl get pods -l app=superset -o jsonpath='{.items[0].metadata.name}')

if [ -z "$SUPERSET_POD" ]; then
    echo "❌ No Superset pod found"
    exit 1
fi

echo "📦 Found Superset pod: $SUPERSET_POD"

# Load examples using superset command
echo "🔄 Loading example datasets and charts..."
kubectl exec $SUPERSET_POD -- superset load-examples --load-test-data

echo ""
echo "🗄️ Adding example database connections..."

# Add a connection to our PostgreSQL database as an example
kubectl exec $SUPERSET_POD -- superset fab create-db \
    --database_name "PostgreSQL Example" \
    --database_uri "postgresql://postgres:postgres@postgres-service:5432/postgres"

echo ""
echo "✅ Example data loading complete!"
echo ""
echo "🎨 What was added:"
echo "=================="
echo "✓ Example datasets (birth names, world health, etc.)"
echo "✓ Pre-built charts and dashboards"
echo "✓ Sample database connections"
echo "✓ Tutorial content"
echo ""
echo "🌍 Access Superset at: http://$(minikube ip):30088"
echo "🔑 Login: admin / admin"
echo ""
echo "💡 Try exploring:"
echo "   - Dashboards (you should see example dashboards)"
echo "   - Charts (pre-built visualization examples)"
echo "   - Datasets (sample data sources)"
echo "   - Data -> Databases (database connections)"

#!/bin/bash

echo "🗄️  Initializing databases for Airflow and Superset..."
echo "====================================================="

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/postgres

# Create databases using a temporary pod
echo "📝 Creating Airflow and Superset databases..."
kubectl run postgres-client --image=postgres:13 --rm -i --restart=Never -- bash -c "
export PGPASSWORD=postgres
psql -h postgres-service -U postgres -c 'CREATE DATABASE airflow;' || echo 'Airflow database already exists'
psql -h postgres-service -U postgres -c 'CREATE DATABASE superset;' || echo 'Superset database already exists'
psql -h postgres-service -U postgres -c '\l'
"

echo ""
echo "✅ Database initialization complete!"
echo "📊 Created databases:"
echo "   - airflow (for Airflow metadata)"
echo "   - superset (for Superset metadata)"

#!/bin/bash

echo "🚀 Deploying Airflow with PostgreSQL..."
echo "======================================"

# Check if PostgreSQL is deployed
echo "🔍 Checking for PostgreSQL deployment..."
if ! kubectl get deployment postgres > /dev/null 2>&1; then
    echo "❌ PostgreSQL not found! Deploying PostgreSQL first..."
    cd ../databases && ./deploy-postgres.sh && cd ../airflow
    echo "✅ PostgreSQL deployed!"
else
    echo "✅ PostgreSQL already deployed!"
fi

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/postgres

# Apply the Airflow deployment with PostgreSQL
echo "📦 Creating Airflow deployment with PostgreSQL..."
kubectl apply -f airflow-deployment-postgres.yaml

# Apply the Airflow service
echo "🌐 Creating Airflow service..."
kubectl apply -f airflow-service.yaml

# Wait for the deployment to be ready
echo "⏳ Waiting for Airflow pod to be ready..."
kubectl wait --for=condition=available --timeout=500s deployment/airflow

# Get the status
echo "📊 Current status:"
kubectl get pods -l app=airflow
kubectl get services -l app=airflow

# Get the Minikube IP
MINIKUBE_IP=$(minikube ip)

echo ""
echo "✅ Airflow with PostgreSQL deployment complete!"
echo "🔗 Access Airflow at: http://$MINIKUBE_IP:30080"
echo "📝 Login credentials: admin / admin"
echo ""
echo "🎯 Bonus features enabled:"
echo "   ✅ LOAD_EX=y (Example DAGs loaded)"
echo "   ✅ PostgreSQL database backend"
echo "   ✅ LocalExecutor (better performance)"
echo ""
echo "🛠️  Useful commands:"
echo "   View webserver logs: kubectl logs -l app=airflow -c airflow-webserver"
echo "   View scheduler logs: kubectl logs -l app=airflow -c airflow-scheduler"
echo "   View database status: kubectl get pods -l app=postgres"
echo "   Get service URL: minikube service airflow-service --url"
echo ""
echo "🔧 To access via minikube service tunnel:"
echo "   minikube service airflow-service --url"

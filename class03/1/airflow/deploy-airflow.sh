#!/bin/bash

echo "🚀 Deploying Airflow to Kubernetes..."
echo "=================================="

# Apply the Airflow deployment
echo "📦 Creating Airflow deployment..."
kubectl apply -f airflow-deployment.yaml

# Apply the Airflow service
echo "🌐 Creating Airflow service..."
kubectl apply -f airflow-service.yaml

# Wait for the deployment to be ready
echo "⏳ Waiting for Airflow pod to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/airflow

# Get the status
echo "📊 Current status:"
kubectl get pods -l app=airflow
kubectl get services -l app=airflow

# Get the Minikube IP
MINIKUBE_IP=$(minikube ip)

echo ""
echo "✅ Airflow deployment complete!"
echo "🔗 Access Airflow at: http://$MINIKUBE_IP:30080"
echo "📝 Default login: admin / admin"
echo ""
echo "🛠️  Useful commands:"
echo "   View webserver logs: kubectl logs -l app=airflow -c airflow-webserver"
echo "   View scheduler logs: kubectl logs -l app=airflow -c airflow-scheduler"
echo "   Get service URL: minikube service airflow-service --url"
echo "   Scale deployment: kubectl scale deployment airflow --replicas=2"
echo ""
echo "🔧 To access via minikube service tunnel:"
echo "   minikube service airflow-service --url"
echo ""
echo "📝 Components running:"
echo "   - Airflow Webserver (Web UI)"
echo "   - Airflow Scheduler (DAG execution)"
echo "   - SQLite Database (Development only)"

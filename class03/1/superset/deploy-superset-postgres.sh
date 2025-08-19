#!/bin/bash

echo "🚀 Deploying Superset with PostgreSQL..."
echo "======================================="

# Check if PostgreSQL is deployed
echo "🔍 Checking for PostgreSQL deployment..."
if ! kubectl get deployment postgres > /dev/null 2>&1; then
    echo "❌ PostgreSQL not found! Deploying PostgreSQL first..."
    cd ../databases && ./deploy-postgres.sh && cd ../superset
    echo "✅ PostgreSQL deployed!"
else
    echo "✅ PostgreSQL already deployed!"
fi

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/postgres

# Create ConfigMap from PostgreSQL config
echo "📝 Creating Superset PostgreSQL configuration..."
kubectl create configmap superset-config-postgres --from-file=superset_config_postgres.py --dry-run=client -o yaml | kubectl apply -f -

# Apply the Superset deployment with PostgreSQL
echo "📦 Creating Superset deployment with PostgreSQL..."
kubectl apply -f superset-deployment-postgres.yaml

# Apply the Superset service
echo "🌐 Creating Superset service..."
kubectl apply -f superset-service.yaml

# Wait for the deployment to be ready
echo "⏳ Waiting for Superset pod to be ready..."
kubectl wait --for=condition=available --timeout=500s deployment/superset

# Get the status
echo "📊 Current status:"
kubectl get pods -l app=superset
kubectl get services -l app=superset

# Get the Minikube IP
MINIKUBE_IP=$(minikube ip)

echo ""
echo "✅ Superset with PostgreSQL deployment complete!"
echo "🔗 Access Superset at: http://$MINIKUBE_IP:30088"
echo "📝 Login credentials: admin / admin"
echo ""
echo "🎯 Bonus features enabled:"
echo "   ✅ PostgreSQL database backend"
echo "   ✅ Proper database initialization"
echo "   ✅ Production-ready configuration"
echo ""
echo "🛠️  Useful commands:"
echo "   View logs: kubectl logs -l app=superset"
echo "   View database status: kubectl get pods -l app=postgres"
echo "   Get service URL: minikube service superset-service --url"
echo "   Scale deployment: kubectl scale deployment superset --replicas=2"
echo ""
echo "🔧 To access via minikube service tunnel:"
echo "   minikube service superset-service --url"

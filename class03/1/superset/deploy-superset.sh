#!/bin/bash

echo "🚀 Deploying Superset to Kubernetes..."
echo "====================================="

# Create ConfigMap from superset_config.py
echo "📝 Creating Superset configuration..."
kubectl create configmap superset-config --from-file=superset_config.py --dry-run=client -o yaml | kubectl apply -f -

# Apply the Superset deployment
echo "📦 Creating Superset deployment..."
kubectl apply -f superset-deployment.yaml

# Apply the Superset service
echo "🌐 Creating Superset service..."
kubectl apply -f superset-service.yaml

# Wait for the deployment to be ready
echo "⏳ Waiting for Superset pod to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/superset

# Get the status
echo "📊 Current status:"
kubectl get pods -l app=superset
kubectl get services -l app=superset

# Get the Minikube IP
MINIKUBE_IP=$(minikube ip)

echo ""
echo "✅ Superset deployment complete!"
echo "🔗 Access Superset at: http://$MINIKUBE_IP:30088"
echo "📝 Default login credentials may vary by image version"
echo "   - Try: admin / admin"
echo "   - Or check logs for initial setup instructions"
echo ""
echo "🛠️  Useful commands:"
echo "   View logs: kubectl logs -l app=superset"
echo "   Get service URL: minikube service superset-service --url"
echo "   Scale deployment: kubectl scale deployment superset --replicas=2"
echo ""
echo "🔧 To access via minikube service tunnel:"
echo "   minikube service superset-service --url"

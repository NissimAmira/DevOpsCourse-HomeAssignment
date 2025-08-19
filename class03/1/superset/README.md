# Superset Kubernetes Deployment

This directory contains the necessary files to deploy Apache Superset on Kubernetes using Minikube.

## Files Overview

### YAML Configuration Files
- `superset-deployment.yaml` - Kubernetes Deployment configuration for Superset
- `superset-service.yaml` - Kubernetes Service configuration (NodePort)
- `superset_config.py` - Superset application configuration

### Scripts
- `deploy-superset.sh` - Automated deployment script
- `cleanup-superset.sh` - Automated cleanup script

## Superset Components

This deployment includes:
- **Superset Application**: Business intelligence web application
- **Configuration**: Custom Superset configuration via ConfigMap
- **SQLite Database**: Built-in database for development

## Usage

### Deploy Superset
```bash
# Method 1: Using script (recommended)
./deploy-superset.sh

# Method 2: Using kubectl commands
kubectl create configmap superset-config --from-file=superset_config.py
kubectl apply -f superset-deployment.yaml
kubectl apply -f superset-service.yaml
```

### Access Superset
- **Direct**: http://$(minikube ip):30088
- **Service Tunnel**: `minikube service superset-service --url`
- **Credentials**: Varies by image version (try admin / admin)

### Monitor Deployment
```bash
# Check pod status
kubectl get pods -l app=superset

# View logs
kubectl logs -l app=superset

# Check configuration
kubectl describe configmap superset-config
```

### Clean Up
```bash
# Method 1: Using script (recommended)
./cleanup-superset.sh

# Method 2: Using kubectl commands
kubectl delete deployment superset
kubectl delete service superset-service
kubectl delete configmap superset-config
```

## Configuration

The `superset_config.py` file contains:
- Secret key for session management
- Additional Superset configuration options

Modify this file to customize your Superset installation.

## Production Notes

⚠️ **This setup is for development/learning purposes only**

For production deployment, consider:
- Using PostgreSQL or MySQL instead of SQLite
- Implementing proper authentication (LDAP, OAuth, etc.)
- Setting up SSL/TLS certificates
- Configuring proper caching (Redis)
- Setting up data source connections securely

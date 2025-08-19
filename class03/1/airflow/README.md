# Airflow Kubernetes Deployment

This directory contains the necessary files to deploy Apache Airflow on Kubernetes using Minikube.

## Files Overview

### YAML Configuration Files
- `airflow-deployment.yaml` - Kubernetes Deployment configuration for Airflow
- `airflow-service.yaml` - Kubernetes Service configuration (NodePort)

### Scripts
- `deploy-airflow.sh` - Automated deployment script
- `cleanup-airflow.sh` - Automated cleanup script

## Airflow Components

This deployment includes:
- **Webserver**: Provides the web UI interface
- **Scheduler**: Handles DAG execution and task scheduling  
- **SQLite Database**: Development database (not for production)
- **Sequential Executor**: Development executor (not for production)

## Usage

### Deploy Airflow
```bash
# Method 1: Using script (recommended)
./deploy-airflow.sh

# Method 2: Using kubectl commands
kubectl apply -f airflow-deployment.yaml
kubectl apply -f airflow-service.yaml
```

### Access Airflow
- **Direct**: http://$(minikube ip):30080
- **Service Tunnel**: `minikube service airflow-service --url`
- **Credentials**: admin / admin

### Monitor Deployment
```bash
# Check pod status
kubectl get pods -l app=airflow

# View webserver logs
kubectl logs -l app=airflow -c airflow-webserver

# View scheduler logs  
kubectl logs -l app=airflow -c airflow-scheduler
```

### Clean Up
```bash
# Method 1: Using script (recommended)
./cleanup-airflow.sh

# Method 2: Using kubectl commands
kubectl delete deployment airflow
kubectl delete service airflow-service
```

## Production Notes

⚠️ **This setup is for development/learning purposes only**

For production deployment, consider:
- Using PostgreSQL instead of SQLite
- Using CeleryExecutor or KubernetesExecutor
- Implementing proper persistence for DAGs and logs
- Setting up proper security and authentication

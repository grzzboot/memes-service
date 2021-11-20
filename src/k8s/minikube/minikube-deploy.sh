#!/bin/bash

ROOT_DIR=$(pwd)
MINIKUBE_DIR="${ROOT_DIR}/minikube"
MINIKUBE_SERVICE_ACCOUNT_DIR="$MINIKUBE_DIR/service-account"

#echo $ROOT_DIR
#echo $MINIKUBE_DIR
#echo $MINIKUBE_SERVICE_ACCOUNT_DIR

# Start and configure the Minikube
minikube start --driver=hyperkit --memory 8192 --cpus 4
minikube addons enable ingress
kubectl wait -n ingress-nginx --for=condition=Ready pod --field-selector=status.phase!=Succeeded --timeout=120s
minikube addons enable gcp-auth

KUBECTL_DIR="$ROOT_DIR/kubectl"
NAMESPACE_DIR="$KUBECTL_DIR/memes-namespace"
CONFIG_DIR="$KUBECTL_DIR/memes-config"

#echo $KUBECTL_DIR

# Create namespace, config and secret using kubectl
kubectl apply -f ${NAMESPACE_DIR}/namespace.yaml
minikube addons enable gcp-auth --refresh
kubectl apply -n memes -f ${CONFIG_DIR}/database-config.yaml
kubectl create secret generic -n memes database-credentials --from-env-file ${CONFIG_DIR}/database-credentials.env


KUSTOMIZE_DIR="$ROOT_DIR/kustomize"
KUSTOMIZE_MEMES_DIR="$KUSTOMIZE_DIR/memes-service"

# Create the memes-service using Kustomize, show outputs
kustomize build ${KUSTOMIZE_MEMES_DIR}

kustomize build ${KUSTOMIZE_MEMES_DIR} | kubectl apply -f -

#kustomize build ${KUSTOMIZE_MEMES_DIR} | kubectl delete -f -


HELM_DIR="$ROOT_DIR/helm"
HELM_DATABASE_DIR="$HELM_DIR/memes-database"

# Install a database using Helm3, show output and debug
helm3 repo add bitnami https://charts.bitnami.com/bitnami
helm3 repo update

helm3 upgrade --install memes-database bitnami/postgresql -n memes -f ${HELM_DATABASE_DIR}/values-memes.yaml --wait

# Create the memes-service using Helm, show outputs
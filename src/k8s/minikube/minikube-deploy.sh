#!/bin/bash

ROOT_DIR=$(pwd)
MINIKUBE_DIR="${ROOT_DIR}/minikube"
KUBECTL_DIR="$ROOT_DIR/kubectl"
NAMESPACE_DIR="$KUBECTL_DIR/memes-namespace"
CONFIG_DIR="$KUBECTL_DIR/memes-config"
KUSTOMIZE_DIR="$ROOT_DIR/kustomize"
KUSTOMIZE_MEMES_DIR="$KUSTOMIZE_DIR/memes-service"
HELM_DIR="$ROOT_DIR/helm"
HELM_DATABASE_DIR="$HELM_DIR/memes-database"
HELM_MEMES_DIR="$HELM_DIR/memes-service"

# Start and configure the Minikube
minikube start --driver=hyperkit --memory 8192 --cpus 4
minikube addons enable ingress
kubectl wait -n ingress-nginx --for=condition=Ready pod --field-selector=status.phase!=Succeeded --timeout=120s
minikube addons enable gcp-auth


# Create namespace, config and secret using kubectl
cat ${NAMESPACE_DIR}/namespace.yaml
kubectl apply -f ${NAMESPACE_DIR}/namespace.yaml

minikube addons enable gcp-auth --refresh

cat ${CONFIG_DIR}/database-config.yaml
kubectl apply -n memes -f ${CONFIG_DIR}/database-config.yaml

cat ${CONFIG_DIR}/database-credentials.env
kubectl create secret generic -n memes database-credentials --from-env-file ${CONFIG_DIR}/database-credentials.env


# Create the memes-service using Kustomize, show outputs
# kustomize build ${KUSTOMIZE_MEMES_DIR}
# kustomize build ${KUSTOMIZE_MEMES_DIR} | kubectl apply -f -
# kustomize build ${KUSTOMIZE_MEMES_DIR} | kubectl delete -f -


# Install a database using Helm3, show output and debug
helm3 repo add bitnami https://charts.bitnami.com/bitnami
helm3 repo update

helm3 upgrade --install memes-database bitnami/postgresql -n memes -f ${HELM_DATABASE_DIR}/values-memes.yaml --wait

# Create the memes-service using Helm, show outputs

helm3 upgrade --install memes-service ${HELM_MEMES_DIR} -n memes -f ${HELM_MEMES_DIR}/values-dev.yaml --wait

# Verify
# http://memes-dev.waymark.se/meme
#!/bin/bash

ROOT_DIR=$(pwd)

KUBECTL_DIR="$ROOT_DIR/kubectl"
NAMESPACE_DIR="$KUBECTL_DIR/memes-namespace"
CONFIG_DIR="$KUBECTL_DIR/memes-config"
HELM_DIR="$ROOT_DIR/helm"
HELM_NGINX_DIR="$HELM_DIR/ingress-nginx"
HELM_DATABASE_DIR="$HELM_DIR/memes-database"
HELM_MEMES_DIR="$HELM_DIR/memes-service"
EXTERNAL_IP=$(gcloud compute addresses list --format="value(address)")

# Create namespace, config and secret using kubectl
kubectl apply -f ${NAMESPACE_DIR}/namespace.yaml
kubectl apply -n memes -f ${CONFIG_DIR}/database-config.yaml
kubectl create secret generic -n memes database-credentials --from-env-file ${CONFIG_DIR}/database-credentials.env

# Install an Nginx ingress controller using Helm3, show output and debug
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm3 upgrade --install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx -f ${HELM_NGINX_DIR}/values-memes.yaml --set controller.service.loadBalancerIP=${EXTERNAL_IP} --create-namespace --wait
#kubectl wait -n ingress-nginx --for=condition=Ready pod --field-selector=status.phase!=Succeeded --timeout=120s

# Install a database using Helm3, show output and debug
helm3 repo add bitnami https://charts.bitnami.com/bitnami
helm3 repo update
helm3 upgrade --install memes-database bitnami/postgresql -n memes -f ${HELM_DATABASE_DIR}/values-memes-gcp.yaml --wait

# Create the memes-service using Helm, show outputs
helm3 upgrade --install memes-service ${HELM_MEMES_DIR} -n memes --wait

# Verify
# http://memes.waymark.se/meme
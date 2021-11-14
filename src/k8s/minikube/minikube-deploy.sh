#!/bin/bash

minikube start
minikube addons enable ingress

kubectl apply -f ../kubectl/memes-namespace/namespace.yaml
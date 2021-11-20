#!/bin/bash

# Create the GCP cluster (2 nodes)
gcloud beta container clusters create "memes-cluster"  \
	--project "pingpong-site1-gcp-demo" \
	--zone "europe-west3-a" \
	--no-enable-basic-auth \
	--cluster-version "1.21.5-gke.1302" \
	--release-channel "regular" \
	--machine-type "e2-medium" \
	--image-type "COS_CONTAINERD" \
	--disk-type "pd-standard" \
	--disk-size "100" \
	--metadata disable-legacy-endpoints=true \
	--scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
	--max-pods-per-node "110" \
	--num-nodes "2" \
	--enable-ip-alias \
	--network "projects/pingpong-site1-gcp-demo/global/networks/default" \
	--subnetwork "projects/pingpong-site1-gcp-demo/regions/europe-west3/subnetworks/default" \
	--no-enable-intra-node-visibility \
	--default-max-pods-per-node "110" \
	--no-enable-master-authorized-networks \
	--addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
	--enable-autoupgrade \
	--enable-autorepair \
	--max-surge-upgrade 1 \
	--max-unavailable-upgrade 0 \
	--enable-shielded-nodes \
	--node-locations "europe-west3-a"

# Allocate a public static IP
gcloud compute addresses create memes-external-static-ip \
	--project=pingpong-site1-gcp-demo \
	--network-tier=STANDARD \
	--region=europe-west3

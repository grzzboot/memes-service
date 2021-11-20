helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

helm3 upgrade --install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx -f values-memes.yaml --wait
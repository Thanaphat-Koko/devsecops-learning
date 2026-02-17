#!/bin/bash
set -e

PROJECT_ID="luminous-night-486607-c1"
CLUSTER_NAME="my-gke-cluster"
REGION="us-central1"
REPO_NAME="my-app-repo"

echo "========================================="
echo "  GKE Resource Cleanup Script"
echo "========================================="
echo ""
echo "This will delete the following resources:"
echo "  - Kubernetes deployments & services"
echo "  - GKE cluster: ${CLUSTER_NAME}"
echo "  - Artifact Registry repo: ${REPO_NAME}"
echo ""
read -p "Are you sure you want to continue? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Aborted."
  exit 0
fi

echo ""
echo "[1/3] Deleting Kubernetes resources..."
kubectl delete -f k8s/ --ignore-not-found 2>/dev/null || echo "  Skipped (kubectl not connected or no resources found)"

echo ""
echo "[2/3] Deleting GKE cluster: ${CLUSTER_NAME}..."
gcloud container clusters delete "$CLUSTER_NAME" \
  --location="$REGION" \
  --quiet

echo ""
echo "[3/3] Deleting Artifact Registry repo: ${REPO_NAME}..."
gcloud artifacts repositories delete "$REPO_NAME" \
  --location="$REGION" \
  --quiet

echo ""
echo "========================================="
echo "  Cleanup complete!"
echo "========================================="
echo ""
echo "All GKE resources have been removed."
echo "Your local code and Dockerfile are untouched."

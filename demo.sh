#!/usr/bin/env bash
# ==============================================================================
# DevOps PBL Demonstration Script (Linux / WSL / Ubuntu)
# Course: DevOps (24CYAEC59 / 25CYAEC59) - MSRIT
# ==============================================================================

set -e

echo -e "\033[1;36m==========================================================\033[0m"
echo -e "\033[1;36m  MSRIT DEVOPS PROJECT-BASED LEARNING AUTOMATION DEMO\033[0m"
echo -e "\033[1;36m==========================================================\033[0m"

# ── COMPONENT 1: CI Pipeline & Automated Testing ─────────────────────────────
echo -e "\n\033[1;33m[STEP 1] Running Automated Unit & Integration Tests (Jest)...\033[0m"
npm test

echo -e "\n\033[1;33m[STEP 2] Creating Production Package Artifact (npm pack)...\033[0m"
npm pack
mkdir -p dist && mv *.tgz dist/
ls -lh dist/

# ── COMPONENT 2: Docker Build & Verification ────────────────────────────────
echo -e "\n\033[1;33m[STEP 3] Building Multi-Stage Docker Image (nodeapp:1.0)...\033[0m"
docker build -t nodeapp:1.0 .

echo -e "\n\033[1;33m[STEP 4] Running Container Standalone & Testing Health Probe...\033[0m"
docker run -d --name nodeapp-demo -p 3000:3000 nodeapp:1.0
sleep 3
curl http://localhost:3000/health
docker rm -f nodeapp-demo

# ── COMPONENT 2: Ansible Playbook Syntax & Local Execution ──────────────────
echo -e "\n\033[1;33m[STEP 5] Checking Ansible Playbook Syntax...\033[0m"
if command -v ansible-playbook &> /dev/null; then
    ansible-playbook -i ansible/inventory/hosts ansible/site.yml --syntax-check
fi

# ── COMPONENT 2: Kubernetes Manifests Validation ─────────────────────────────
echo -e "\n\033[1;33m[STEP 6] Validating Kubernetes Manifests (Dry Run)...\033[0m"
if command -v kubectl &> /dev/null; then
    kubectl apply -f k8s/configmap.yaml --dry-run=client
    kubectl apply -f k8s/deployment.yaml --dry-run=client
    kubectl apply -f k8s/service.yaml --dry-run=client
fi

echo -e "\n\033[1;32m==========================================================\033[0m"
echo -e "\033[1;32m  ALL LOCAL DEMO CHECKS PASSED SUCCESSFULLY!\033[0m"
echo -e "\033[1;32m==========================================================\033[0m"

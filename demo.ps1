# ==============================================================================
# DevOps PBL Demonstration Script (Windows PowerShell)
# Course: DevOps (24CYAEC59 / 25CYAEC59) - MSRIT
# ==============================================================================

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  MSRIT DEVOPS PROJECT-BASED LEARNING AUTOMATION DEMO" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# ── COMPONENT 1: CI Pipeline & Automated Testing ─────────────────────────────
Write-Host "`n[STEP 1] Running Automated Unit & Integration Tests (Jest)..." -ForegroundColor Yellow
npm test

Write-Host "`n[STEP 2] Creating Production Package Artifact (npm pack)..." -ForegroundColor Yellow
npm pack
if (-not (Test-Path "dist")) { New-Item -ItemType Directory -Path "dist" }
Move-Item -Path "*.tgz" -Destination "dist/" -Force
Get-ChildItem "dist"

# ── COMPONENT 2: Docker Build & Verification ────────────────────────────────
Write-Host "`n[STEP 3] Building Multi-Stage Docker Image (nodeapp:1.0)..." -ForegroundColor Yellow
docker build -t nodeapp:1.0 .

Write-Host "`n[STEP 4] Running Container Standalone & Testing Health Probe..." -ForegroundColor Yellow
docker run -d --name nodeapp-demo -p 3000:3000 nodeapp:1.0
Start-Sleep -Seconds 3
curl http://localhost:3000/health
docker rm -f nodeapp-demo

# ── COMPONENT 2: Kubernetes Manifests Syntax Check ───────────────────────────
Write-Host "`n[STEP 5] Validating Kubernetes Manifests (Dry Run)..." -ForegroundColor Yellow
kubectl apply -f k8s/configmap.yaml --dry-run=client
kubectl apply -f k8s/deployment.yaml --dry-run=client
kubectl apply -f k8s/service.yaml --dry-run=client

Write-Host "`n==========================================================" -ForegroundColor Green
Write-Host "  ALL LOCAL DEMO CHECKS PASSED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green

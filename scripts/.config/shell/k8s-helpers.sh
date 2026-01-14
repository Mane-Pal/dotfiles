#!/bin/bash
# Kubernetes helper functions for kubectl/k9s workflow
# 
# Usage: Source this file in your shell rc file
#   source ~/.config/shell/k8s-helpers.sh
#
# Functions:
#   kctx      - Fuzzy find and switch kubectl context
#   kdb       - Port-forward to PostgreSQL services in *helm-ns namespaces
#   kpfkill   - List and kill active port-forward processes

# Switch kubectl context with fuzzy find
# Usage: kctx
kctx() {
  local context
  context=$(kubectl config get-contexts --no-headers | \
    fzf --header="Select kubectl context" \
        --preview='echo {}' \
        --preview-window=down:3:wrap | \
    awk '{print $2}')
  
  if [ -n "$context" ]; then
    kubectl config use-context "$context"
    echo "✓ Switched to context: $context"
    echo "  k9s will use this context on next launch"
  fi
}

# Database port-forward for PostgreSQL services in *helm-ns namespaces
# Usage: kdb [local_port]
# Default local port is 5432
kdb() {
  local local_port=${1:-5432}
  local namespace
  local service
  
  # Get all namespaces ending with helm-ns
  namespace=$(kubectl get namespaces --no-headers | \
    awk '{print $1}' | \
    grep 'helm-ns$' | \
    fzf --header="Select namespace for database port-forward")
  
  if [ -z "$namespace" ]; then
    echo "No namespace selected"
    return 1
  fi
  
  # Find PostgreSQL service in the selected namespace
  service=$(kubectl get services -n "$namespace" --no-headers 2>/dev/null | \
    grep -i 'postgres\|psql\|postgresql' | \
    fzf --header="Select PostgreSQL service in $namespace" \
        --preview="kubectl get service {} -n $namespace -o yaml" | \
    awk '{print $1}')
  
  if [ -z "$service" ]; then
    # If no postgres service found via grep, show all services
    service=$(kubectl get services -n "$namespace" --no-headers 2>/dev/null | \
      fzf --header="Select service in $namespace" \
          --preview="kubectl get service {} -n $namespace -o yaml" | \
      awk '{print $1}')
  fi
  
  if [ -n "$service" ]; then
    echo "Starting port-forward: localhost:$local_port -> $service:5432 (namespace: $namespace)"
    kubectl port-forward -n "$namespace" "svc/$service" "$local_port:5432"
  else
    echo "No service selected"
    return 1
  fi
}

# List and kill active port-forwards
# Usage: kpfkill
kpfkill() {
  local pids
  pids=$(ps aux | grep '[k]ubectl port-forward' | \
    fzf --multi \
        --header="Select port-forward processes to kill (TAB to select multiple)" \
        --preview='echo {}' \
        --preview-window=down:3:wrap | \
    awk '{print $2}')
  
  if [ -n "$pids" ]; then
    echo "$pids" | while read -r pid; do
      kill "$pid" 2>/dev/null && echo "✓ Killed port-forward process: $pid"
    done
  else
    echo "No processes selected"
  fi
}

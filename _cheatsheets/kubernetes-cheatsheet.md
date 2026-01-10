---
layout: cheatsheet
title: Kubernetes (K8s) Command Cheatsheet
description: Essential kubectl commands for Kubernetes cluster management
---


A comprehensive reference for Kubernetes and kubectl commands.

## kubectl Basics

### Configuration
```bash
kubectl version                      # Show client and server version
kubectl cluster-info                 # Display cluster info
kubectl config view                  # Show kubeconfig
kubectl config get-contexts          # List contexts
kubectl config current-context       # Show current context
kubectl config use-context <name>    # Switch context
kubectl config set-context --current --namespace=<ns>  # Set default namespace
```

## Pods

### Pod Operations
```bash
kubectl get pods                     # List pods in current namespace
kubectl get pods -A                  # List all pods in all namespaces
kubectl get pods -o wide             # List pods with more details
kubectl get pods --show-labels       # Show labels
kubectl get pods -l app=nginx        # Filter by label

kubectl describe pod <name>          # Show pod details
kubectl logs <pod>                   # Show pod logs
kubectl logs <pod> -f                # Follow logs
kubectl logs <pod> -c <container>    # Logs from specific container
kubectl logs <pod> --previous        # Logs from previous instance

kubectl exec -it <pod> -- /bin/bash  # Execute command in pod
kubectl exec <pod> -- ls /           # Run command in pod

kubectl delete pod <name>            # Delete pod
kubectl delete pods --all            # Delete all pods
```

### Pod Creation
```bash
kubectl run nginx --image=nginx      # Run pod
kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml  # Generate YAML
```

## Deployments

### Deployment Operations
```bash
kubectl get deployments              # List deployments
kubectl get deploy                   # Short form
kubectl describe deployment <name>   # Show deployment details

kubectl create deployment nginx --image=nginx  # Create deployment
kubectl create deployment nginx --image=nginx --replicas=3  # With replicas

kubectl scale deployment <name> --replicas=5  # Scale deployment
kubectl autoscale deployment <name> --min=2 --max=10 --cpu-percent=80  # Autoscale

kubectl set image deployment/<name> nginx=nginx:1.16  # Update image
kubectl rollout status deployment/<name>  # Check rollout status
kubectl rollout history deployment/<name>  # Show rollout history
kubectl rollout undo deployment/<name>  # Rollback deployment
kubectl rollout undo deployment/<name> --to-revision=2  # Rollback to specific revision

kubectl delete deployment <name>     # Delete deployment
```

## Services

### Service Operations
```bash
kubectl get services                 # List services
kubectl get svc                      # Short form
kubectl describe service <name>      # Show service details

kubectl expose deployment nginx --port=80 --type=NodePort  # Expose deployment
kubectl expose pod nginx --port=80 --type=ClusterIP  # Expose pod

kubectl delete service <name>        # Delete service
```

### Service Types
```yaml
# ClusterIP (default) - Internal only
# NodePort - External access via node IP
# LoadBalancer - External load balancer
# ExternalName - DNS CNAME record
```

## Namespaces

### Namespace Operations
```bash
kubectl get namespaces               # List namespaces
kubectl get ns                       # Short form
kubectl create namespace <name>      # Create namespace
kubectl delete namespace <name>      # Delete namespace

kubectl get pods -n <namespace>      # List pods in namespace
kubectl get all -n <namespace>       # List all resources in namespace
```

## ConfigMaps & Secrets

### ConfigMaps
```bash
kubectl get configmaps               # List configmaps
kubectl get cm                       # Short form
kubectl describe configmap <name>    # Show configmap details

kubectl create configmap <name> --from-literal=key=value  # From literal
kubectl create configmap <name> --from-file=config.txt  # From file
kubectl create configmap <name> --from-env-file=.env  # From env file

kubectl delete configmap <name>      # Delete configmap
```

### Secrets
```bash
kubectl get secrets                  # List secrets
kubectl describe secret <name>       # Show secret details

kubectl create secret generic <name> --from-literal=password=secret  # From literal
kubectl create secret generic <name> --from-file=ssh-privatekey=~/.ssh/id_rsa  # From file
kubectl create secret docker-registry <name> --docker-server=<server> --docker-username=<user> --docker-password=<pass>  # Docker registry

kubectl delete secret <name>         # Delete secret
```

## Volumes

### PersistentVolumes
```bash
kubectl get pv                       # List persistent volumes
kubectl get pvc                      # List persistent volume claims
kubectl describe pv <name>           # Show PV details
kubectl describe pvc <name>          # Show PVC details

kubectl delete pvc <name>            # Delete PVC
```

## Nodes

### Node Operations
```bash
kubectl get nodes                    # List nodes
kubectl get nodes -o wide            # List nodes with details
kubectl describe node <name>         # Show node details
kubectl top node                     # Show node resource usage

kubectl cordon <node>                # Mark node as unschedulable
kubectl uncordon <node>              # Mark node as schedulable
kubectl drain <node>                 # Drain node for maintenance
kubectl drain <node> --ignore-daemonsets --delete-emptydir-data  # Force drain

kubectl label node <node> key=value  # Add label to node
kubectl taint node <node> key=value:NoSchedule  # Add taint
```

## Resource Management

### Apply & Create
```bash
kubectl apply -f file.yaml           # Apply configuration
kubectl apply -f directory/          # Apply all files in directory
kubectl apply -f https://url/file.yaml  # Apply from URL

kubectl create -f file.yaml          # Create from file
kubectl delete -f file.yaml          # Delete from file

kubectl replace -f file.yaml         # Replace resource
kubectl replace --force -f file.yaml # Force replace
```

### Get Resources
```bash
kubectl get all                      # Get all resources
kubectl get all -A                   # Get all in all namespaces
kubectl get <resource>               # Get specific resource type
kubectl get <resource> <name>        # Get specific resource
kubectl get <resource> -o yaml       # Output as YAML
kubectl get <resource> -o json       # Output as JSON
kubectl get <resource> -o wide       # Output with more details
```

## Labels & Selectors

### Label Operations
```bash
kubectl label pod <pod> env=prod     # Add label
kubectl label pod <pod> env=dev --overwrite  # Update label
kubectl label pod <pod> env-         # Remove label

kubectl get pods -l env=prod         # Select by label
kubectl get pods -l 'env in (prod,dev)'  # Multiple values
kubectl get pods -l env!=prod        # Not equal
```

## Troubleshooting

### Debug Commands
```bash
kubectl describe <resource> <name>   # Detailed resource info
kubectl logs <pod>                   # Pod logs
kubectl logs <pod> --previous        # Previous pod logs
kubectl logs -l app=nginx            # Logs from pods with label

kubectl exec -it <pod> -- sh         # Shell into pod
kubectl exec <pod> -- env            # Show environment variables

kubectl port-forward <pod> 8080:80   # Forward port
kubectl port-forward svc/<service> 8080:80  # Forward service port

kubectl top pod                      # Pod resource usage
kubectl top node                     # Node resource usage

kubectl get events                   # Show events
kubectl get events --sort-by=.metadata.creationTimestamp  # Sorted events
```

### Resource Inspection
```bash
kubectl explain pod                  # Show pod specification
kubectl explain pod.spec             # Show pod spec details
kubectl explain deployment.spec.template.spec.containers  # Nested fields
```

## YAML Manifests

### Pod YAML
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```

### Deployment YAML
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

### Service YAML
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
```

## Shortcuts

### Resource Abbreviations
```bash
po  = pods
deploy = deployments
svc = services
ns  = namespaces
no  = nodes
cm  = configmaps
pv  = persistentvolumes
pvc = persistentvolumeclaims
sa  = serviceaccounts
rs  = replicasets
ds  = daemonsets
sts = statefulsets
ing = ingresses
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `kubectl get pods` | List pods |
| `kubectl describe pod <name>` | Pod details |
| `kubectl logs <pod>` | Pod logs |
| `kubectl exec -it <pod> -- sh` | Shell into pod |
| `kubectl apply -f file.yaml` | Apply config |
| `kubectl delete pod <name>` | Delete pod |
| `kubectl get svc` | List services |
| `kubectl get nodes` | List nodes |
| `kubectl scale deploy <name> --replicas=3` | Scale deployment |
| `kubectl rollout undo deploy/<name>` | Rollback |

## Common Patterns

### Create Deployment
```bash
kubectl create deployment nginx --image=nginx:latest
kubectl expose deployment nginx --port=80 --type=LoadBalancer
kubectl scale deployment nginx --replicas=3
```

### Update Deployment
```bash
kubectl set image deployment/nginx nginx=nginx:1.16
kubectl rollout status deployment/nginx
kubectl rollout history deployment/nginx
```

### Debug Pod
```bash
kubectl describe pod <pod>
kubectl logs <pod>
kubectl exec -it <pod> -- sh
kubectl get events --field-selector involvedObject.name=<pod>
```

## Tips

1. **Use aliases** for common commands
2. **Always specify namespace** or set default
3. **Use labels** for organization
4. **Check logs** when troubleshooting
5. **Use dry-run** to generate YAML
6. **Learn selectors** for filtering
7. **Monitor resource usage** with top
8. **Use kubectl explain** for documentation
9. **Version control** your YAML files
10. **Test in dev** before production

## Resources

- Official Documentation: https://kubernetes.io/docs/
- kubectl Cheat Sheet: https://kubernetes.io/docs/reference/kubectl/cheatsheet/
- Kubernetes by Example: https://kubernetesbyexample.com/
- Play with Kubernetes: https://labs.play-with-k8s.com/

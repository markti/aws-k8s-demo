# aws-k8s-demo

Get the credentials for your EKS cluster so you can connect using `kubectl`

```
aws eks update-kubeconfig --name eks-fleet-portal-dev
```

Verify connectivity by checking on the nodes

```
kubectl get nodes
```

Check that the ALB load balancer ingress controller is deployed:

```
kubectl get deployments -n kube-system
```
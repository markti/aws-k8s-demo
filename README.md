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
kubectl get deployments -n ingress-nginx
```

Check that the front end pods are running:

```
kubectl get pods -n app
```

Elastic Load Balancing
https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html

https://aws.amazon.com/elasticloadbalancing/features/

Secrets Manager
https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_csi_driver.html

https://github.com/aws/secrets-store-csi-driver-provider-aws
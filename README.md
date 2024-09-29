# aws-k8s-demo

# Welcome

This codebase is a sample solution from the book [Mastering Terraform](https://amzn.to/3XNjHhx). This codebase is the solution from Chapter 8 where Soze Enterprises is deploying their solution with Docker and Kubernetes using AWS Elastic Kubernetes Service (EKS). It includes container configuration with Docker, and both infrastructure and Kubernetes configuration using Terraform.

## Docker Code

The Docker code is stored in two `Dockerfile` files for both the `frontend` and another for the `backend`. As with convention, the `Dockerfile` for the corresponding application code is stored in the root folder of the application code which is stored in `src\dotnet`.

## Terraform Code

The Terraform code is stored in `src\terraform`. However, there are two root modules. One for the AWS infrastructure that leverages the `aws` provider in the `src\terraform\infra` folder and another for the Kubernetes configuration that leverages the `kubernetes` and `helm` Terraform providers residing in the `src\terraform\k8s` folder.

### AWS Infrastructure
The Terraform root module that provisions the AWS infrastructure will provision both an AWS Elastic Container Registry, an Elastic Kubernetes Service (EKS) cluster and all surrounding resources. The Elastic Container Registry is required in order to build and publish the Docker images.

You may need to change the `primary_region` input variable value if you wish to deploy to a different region. The default is `us-west-2`.

You will need to update the input variable value `ecr_image_pushers` to include the IAM Username that you setup to publish Docker Images.

You can optionally include your IAM User in the `admin_users` to make it easier to investigate the environment.

### Kubernetes Configuration

After you build Docker Images you will need to update the input variables `web_app_image` and `web_api_image` to reference the correct Docker image tag.

If you want to provision more than one environment you may need to remove the `environment_name` input variable value and specify an additional environment `tfvar` file.

## GitHub Actions Workflows

### Docker Workflows
There are two GitHub Actions workflows that use Docker to build and push the container images. These need to be executed after Terraform has been used to provision the AWS infrastructure.

### Terraform Workflows
The directory `.github/workflows/` contains GitHub Actions workflows that implement a CI/CD solution using Docker and Terraform. There are individual workflows for the three Terraform core workflow operations `plan`, `apply`, and `destroy`.

# Pre-Requisites

## AWS IAM Setup

In order for GitHub Actions workflows to execute you need to have an identity that they can use to access AWS. Therefore you need to setup a new User in AWS IAM for both the Terraform and Packer workflows. In addition, for each App Registration you should create a Client Secret to be used to authenticate.

The IAM User's Access and Secret Keys need to be set as Environment Variables in GitHub. They should be stored in a GitHub environment Variable `AWS_ACCESS_KEY_ID` and it's client Secret stored in `AWS_SECRET_ACCESS_KEY`.

## AWS Setup

### IAM User Role Assignments

The IAM User created in the previous step needs to be granted `Administrator` access to your AWS Account.

### S3 Bucket for Terraform State

Lastly you need to setup an S3 Bucket that can be used to store Terraform State. You need to create an S3 Bucket called `terraformer0000`. Replace the four (4) zeros (i.e., `0000`) with a four (4) digit random number.

### GitHub Configuration

You need to add the following environment variables:

- AWS_ACCESS_KEY_ID
- BUCKET_NAME
- BUCKET_REGION

You need to add the following secrets:

- AWS_SECRET_ACCESS_KEY
- SSH_PUBLIC_KEY

## Kubernetes Cheat Sheet

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

Check the pod to see if the secrets are accessible from the environment variable.
```
kubectl -n app exec -it fleet-api-67646d7db4-58l8n -- sh
```

Elastic Load Balancing
https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html

https://aws.amazon.com/elasticloadbalancing/features/

Secrets Manager
https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_csi_driver.html

https://github.com/aws/secrets-store-csi-driver-provider-aws
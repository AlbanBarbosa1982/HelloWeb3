# Automated Build, Push, and Deployment to GKE with GitHub Actions

This repository orchestrates an automated process for building a Docker image, pushing it to Google Artifact Registry (GAR), and deploying it to a Google Kubernetes Engine (GKE) cluster utilizing Helm and Terraform, streamlined through GitHub Actions.

## Repository Structure Overview

The repository is organized as follows, providing a clear overview of its key components:

```
├── Dockerfile              # Defines the Docker image for the application.
├── README.md               # Documentation of the repository and deployment process.
├── app.js                  # The main application file for a Node.js application.
├── helm                    # Contains Helm charts for deploying the application to Kubernetes.
│   └── helloWeb3           # A Helm chart specifically for this application.
├── package-lock.json       # Automatically generated file for exact versions of npm dependencies.
├── package.json            # Manages project dependencies and configurations.
├── terraform               # Terraform configurations for the infrastructure setup.
│   ├── gke.tf              # Configuration for the Google Kubernetes Engine cluster.
│   ├── provider.tf         # Terraform provider configuration for Google Cloud.
│   ├── serviceaccount.tf   # Configuration for the service account.
│   └── vpc.tf              # Configuration for the Virtual Private Cloud networking.
```
### Setup Infrastructure

The first job, `setup-infrastructure`, prepares the environment for the deployment. It includes the following steps:

- **Checkout code**: This step checks out the repository code.
- **Set up Cloud SDK**: This step sets up the Google Cloud SDK with the necessary credentials.
- **Configure Docker for Artifact Registry**: This step configures Docker to use the Artifact Registry.
- **Setup Terraform**: This step sets up Terraform with the specified version.
- **Terraform Init**: This step initializes Terraform in the specified directory.
- **Terraform Refresh**: This step updates the Terraform state file to match the real resources.
- **Terraform Apply**: This step applies the Terraform configuration, creating or updating the infrastructure as needed.

### Build and Deploy

The second job, `build-and-deploy`, depends on the successful completion of `setup-infrastructure`. It includes the following steps:

- **Checkout**: This step checks out the repository code.
- **Setup Google Cloud credentials (Again for Docker Push)**: This step sets up the Google Cloud credentials again for Docker push.
- **Configure Docker and Build Image**: This step builds the Docker image and tags it with the specified image tag.
- **Push Docker Image to GAR**: This step pushes the Docker image to the Google Artifact Registry.
- **Install Helm**: This step installs Helm, a package manager for Kubernetes.
- **Install gke-gcloud-auth-plugin**: This step installs the `gke-gcloud-auth-plugin` which is required for `kubectl` to authenticate with GKE.
- **Get GKE credentials and set KUBECONFIG**: This step retrieves the credentials for the GKE cluster and sets the `KUBECONFIG` environment variable.
- **Helm Deploy**: This step deploys the application to the GKE cluster using Helm.

# Build, Deploy to GCP with Terraform and Helm

This repository contains a GitHub Actions workflow that automates the process of bilding a Docker image, pushing it to Google Artifact Registry (GAR), and deploying it to a Google Kubernetes Engine (GKE) ucluster using Helm and Terraform.

## Endpoints

- Application: [http://35.195.160.119:3000/](http://35.195.160.119:3000/)
- Prometheus Metrics: [http://35.195.160.119:3000/metrics](http://35.195.160.119:3000/metrics)
- Prometheus: [http://34.76.172.49:9090/graph](http://34.76.172.49:9090/graph)
- Grafana: [https://35.241.149.229:3000/](https://35.241.149.229:3000/)



## Train of Thought

A lot off work but also pretty cool to do. I started with a bucket for the terraform state by hand and via ci/cd got my infra up and running. Some roles I first added by hand in servcice account and later made via terrafom. I got the two application endpoints up and running just as Prometheus. After too much time this weekend I could not get tls for grafana working so I could also not configure Grafana in the end due to time. Mainly been struggeling with TLS lets encrypt the last moments. I would worked on it further but now busy with normal work so no more time anymore.


## Improvements

- TLS certificates everywhere
- helm deployment split over multiple files. Now Grafana contains to much
- ingress instead of the loadbalancers
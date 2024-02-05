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
## Workflow Overview

The workflow is triggered on every push to the `main` branch.

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

## Train of Thought

(You can fill this section with your thoughts on the workflow.)

## Improvements

(You can fill this section with potential improvements for the workflow.)
# Build, Deploy to GCP with Terraform and Helm

This repository contains a GitHub Actions workflow that automates the process of building a Docker image, pushing it to Google Artifact Registry (GAR), and deploying it to a Google Kubernetes Engine (GKE) cluster using Helm and Terraform.

## Workflow Overview

The workflow is triggered on every push to the `main` branch.

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

## Train of Thought

(You can fill this section with your thoughts on the workflow.)

## Improvements

(You can fill this section with potential improvements for the workflow.)

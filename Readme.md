# Raspbian Cluster
[![CI for Counter](https://github.com/Yggdrasill501/rasbian_cluster/actions/workflows/go.yml/badge.svg)](https://github.com/Yggdrasill501/rasbian_cluster/actions/workflows/go.yml)
<br>
This mock project demonstrates deploying a Kubernetes cluster on Raspberry Pi 4 devices. The project leverages modern DevOps tools and practices to manage the infrastructure and deploy applications efficiently.

## Technologies Used

- **[Kubernetes](https://kubernetes.io/)**: Orchestrates the deployment, scaling, and management of containerized applications across the Raspberry Pi cluster.
- **[ArgoCD](https://argoproj.github.io/argo-cd/)**: Implements GitOps for continuous delivery, automating application deployment and management.
- **[Helm](https://helm.sh/)**: Manages Kubernetes applications as Helm charts, allowing for easy packaging, configuration, and deployment.
- **[Terraform](https://www.terraform.io/)**: Automates infrastructure provisioning, including Kubernetes resources and other infrastructure components.
- **[Prometheus](https://prometheus.io/)**: Collects and stores metrics, providing observability into the cluster's performance.
- **[Grafana](https://grafana.com/)**: Visualizes metrics and data collected by Prometheus, enabling monitoring and alerting.
- **[Go](https://golang.org/)**: The backend server is implemented in Go, providing a performant and efficient service.
- **[HTMX](https://htmx.org/)**: The frontend is built using HTMX, allowing for dynamic content updates without the need for a full JavaScript framework.

## Project Overview

The project consists of several components:

- **Raspberry Pi 4 Kubernetes Cluster**: A Kubernetes cluster running on Raspberry Pi 4 devices, set up using Kubernetes, Docker, and other essential tools.
- **ArgoCD & GitOps**: ArgoCD is used to continuously deploy and manage applications on the Kubernetes cluster, following GitOps principles.
- **Infrastructure Management with Terraform**: Terraform is employed to manage and provision Kubernetes resources, ensuring a consistent and reproducible setup.
- **Monitoring with Prometheus and Grafana**: The cluster is monitored using Prometheus, with Grafana providing visualization dashboards for real-time insights.
- **Go Backend**: A server implemented in Go that manages visitor data, interacting with Redis as the data store.
- **HTMX Frontend**: A simple, dynamic frontend that interacts with the Go backend to display visitor data.

**Set Up Raspberry Pi Cluster**: Follow the instructions in the [`docs/SETUP_CLUSTER.md`](./docs/SETUP_CLUSTER.md) file to set up the Kubernetes cluster on your Raspberry Pi 4 devices.
<br>
**Build and Push Docker Images**: Build Docker images for the `counter_backend` and `redis_backend` applications and push them to your Docker registry.
<br>
**Deploy Applications**: Use Terraform to deploy the applications onto the Kubernetes cluster, as detailed in [`docs/DEPLOYMENT_GUIDE.md`](./docs/DEPLOYMENT_GUIDE.md).
<br>
**Monitor the Cluster**: Set up Prometheus and Grafana to monitor the cluster and visualize its metrics.
<br>

## Contributing
Contributions to this project are welcome! If you have any suggestions or improvements, please feel free to open an issue or submit a pull request.

## License
This project is licensed under the MIT License. See the [`LICENSE`](./LICENSE) file for more details.

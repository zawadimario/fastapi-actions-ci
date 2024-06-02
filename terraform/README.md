### Deployment

**Disclaimer**: These steps were performed in a local Minikube cluster and so to use these configuration files requires one to modify them according to the target cluster information. To run in your Minikube cluster, obtain our cluster information and populate it in the `terraform.tfvars` file or configure the path to kubeconfig. In my case `"~/.kube/config"`

```
kubectl config view
```

Modify the Terraform workspace setup files according to your cluster and apply the Terraform configuration.

Steps:

Change to terraform directory where the workspace will be initialized.

```
cd terraform
```

Initialize Terraform workspace.

```
terraform init
```

Apply terraform configuration.

```
terraform apply
```
Type `yes` when prompted.

### Cleanup workspace

Destroy the resources you created. Confirm with `yes` when prompted

```
terraform destroy
```

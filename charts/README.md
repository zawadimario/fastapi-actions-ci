## Helm Charts

### Prerequisites
1. A running Kubernetes cluster
2. Helm is installed on the machine
3. Docker Desktop (optional but must have when building the image)

Assuming the above prerequisites are met, clone this repository and proceed to the next step.

```
git clone https://github.com/zawadimario/take-home-assignment-mf.git
```
Change the working directory

```
cd take-home-assignment-mf
```

When testing this application locally, build the required image and replace the tag in [`values.yaml`](./charts/values.yaml) before installing the charts. Alternatively, pull the image hosted in [ 'DockerHub' ](https://hub.docker.com/r/zawadimario/sample-api/tags). 

### Build the image
Run the following commands from the project root directory.

```
docker build -t sample-api:v1 .
```
Edit the [`values.yaml`](./charts/values.yaml) file to replace the image name and tag appropriately.

### Install the Charts

You may choose to install in the default namespace or create a dedicated namespace. Use the default namespace for simplicity.

```
helm install release-name ./charts
```

Check the status of the installed charts and K8s pods. Follow the post-install command Notes that will be displayed on the terminal.

Expose the application in the best way you want. With kubectl you may simply port-forward the k8s service.

```
kubectl port-forward svc/service-name 8000:8000
```
### Cleanup

Uninstall the charts.

```
helm uninstall release-name
```

Delete the image.

```
docker rmi -f sample-api:v1
```

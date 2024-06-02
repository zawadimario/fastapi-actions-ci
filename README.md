# Sample ML API
### Prerequisites
1. Kubernetes v1.24+
2. Helm v3
3. Docker
4. Python v3.9
5. Minikube (optional if running on cloud or other environments)
6. CT Chart Testing tool. See here https://github.com/helm/chart-testing
7. Terraform

### Introduction
This project consists of a source code for building a simple ML API that utilizes the Python FastAPI library to create an API service that prints `Hello world` when called. The Application code is hosted in the `app` directory. Running the application locally requires Python3.9, but note that the other versions have not been tested, so there are no limitations on versions or guarantees. Feel free to try it out.

To run the application, create the Python virtual environment first, then install the requirements from the root directory.

```
python3 -m venv venv

source venv/bin/activate

pip3 install -r requirements.txt

```
Assuming the above steps run successfully, start the app by running the following.

```
python3 -m uvicorn app:main:app --reload --host 0.0.0.0 --port 8000
```
Or run it from the `app` directory.

```
python3 -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```
Use CTRL+C to terminate the process in a clean way.

Access the API Swagger page at http://localhost:8000/docs or use curl from your favourite command terminal to call the API with `curl -l 'http://localhost:8000'`

### Quickstart
There are two approaches to installing this Helm chart locally.

1. Build the required image and replace `image.repository` and `image.tag` values in the [`values.yaml`](./charts/values.yaml) accordingly to match the image you built.
2. Replace the above values with the appropriate image name if it exists in a public repository.

Clone the repository and proceed to the next step.

Installing this helm chart is easy. Ensure the `Release Namespace` exists in your target cluster or create one.

Run the following to install the helm chart from the project root directory substituting the `release-name` and `release-namespace` with actual values.

```
helm install my-release ./charts -n release-namespace
```

Alternatively, one can pass configuration data during installation by specifying name=value overrides using the `--set` command argument. For example
```
helm install my-release ./charts -n release-namespace --set replicaCount=4
```
To revert this action run
```
helm upgrade my-release ./charts -n release-namespace --reset-values
```
The API endpoint for this application is exposed via a Kubernetes service created during deployment. Obtain the service name with `kubectl` with the command below. Again here use valid `release-name` and `release-namespace`.

```
kubectl get svc -n release-namespace | grep my-release
```
Expose the endpoint and call it with curl from another terminal or using any API client like Postman

```
kubectl port-forward -n release-namespace svc/my-release-mlapi-svc 8000

# Call the API

 curl -l 'http://localhost:8000'
```
OR access the Swagger page at http://localhost:8080/docs

### Install with Terraform

Please follow the [README.md](https://github.com/zawadimario/take-home-assignment-mf/tree/main/terraform#deployment) documentation. 

**Note:** This method requires at least a kubernetes cluster, terraform, Helm and Docker.

### GitHub Actions Workflows

This project includes three workflow definition that perform various tasks leveraging GitHub Actions triggered by configured events.

1. [`Linting and testing`](./.github/workflows/lint-test.yml) checks for any alignment, or indentation mistakes in the charts, and performs helm install in a dynamically created Kind K8s cluster.
2. [`Image builder`](./.github/workflows/build-image.yaml) workflow that utilizes docker to build the image and publish it to DockerHub repository.
3. [`Chart Releaser`](./.github/workflows/release.yml) workflow uses chart-releaser action to find any changes in the project, especially in the [`charts`](./charts) directory. The workflow, based on changes, creates a release tag and deployment and finally publishes the chart release to the `gh-pages` branch.

### Environment Variables and Secrets

It's indispensably important to employ best practices, and most importantly when it comes to sensitive information. Moving secrets contained in the source code across the repository branches and systems e.g., remote runners, poses serious implications. Running the above workflows use the following among others:
```
GITHUB_TOKEN
GITHUB_ACTOR
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN
GITHUB_REF
DEPLOY_TAG_NAME
````
Note, however, that, `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`, `GITHUB_ACTOR` and `GITHUB_TOKEN` are considered sensitive and are usually redacted during workflow runs. 

`DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets are manually created by the user (who has admin permissions to the project repo) by navigating to the repository **Settings>Secrets and Variables>Actions**. By clicking **New repository secret** button, one can add one or more secrets. Once created, they are referenced in the source code in the format `"${{ secrets.SECRET_NAME }}"`. 

Similarly, other secrets can be created and referenced as environment secrets in the source code or workflow scripts. This is a secure way of utilizing secrets and it makes them portable and reusable across the project.

### Cleanup

Uninstall the charts and delete the image.

```
helm uninstall release-name

docker rmi -f image-name
```

### Links and References

LinkedIn: https://www.linkedin.com/in/zawadiomari/

GitHub Actions: [text](https://github.com/actions)


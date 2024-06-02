# Hello World ML API

This is a sample ML API that only prints out "Hello world" when the endpoint is called. 

The application uses FastAPI library and uvicorn to implement ASGI web server for this ML API. 

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
Use CTRL+C to terminate the process cleanly.

Access the API Swagger page at http://localhost:8000/docs or use curl from your favourite command terminal to call the API with `curl -l 'http://localhost:8000'`

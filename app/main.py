from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import logging
import traceback

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Serve application
app = FastAPI(title="Simple ML API", version="0.0.1")

# Implement Middleware for CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins="*",
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/home")
async def root():
    return {"message": "Hello, World!"}

@app.get("/debug")
async def debug_log():
    try:
        return {"message": "Debug endpoint"}
    except Exception as e:
        logger('error', f"An error occured: {traceback.format_exc()}")

@app.get("/error")
async def error_log():
    try:
        output = 1 / 0
    except Exception as e:
        logger('error', f"An error occured: {traceback.format_exec()}")
        return {"error": "An error occured"}

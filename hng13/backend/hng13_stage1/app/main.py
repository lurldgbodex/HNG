from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from app.routers.router import router as string_router

app = FastAPI(
    title="String Analyzer API",
    description="A Restful API that analyzes strings and stores their computed properties",
    version="1.0.0"
)

app.include_router(string_router, prefix='/strings', tags=['Strings'])


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    errors = exc.errors()

    if any(
            err["type"] == "missing" and "value" in err["loc"]
            for err in errors
    ) or any(err["type"] == "missing" and err["loc"] == ("body",) for err in errors):
        return JSONResponse(
            status_code=400,
            content={"detail": 'Invalid request body or missing "value" field'}
        )

    if any(
            err["type"].startswith("string_type") or "value_error.str" in err["type"]
            or ("value" in err["loc"] and "string_type" in err["type"])
            or (err.get("msg", "").lower().startswith("input should be a valid string"))
            for err in errors
    ):
        return JSONResponse(
            status_code=422,
            content={"detail": 'Invalid data type for "value" (must be string)'}
        )

    if any("query" in err["loc"] for err in errors):
        return JSONResponse(
            status_code=400,
            content={"detail": "Invalid query parameter values or types"}
        )

    raise exc

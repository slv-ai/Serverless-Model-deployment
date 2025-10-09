
FROM public.ecr.aws/lambda/python:3.9

# Add uv binary from multi-stage build
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy dependency definitions
COPY pyproject.toml uv.lock ./

# Export dependencies and install via uv (no process substitution)
RUN uv export --format=requirements-txt | uv pip install --system -r /dev/stdin

# Add app code
COPY lambda_function.py model.bin ./

# Lambda handler entrypoint
CMD ["lambda_function.lambda_handler"]

FROM python:3.9.7-slim
# Copy the 'uv' and 'uvx' executables from the latest uv image into /bin/ in this image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
WORKDIR /code
# Add the virtual environment's bin directory to the PATH so Python tools work globally
ENV PATH="/code/.venv/bin:$PATH"
#copy project configuration files
COPY ".python-version"  "pyproject.toml"  "uv.lock" ./
# Install dependencies exactly as locked in uv.lock, without updating them
RUN uv sync --locked
COPY "predict.py" "model.bin" ./
EXPOSE 9696
ENTRYPOINT ["uvicorn","predict:app","--host","0.0.0.0","--port","9696"]
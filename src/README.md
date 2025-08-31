# Model deployment with FASTAPI AND UV

1. turn the starter notebook into script using:
```
jupyter nbconvert --to=script starter.ipynb
mv starter.py train.py
```
2. install dependencies
```
pip install requests fastapi uvicorn
```
3. run python predict.py,then
FastAPI generates OpenAPI docs automatically at /docs ,it exposes all api endpoints
```
http://localhost:9696/docs
```
input and output validation available in fastapi, then run python test.py to get predictions
4. uv - environment and dependency management tool(faster tool)
install uv:
```
pip install uv
```
Initialize the project:
```
uv init
```
```
uv add scikit-learn==1.2.0 fastapi uvicorn
```
uv have a development dependency --  won't need it in production
```
uv add --dev requests
```
Run in virtual environment by prefix with uv run:
````
uv run uvicorn predict:app --host 0.0.0.0 --port 9696 --reload
uv run python test.py
````
if a project already uses uv then install all the dependencies using the sync command:
```
uv sync
```
5. create Docker file
```
docker build -t churnpredict .
```
```
docker run -it --rm -p 9696:9696 churnpredict
```
6. deployment with lambda and ecr


# Getting Started

## Kotlin

## Run Application

### Build Docker

```docker build -t che/demoservice .```

### Run Docker Locally

```docker run -p 8080:8080 che/demoservice```

### Push to repo

```
docker login --username username

docker tag che/demoservice username/my-repo

docker push username/my-repo
```

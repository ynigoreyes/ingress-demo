# Ingress Demo

This demo uses GCP's load balancers as an Ingress controller so that you don't have to
worry about setting one up from scratch. Just provide the Ingress resource and you are good to go.

The hardest part about this demo was debugging it and making sure that my routing works

Only complaint is that the ingress takes a while to really start up and map all the requests
properly. It was hard to debug when it took the ingress several minutes to find my services.

1. Make sure `kubectl`, `docker`, and `gcloud` are updated on your terminal

```
$ kubectl version
// Client Version: version.Info{Major:"1", Minor:"12", GitVersion:"v1.12.2", GitCommit:"17c77c7898218073f14c8d573582e8d2313dc740", GitTreeState:"clean", BuildDate:"2018-10-30T21:39:16Z", GoVersion:"go1.11.1", Compiler:"gc", Platform:"darwin/amd64"}
// Server Version: version.Info{Major:"1", Minor:"11+", GitVersion:"v1.11.7-gke.4", GitCommit:"618716cbb236fb7ca9cabd822b5947e298ad09f7", GitTreeState:"clean", BuildDate:"2019-02-05T19:22:29Z", GoVersion:"go1.10.7b4", Compiler:"gc", Platform:"linux/amd64"}

$ gcloud -v
// Google Cloud SDK 239.0.0
// etc...

$ docker -v
// Docker version 18.06.1-ce, build e68fc7a
```
2. Create a cluster on GKE
```
$ gcloud container cluster create
```

3. Create services with TCP endpoints
  - TIP: You want `*/` to return a 200 status code. Otherwise, your health checks will not work
  - You want to make nested and unique routes. Example...
    - Service A: has an endpoint at `/` and one on `/client/info`
    - Service B: has an endpoint at `/` and one on `/api/info`
    - This is so that the ingress can differentiate more easily where to route your requests

4. Use a `Makefile` to build and push your code. Checkout my example

5. Create the Deployments and Services for your apps
  - TIP: `<SERVICE_NAME>_SERVICE_PORT` is passed to your deployment from `spec.selector` attributes
  - TIP: In Deployments, you can open up ports in your containers using `spec.template.containers.ports.containerPort`
  - Make sure that you app uses the environment variables above so that you can open any port given to you

6. Pay attention to the Ingress routes...
  - The ingress routes do not take away anything from the endpoint. Do not treat the ingress as a parent router.
  - An ingress works like a reverse-proxy (usually is one). it looks at the endpoint and then passes it on the matching service
  - This is why nested routes will make it easy to differentiate what route should go where

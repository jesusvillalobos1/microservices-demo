<!-- [![Build Status](https://travis-ci.org/microservices-demo/microservices-demo.svg?branch=master)](https://travis-ci.org/microservices-demo/microservices-demo)

# Sock Shop : A Microservice Demo Application

The application is the user-facing part of an online shop that sells socks. It is intended to aid the demonstration and testing of microservice and cloud native technologies.

It is built using [Spring Boot](http://projects.spring.io/spring-boot/), [Go kit](http://gokit.io) and [Node.js](https://nodejs.org/) and is packaged in Docker containers.

You can read more about the [application design](./internal-docs/design.md).

## Deployment Platforms

The [deploy folder](./deploy/) contains scripts and instructions to provision the application onto your favourite platform. 

Please let us know if there is a platform that you would like to see supported.

## Bugs, Feature Requests and Contributing

We'd love to see community contributions. We like to keep it simple and use Github issues to track bugs and feature requests and pull requests to manage contributions. See the [contribution information](.github/CONTRIBUTING.md) for more information.

## Screenshot

![Sock Shop frontend](https://github.com/microservices-demo/microservices-demo.github.io/raw/master/assets/sockshop-frontend.png)

## Visualizing the application

Use [Weave Scope](http://weave.works/products/weave-scope/) or [Weave Cloud](http://cloud.weave.works/) to visualize the application once it's running in the selected [target platform](./deploy/).

![Sock Shop in Weave Scope](https://github.com/microservices-demo/microservices-demo.github.io/raw/master/assets/sockshop-scope.png)

##  -->


<h3 id="clone-the-microservices-demo-repo">Clone the microservices-demo repo</h3>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>git clone https://github.com/microservices-demo/microservices-demo
cd microservices-demo
</code></pre></div></div>

<h3 id="start-minikube">Start Minikube</h3>

<p>You can start Minikube by running:</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>minikube start --memory 4200 --cpus 4
</code></pre></div></div>

<h3 id="deploy-sock-shop">Deploy Sock Shop</h3>

<p>Deploy the Sock Shop application on Minikube</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>kubectl create -f deploy/kubernetes/manifests
</code></pre></div></div>

<p>Wait for all the Sock Shop services to start:</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>kubectl get pods --namespace="sock-shop"
</code></pre></div></div>
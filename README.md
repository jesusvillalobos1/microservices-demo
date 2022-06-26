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

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  </head>
  <body>

 
<div class="header-home"><a href="/">Sock Shop</a></div>



<p>This demo demonstrates running the Sock Shop app on Minikube.
<br>Originally forked from microservices-demo/microservices-demo.
<br>Modifications were made to create cluster in Minikube, deploy Sock-Shop app and monitoring tools (Prometheus and Grafana)
</p>

<p>Optionally you can run the script "shock_shop_with_prom.sh" to create the cluster with everything deployed and skip the instructions below.</p>

<h3 id="pre-requisites">Pre-requisites</h3>
<ul>
  <li>Install <a href="https://github.com/kubernetes/minikube">Minikube</a></li>
  <li>Install <a href="http://kubernetes.io/docs/user-guide/prereqs/">kubectl</a></li>
</ul>

<h3 id="clone-the-microservices-demo-repo">Clone the microservices-demo repo</h3>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>git clone https://github.com/microservices-demo/microservices-demo
cd microservices-demo
</code></pre></div></div>

<h3 id="start-minikube">Start Minikube</h3>

<p>You can start Minikube by running:</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>minikube start --memory 4200 --cpus 4
</code></pre></div></div>

<p>Check if it’s running with <code class="highlighter-rouge">minikube status</code>, 
<br>and make sure the Kubernetes dashboard is running on http://minikubeIP:30000 
<br>(use the command "minikube ip" to find the IP in use by minikube)</p>

<p>Approximately 4 GB of RAM is required to run all the services.</p>

<!-- <h5 id="optional-run-with-fluentd--elk-based-logging"><em>(Optional)</em> Run with Fluentd + ELK based logging</h5>

<p>If you want to run the application using a more advanced logging setup based on Fluentd + ELK stack, there are 2 requirements:</p>
<ul>
  <li>assign at least 6 GB of memory to the minikube VM</li>
  <li>increase vm.max_map_count to 262144 or higher (Required because Elasticsearch will not start if it detects a value lower than 262144).</li>
</ul>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>minikube delete
minikube config set memory 6144
minikube start
minikube ssh
</code></pre></div></div>

<p>Once logged into the VM:</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>$ sudo sysctl -w vm.max_map_count=262144
</code></pre></div></div>

<p>After these settings are done you can start the logging manifests.</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>kubectl create -f deploy/kubernetes/manifests-logging
</code></pre></div></div>

<p>You should be able to see the Kibana dashboard at http://192.168.99.100:31601.</p> -->

<h3 id="deploy-sock-shop">Deploy Sock Shop</h3>

<p>Deploy the Sock Shop application on Minikube</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>kubectl create -f deploy/kubernetes/manifests
</code></pre></div></div>

<p>Wait for all the Sock Shop services to start:</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>kubectl get pods --namespace="sock-shop"
</code></pre></div></div>

<p>Incredibly useful command to find the URL of the services that are running:</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>minikube service list
</code></pre></div></div>

<h3 id="check-the-sock-shop-webpage">Check the Sock Shop webpage</h3>

<p>Once the application is deployed, navigate to http://minikubeIP:30001 to see the Sock Shop home page.</p>

<h3 id="run-tests">Run tests</h3>

<p>There is a separate load-test available to simulate user traffic to the application. For more information see <a href="#loadtest">Load Test</a>.
<br>This will send some traffic to the application, which will form the connection graph that you can view in Scope or Weave Cloud. 
<br>You should
also check what ip your minikube instance has been assigned and use that in the load test.</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>minikube ip
docker run --rm weaveworksdemos/load-test -d 5 -h minikubeIP:30001 -c 2 -r 100
</code></pre></div></div>

<h3 id="uninstall-the-sock-shop-application">Uninstall the Sock Shop application</h3>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>kubectl delete -f deploy/kubernetes/manifests/sock-shop-ns.yaml -f deploy/kubernetes/manifests
</code></pre></div></div>

<p>If you don’t need the Minikube instance anymore you can delete it by running:</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>minikube delete
</code></pre></div></div>


<br>
<br>

<div class="col-sm-9">
            <h2 id="kubernetes">Monitoring</h2>
<p>To deploy Prometheus &amp; Grafana and to setup all the nice graphs that we got ready
for you, simply:</p>

<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>$ kubectl create -f ./deploy/kubernetes/manifests-monitoring
</code></pre></div></div>

<p>Assuming that used <code class="highlighter-rouge">minikube</code> to deploy your Kubernetes cluster, to get the URL of
the services:</p>

<h4 id="prometheus">Prometheus</h4>
<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>$ minikube service list | grep prometheus
| monitoring  | prometheus           | http://192.168.99.100:31090 |
</code></pre></div></div>

<h4 id="grafana">Grafana</h4>
<div class="highlighter-rouge"><div class="highlight"><pre class="highlight"><code>$ minikube service list | grep grafana
| monitoring  | grafana              | http://192.168.99.100:31300 |
</code></pre></div></div>

  </body>
</html>



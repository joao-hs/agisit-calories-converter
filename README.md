# agisit24-g10

## Calories Converter
This is a simple web application based on microservices. In the webpage we may convert the weights of a specific food to their caloric value.

## Installation
Make sure to have the following tools installed in your computer:
- Docker
- Docker Compose

## Usage
- Locally
```bash
docker compose up --build
```
- Cloud
> Follow the instructions in `vagrant/README.md`

## Authors and acknowledgment
Simão Silva\
João Sereno\
Beatriz Matias

## Project status
According to the project statement:
- [x] Frontend: the entry point (ingress) that exposes an HTTP server (serving the Web site);
- [x] Backend services: provide the desired functionalities;
- [x] ObjectStore/Cache/Database: data storage;
- [x] Monitoring Server: provides insight over the system.
- [x] Continuous Integration (CI) / Continuous Deployment (CD) pipeline for the Web Microservices-based Application

## Future work / Optional Improvements
- [ ] (Ops) Improve traceability by aggregating application logs to a Grafana dashboard
- [ ] (App) Improve project codebase growth by making the reverse-proxy redirect requests based on the food category rather than on the food name
- [ ] (Ops) Improve and standardize logging mechanisms accross the microservices
- [ ] (App) Re-design and implement application logic to support microservice replication
- [ ] (Ops) Devise autoscalling and load balancing properties 
# Warehouse API

Ruby 2.6.2

Rails 5.2.3

Postgres

Postman

## Requirements
    
 - Docker or Rbenv with Ruby 2.6.2

## Getting started
    
Clone the project from github:
```
$ git clone https://github.com/almgandre/warehouse.git
```

Open the project folder:

```
$ cd warehouse
```
 
-----
### Setup with Docker:

- Build the Docker image
```
$ docker-compose build
```

- Start the application
```
$ docker-compose up
```

- Setup the Database

```
$ docker-compose run web rake db:setup
```

- Access the application

```
http://localhost:3000
```
See postman collection [here](#postman-collection)

- To run tests:

```
$ docker-compose run web bundle exec rspec
```

-----
### Setup with Rbenv:


- Create database

```
$ createdb myapp_development
```

- Setup

```
$ bin/setup
```

- Access the application

```
http://localhost:3000
```
See postman collection [here](#postman-collection)

- To run tests:

```
$ bundle exec rspec
```

-----
## Postman collection

At Postman, import the collection from `docs/Warehouse.postman_collection.json`


-----
## Request URLS

```
GET /products
GET /products?name=:name
GET /products/:id
POST /products
PUT /products/:id
DELETE /products/:id
```

___
By André Barbosa
almgandre@gmail.com
 
 
 
 

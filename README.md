# README

An approach on how to parse and save 2 different payloads with 1 API endpoint

## API Endpoints
| HTTP Method | Endpoint               | Description                            |
|-------------|------------------------|----------------------------------------|
| GET         | /reservations          | Get a list of Reservations             |
| POST        | /reservations          | Create a new Reservation               |
| GET         | /reservations/:id      | Get details of a specific Reservation  |

## Prerequisites
- Ruby (3.2.2)
- Ruby on Rails (7.0.7)
- PostgreSQL

## Setup
```
rails db:create
rails db:migrate
rails start
```

## Docker
```
docker compose build
docker compose up -d
```

## Postman settings
- In the Headers, set `'Accept' => 'application/json'` to show json error payloads


## Testing
```
rails test
```

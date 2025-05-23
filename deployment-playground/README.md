# Deployment playground

You can use this playground to test this project under the same conditions as in production.

```
$ docker compose build
$ docker compose run --rm app load-seed-data
Start data model migration…
Data model migration completed
Start load seed data...
seed data loaded

$ docker compose up -d --wait
```

Open your browser on http://localhost:3000

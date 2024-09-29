```bash
docker compose -f docker-compose-elk.yml -f extensions/fleet/fleet-compose.yml -f extensions/fleet/agent-apmserver-compose.yml -f docker-compose.yml up --build
docker compose -f docker-compose-elk.yml -f extensions/fleet/fleet-compose.yml -f extensions/fleet/agent-apmserver-compose.yml -f docker-compose.yml up setup
./run rails db:setup
```

* Kibana app -> http://localhost:5601/app/home#/
* Rails with Nginx as proxy -> http://localhost:8000/
* Admin page for Rails app -> http://localhost:8000/admin/products

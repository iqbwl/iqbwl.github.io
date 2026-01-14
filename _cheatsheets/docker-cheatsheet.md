---
layout: cheatsheet
title: Docker Command Cheatsheet
description: Essential Docker commands for container management
---

{% raw %}


A comprehensive reference for Docker commands and best practices.

## Container Management

### Running Containers
```bash
docker run image                          # Run container
docker run -d image                       # Run in detached mode
docker run -it image bash                 # Run with interactive terminal
docker run --name mycontainer image       # Run with custom name
docker run -p 8080:80 image              # Map port 8080 to container port 80
docker run -v /host:/container image      # Mount volume
docker run -e VAR=value image            # Set environment variable
docker run --rm image                     # Remove container after exit
```

### Container Lifecycle
```bash
docker start container                    # Start stopped container
docker stop container                     # Stop running container
docker restart container                  # Restart container
docker pause container                    # Pause container
docker unpause container                  # Unpause container
docker kill container                     # Force stop container
docker rm container                       # Remove container
docker rm -f container                    # Force remove running container
```

### Container Information
```bash
docker ps                                 # List running containers
docker ps -a                              # List all containers
docker ps -q                              # List container IDs only
docker inspect container                  # Detailed container info
docker logs container                     # View container logs
docker logs -f container                  # Follow container logs
docker logs --tail 100 container          # Show last 100 lines
docker top container                      # Show running processes
docker stats                              # Show resource usage
docker stats container                    # Show specific container stats
```

### Container Interaction
```bash
docker exec -it container bash            # Execute bash in container
docker exec container command             # Execute command in container
docker attach container                   # Attach to running container
docker cp container:/path /host/path      # Copy from container
docker cp /host/path container:/path      # Copy to container
```

## Image Management

### Image Operations
```bash
docker images                             # List images
docker images -a                          # List all images (including intermediate)
docker pull image:tag                     # Pull image from registry
docker push image:tag                     # Push image to registry
docker build -t name:tag .               # Build image from Dockerfile
docker build -t name:tag -f Dockerfile .  # Build with specific Dockerfile
docker tag image:tag newname:newtag       # Tag image
docker rmi image                          # Remove image
docker rmi -f image                       # Force remove image
```

### Image Information
```bash
docker inspect image                      # Detailed image info
docker history image                      # Show image layers
docker search keyword                     # Search Docker Hub
```

### Image Cleanup
```bash
docker image prune                        # Remove unused images
docker image prune -a                     # Remove all unused images
docker system prune                       # Remove all unused data
docker system prune -a                    # Remove all unused data (aggressive)
docker system prune --volumes             # Include volumes in cleanup
```

## Docker Compose

### Compose Commands
```bash
docker-compose up                         # Start services
docker-compose up -d                      # Start in detached mode
docker-compose up --build                 # Rebuild and start
docker-compose down                       # Stop and remove containers
docker-compose down -v                    # Also remove volumes
docker-compose start                      # Start existing containers
docker-compose stop                       # Stop containers
docker-compose restart                    # Restart containers
docker-compose pause                      # Pause services
docker-compose unpause                    # Unpause services
```

### Compose Information
```bash
docker-compose ps                         # List containers
docker-compose logs                       # View logs
docker-compose logs -f                    # Follow logs
docker-compose logs service               # Logs for specific service
docker-compose top                        # Show running processes
docker-compose config                     # Validate and view config
```

### Compose Execution
```bash
docker-compose exec service bash          # Execute bash in service
docker-compose exec service command       # Execute command in service
docker-compose run service command        # Run one-off command
docker-compose build                      # Build services
docker-compose pull                       # Pull service images
```

## Networking

### Network Commands
```bash
docker network ls                         # List networks
docker network create network             # Create network
docker network create --driver bridge net # Create with specific driver
docker network rm network                 # Remove network
docker network inspect network            # Inspect network
docker network connect network container  # Connect container to network
docker network disconnect network container # Disconnect container
docker network prune                      # Remove unused networks
```

### Network Types
```bash
# Bridge (default)
docker network create --driver bridge my-bridge

# Host (use host network)
docker run --network host image

# None (no networking)
docker run --network none image

# Custom network
docker run --network my-network image
```

## Volume Management

### Volume Commands
```bash
docker volume ls                          # List volumes
docker volume create volume               # Create volume
docker volume rm volume                   # Remove volume
docker volume inspect volume              # Inspect volume
docker volume prune                       # Remove unused volumes
```

### Volume Usage
```bash
# Named volume
docker run -v myvolume:/data image

# Bind mount
docker run -v /host/path:/container/path image

# Anonymous volume
docker run -v /container/path image

# Read-only volume
docker run -v myvolume:/data:ro image
```

## Registry & Repository

### Docker Hub
```bash
docker login                              # Login to Docker Hub
docker logout                             # Logout
docker search ubuntu                      # Search images
docker pull ubuntu:20.04                  # Pull specific tag
docker push username/image:tag            # Push to Docker Hub
```

### Private Registry
```bash
docker login registry.example.com         # Login to private registry
docker tag image registry.example.com/image # Tag for private registry
docker push registry.example.com/image    # Push to private registry
docker pull registry.example.com/image    # Pull from private registry
```

## Dockerfile Best Practices

### Common Instructions
```dockerfile
FROM ubuntu:20.04                         # Base image
LABEL maintainer="email@example.com"      # Metadata
WORKDIR /app                              # Set working directory
COPY . /app                               # Copy files
ADD file.tar.gz /app                      # Copy and extract
RUN apt-get update && apt-get install -y  # Run commands
ENV NODE_ENV=production                   # Set environment variable
EXPOSE 8080                               # Expose port
VOLUME /data                              # Create volume mount point
USER appuser                              # Switch user
CMD ["npm", "start"]                      # Default command
ENTRYPOINT ["docker-entrypoint.sh"]       # Entry point script
```

### Multi-stage Build
```dockerfile
# Build stage
FROM node:16 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM node:16-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package*.json ./
RUN npm install --production
CMD ["node", "dist/index.js"]
```

## Docker System

### System Information
```bash
docker version                            # Show Docker version
docker info                               # Show system info
docker system df                          # Show disk usage
docker system events                      # Show real-time events
```

### System Cleanup
```bash
docker container prune                    # Remove stopped containers
docker image prune                        # Remove unused images
docker volume prune                       # Remove unused volumes
docker network prune                      # Remove unused networks
docker system prune                       # Remove all unused objects
docker system prune -a --volumes          # Aggressive cleanup
```

## Debugging & Troubleshooting

### Debugging Commands
```bash
docker logs container                     # Check logs
docker logs --since 30m container         # Logs from last 30 minutes
docker inspect container                  # Detailed info
docker exec -it container sh              # Interactive shell
docker top container                      # Running processes
docker stats container                    # Resource usage
docker events                             # Real-time events
```

### Health Checks
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
```

```bash
docker inspect --format='{{.State.Health.Status}}' container
```

## Useful Tips

### Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
```

### Quick Cleanup
```bash
# Remove all stopped containers
docker rm $(docker ps -aq)

# Remove all unused images
docker rmi $(docker images -q -f dangling=true)

# Stop all running containers
docker stop $(docker ps -q)

# Remove everything (use with caution!)
docker system prune -a --volumes -f
```

### Docker Compose Example
```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "8080:80"
    volumes:
      - ./app:/app
    environment:
      - NODE_ENV=production
    depends_on:
      - db
  db:
    image: postgres:13
    volumes:
      - db-data:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=secret
volumes:
  db-data:
```

## Security Best Practices

1. **Use official images** from trusted sources
2. **Scan images** for vulnerabilities: `docker scan image`
3. **Run as non-root** user when possible
4. **Use specific tags** instead of `latest`
5. **Minimize layers** in Dockerfile
6. **Don't store secrets** in images
7. **Use .dockerignore** to exclude files
8. **Keep images updated** regularly
9. **Limit container resources** with `--memory` and `--cpus`
10. **Use read-only filesystems** when possible: `--read-only`

## Docker Swarm

### Swarm Management
```bash
docker swarm init                         # Initialize swarm
docker swarm join --token <token> <ip>:2377 # Join swarm as worker/manager
docker swarm join-token worker            # View worker join token
docker swarm join-token manager           # View manager join token
docker swarm leave                        # Leave swarm (worker)
docker swarm leave --force                # Leave swarm (manager)
docker swarm update --autolock=true       # Enable autolock
docker swarm unlock                       # Unlock swarm
```

### Node Management
```bash
docker node ls                            # List nodes
docker node inspect <node>                # Inspect node
docker node ps <node>                     # List tasks on node
docker node promote <node>                # Promote worker to manager
docker node demote <node>                 # Demote manager to worker
docker node update --availability drain <node> # Drain node
docker node update --availability active <node> # Activate node
docker node rm <node>                     # Remove node
```

### Service Management
```bash
docker service create --name <name> <image> # Create service
docker service ls                         # List services
docker service ps <service>               # List tasks of service
docker service inspect <service>          # Inspect service
docker service logs <service>             # View service logs
docker service scale <service>=<replicas> # Scale service
docker service update --image <image> <service> # Update service image
docker service update --publish-add <port> <service> # Add port mapping
docker service rollback <service>         # Rollback service
docker service rm <service>               # Remove service
```

### Stack Management
```bash
docker stack deploy -c <file> <name>      # Deploy stack
docker stack ls                           # List stacks
docker stack services <stack>             # List services in stack
docker stack ps <stack>                   # List tasks in stack
docker stack rm <stack>                   # Remove stack
```

### Secrets & Configs
```bash
docker secret create <name> <file>        # Create secret
docker secret ls                          # List secrets
docker secret inspect <name>              # Inspect secret
docker secret rm <name>                   # Remove secret
docker config create <name> <file>        # Create config
docker config ls                          # List configs
docker config inspect <name>              # Inspect config
docker config rm <name>                   # Remove config
```

## Resources

- Official Documentation: https://docs.docker.com
- Docker Hub: https://hub.docker.com
- Best Practices: https://docs.docker.com/develop/dev-best-practices/
{% endraw %}

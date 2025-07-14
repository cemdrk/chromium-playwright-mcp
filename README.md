
# Chromium Playwright MCP

A containerized solution that provides a Chromium browser with Playwright MCP (Model Context Protocol) server for automated web interactions and testing.

## Overview

This project sets up two Docker containers:
- **Browser**: Chromium browser with remote debugging enabled
- **MCP Server**: Playwright MCP server that connects to the browser via Chrome DevTools Protocol

## Quick Start

### Using Docker Compose

```bash
docker compose up
```

### Using Makefile

```bash
# Start all services
make up

# Start specific service
make up-mcp
make up-browser

# Stop all services
make down

# Stop specific service
make down-mcp
make down-browser

# Build images
make build

# View logs
make logs
```

This will start both services:
- Chromium browser UI accessible at `http://localhost:3000`
- MCP server running on port `8000`

## Architecture

### Services

#### Browser Container
- **Base**: LinuxServer Chromium
- **Ports**: 
  - `3000`: Browser UI interface (HTTP)
  - `3001`: Browser UI interface (HTTPS)
- **Features**: 
  - Remote debugging on port `9222`
  - Nginx proxy for DevTools on port `9330`

#### MCP Container
- **Base**: Node.js 22 (Current LTS)
- **Package**: `@playwright/mcp`
- **Connection**: Connects to browser via `http://browser:9330`
- **Port**: Exposes MCP server on port `9000` (mapped to host `8000`)

## Configuration

### MCP Client Configuration

For Windsurf or other MCP-compatible clients:

```json
{
    "mcpServers": {
        "playwright": {
            "serverUrl": "http://localhost:8000/sse"
        }    
    }
}
```

### Environment Variables

The browser container supports these environment variables:
- `PUID=1000`: User ID
- `PGID=1000`: Group ID  
- `TZ=Europe/Istanbul`: Timezone
- `CHROME_CLI=--remote-debugging-port=9222`: Chrome command line arguments

## Usage

1. Start the services:
   ```bash
   # Using Docker Compose
   docker compose up -d
   
   # Using Makefile
   make up
   
   # Start only specific service
   make up-browser  # Just the browser
   make up-mcp      # Just the MCP server
   ```

2. Access the browser UI at `http://localhost:3000`

3. Connect your MCP client to `http://localhost:8000/sse`

4. Use Playwright commands through the MCP interface to automate the browser

## Development

### Building Images

```bash
# Build all services
docker compose build

# Build specific service
docker compose build browser
docker compose build mcp
```

### Logs

```bash
# View all logs
docker compose logs

# Follow logs for specific service
docker compose logs -f mcp
```

## Security Notes

- Services are bound to `127.0.0.1` for local access only
- Remote debugging is enabled for automation purposes

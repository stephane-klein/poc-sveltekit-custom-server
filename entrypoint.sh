#!/bin/sh

set -e

COMMAND=${1:-""}

case "$COMMAND" in
    "serve")
        node --loader esm-module-alias/loader --no-warnings build/server.js
        ;;
    
    "load-seed-data")
        node --loader esm-module-alias/loader --no-warnings src/load-seed-data.js
        ;;
    
    "")
        echo "❌ No command specified"
        echo "Usage: $0 [serve|load-seed-data|other-command]"
        echo ""
        echo "Available commands:"
        echo "  serve           - Start the server"
        echo "  load-seed-data  - Load seed data"
        echo "  [other]         - Execute custom command"
        exit 1
        ;;
    
    *)
        exec "$@"
        ;;
esac

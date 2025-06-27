#!/bin/bash

echo "📦 Preparing BrainBrawler frontend for Railway.app deployment..."

# Create build info
echo "{\"buildTime\": \"$(date)\", \"version\": \"1.0.0\", \"environment\": \"production\", \"platform\": \"railway\"}" > build-info.json

# Update API endpoints for Railway.app
echo "🔧 Configuring API endpoints for Railway.app..."

# For Railway, use environment variable for API URL or default to backend service
API_BASE_URL=${API_BASE_URL:-"http://backend:3000"}

# Update all HTML files to use Railway configuration
find . -name "*.html" -type f -exec sed -i "s|const API_BASE = .*|const API_BASE = '${API_BASE_URL}';|g" {} \;

echo "✅ Frontend build completed successfully for Railway.app!"
echo "📁 Static files ready for deployment"
echo "🔗 API Base URL: ${API_BASE_URL}" 
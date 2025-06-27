#!/bin/bash

echo "📦 Preparing BrainBrawler frontend for production deployment..."

# Create build info
echo "{\"buildTime\": \"$(date)\", \"version\": \"1.0.0\", \"environment\": \"production\"}" > build-info.json

# Update API endpoints for production
echo "🔧 Configuring API endpoints for production..."

# Update all HTML files to use dynamic API detection
find . -name "*.html" -type f -exec sed -i 's|const API_BASE = `http://.*`;|const API_BASE = `https://${window.location.hostname.replace("app", "api")}`;|g' {} \;

echo "✅ Frontend build completed successfully!"
echo "📁 Static files ready for deployment"
echo "🌐 API will connect to: brainbrawler-api.onrender.com" 
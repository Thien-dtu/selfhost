#!/bin/bash

echo "🌐 Checking public IP..."
MY_IP=$(curl -s https://api.ipify.org)
echo "🌍 Your current public IP: $MY_IP"

echo ""
echo "🔄 Getting DuckDNS IP..."
DUCK_IP=$(dig +short thienpro.duckdns.org @1.1.1.1)
echo "🦆 DuckDNS IP: $DUCK_IP"

if [ "$MY_IP" = "$DUCK_IP" ]; then
  echo "✅ DuckDNS is up-to-date."
else
  echo "⚠️  DuckDNS is NOT pointing to your current IP!"
fi

echo ""
echo "🐳 Checking running Docker containers..."
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

echo ""
echo "🧪 Checking if ports 80 and 443 are being used by Nginx Proxy Manager..."
docker ps | grep npm | grep '80->80' && echo "✅ Port 80 is OK." || echo "❌ Port 80 NOT found!"
docker ps | grep npm | grep '443->443' && echo "✅ Port 443 is OK." || echo "❌ Port 443 NOT found!"

echo ""
echo "🔎 Checking if anything else is using port 80 or 443..."
sudo lsof -iTCP:80 -sTCP:LISTEN -nP || echo "✅ Port 80 not used by others"
sudo lsof -iTCP:443 -sTCP:LISTEN -nP || echo "✅ Port 443 not used by others"

echo ""
echo "✅ Done. If all ✅ are green, your setup is good."


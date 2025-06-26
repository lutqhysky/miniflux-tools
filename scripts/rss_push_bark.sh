#!/bin/bash

# 加载环境变量
source "$(dirname "$0")/../.env"

if [[ -z "$API_TOKEN" || -z "$MINIFLUX_URL" || -z "$BARK_URL" ]]; then
  echo "❌ 请先填写 .env 文件中的 MINIFLUX_URL、API_TOKEN、BARK_URL"
  exit 1
fi

entries=$(curl -s -H "X-Auth-Token: $API_TOKEN" "$MINIFLUX_URL/v1/entries?status=unread&direction=desc&limit=10")

echo "$entries" | jq -c '.entries[] | select(.title | contains("福利汇总"))' | while read -r entry; do
    title=$(echo "$entry" | jq -r '.title')
    url=$(echo "$entry" | jq -r '.url')
    entry_id=$(echo "$entry" | jq -r '.id')

    push_url="${BARK_URL}/$(echo "$title" | jq -sRr @uri)/$(echo "$url" | jq -sRr @uri)"
    curl -s "$push_url" > /dev/null

    curl -s -X PUT -H "X-Auth-Token: $API_TOKEN" "$MINIFLUX_URL/v1/entries/$entry_id/read" > /dev/null

    echo "✅ 已推送：$title"
done

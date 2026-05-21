#!/bin/bash
#
# 构建 PPP 定制版 Presenton 镜像
# 包含中文字体支持
#
# 使用方式:
#   cd presenton
#   bash build-ppp.sh
#
# 构建完成后启动:
#   docker run -d --name presenton -p 5000:80 \
#     -e LLM=custom \
#     -e CUSTOM_LLM_URL=https://aiop-gateway.item.com/proxy/openai/v1 \
#     -e "CUSTOM_LLM_API_KEY=YOUR_KEY" \
#     -e CUSTOM_MODEL=gpt-5.1 \
#     -e AUTH_USERNAME=admin \
#     -e AUTH_PASSWORD=admin123 \
#     -e DISABLE_IMAGE_GENERATION=true \
#     -v "./app_data:/app_data" \
#     presenton-ppp:latest

set -e

echo "🔨 构建 PPP 定制版 Presenton 镜像..."
echo "   - 基于 Presenton 源码"
echo "   - 增加中文字体 (Noto CJK + WenQuanYi)"
echo ""

docker build \
  -f Dockerfile.ppp \
  -t presenton-ppp:latest \
  --progress=plain \
  .

echo ""
echo "✅ 构建完成: presenton-ppp:latest"
echo ""
echo "启动命令:"
echo '  docker run -d --name presenton -p 5000:80 \'
echo '    -e LLM=custom \'
echo '    -e CUSTOM_LLM_URL=https://aiop-gateway.item.com/proxy/openai/v1 \'
echo '    -e "CUSTOM_LLM_API_KEY=YOUR_KEY" \'
echo '    -e CUSTOM_MODEL=gpt-5.1 \'
echo '    -e AUTH_USERNAME=admin \'
echo '    -e AUTH_PASSWORD=admin123 \'
echo '    -e DISABLE_IMAGE_GENERATION=true \'
echo '    -v "./app_data:/app_data" \'
echo '    presenton-ppp:latest'

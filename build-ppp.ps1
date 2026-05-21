#
# 构建 PPP 定制版 Presenton 镜像
# 包含中文字体支持
#
# 使用方式:
#   cd presenton
#   .\build-ppp.ps1
#

Write-Host "🔨 构建 PPP 定制版 Presenton 镜像..." -ForegroundColor Cyan
Write-Host "   - 基于 Presenton 源码"
Write-Host "   - 增加中文字体 (Noto CJK + WenQuanYi)"
Write-Host ""

docker build -f Dockerfile.ppp -t presenton-ppp:latest .

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ 构建完成: presenton-ppp:latest" -ForegroundColor Green
    Write-Host ""
    Write-Host "启动命令:" -ForegroundColor Yellow
    Write-Host @"
docker run -d --name presenton -p 5000:80 `
  -e LLM=custom `
  -e CUSTOM_LLM_URL=https://aiop-gateway.item.com/proxy/openai/v1 `
  -e "CUSTOM_LLM_API_KEY=YOUR_KEY" `
  -e CUSTOM_MODEL=gpt-5.1 `
  -e AUTH_USERNAME=admin `
  -e AUTH_PASSWORD=admin123 `
  -e DISABLE_IMAGE_GENERATION=true `
  -v "${PWD}\app_data:/app_data" `
  presenton-ppp:latest
"@
} else {
    Write-Host "❌ 构建失败" -ForegroundColor Red
}

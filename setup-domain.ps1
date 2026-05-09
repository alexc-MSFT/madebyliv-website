# Made by Liv — Domain Setup Script
# Run this once DNS has propagated (test with: nslookup www.madebyliv.art 8.8.8.8)

Write-Host "Checking DNS propagation..." -ForegroundColor Cyan
$result = nslookup www.madebyliv.art 8.8.8.8 2>&1
if ($result -match "Non-existent") {
    Write-Host "DNS not propagated yet. Try again later." -ForegroundColor Yellow
    exit 1
}

Write-Host "DNS is live! Linking domains to Azure..." -ForegroundColor Green

# Link www subdomain
Write-Host "`nAdding www.madebyliv.art..." -ForegroundColor Cyan
az staticwebapp hostname set --name swa-madebyliv --resource-group rg-madebyliv --hostname www.madebyliv.art -o table

# Link root domain
Write-Host "`nAdding madebyliv.art (root)..." -ForegroundColor Cyan
Write-Host "Azure will provide a TXT record value. Add it in GoDaddy as:" -ForegroundColor Yellow
Write-Host "  Type: TXT  |  Name: @  |  Value: (shown below)" -ForegroundColor Yellow
az staticwebapp hostname set --name swa-madebyliv --resource-group rg-madebyliv --hostname madebyliv.art -o table

Write-Host "`nDone! Your site should be live at https://madebyliv.art" -ForegroundColor Green

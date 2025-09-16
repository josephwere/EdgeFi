# PowerShell script to download vendor installers into 'installers' folder
$installers = @(
  @{ url = "https://nodejs.org/dist/v18.20.2/node-v18.20.2-x64.msi"; outfile = "node-v18.20.2-x64.msi" },
  @{ url = "https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-community-8.0.40.0.msi"; outfile = "mysql-installer-community-8.0.40.0.msi" },
  @{ url = "https://github.com/tporadowski/redis/releases/download/v7.2.4/redis-7.2.4.zip"; outfile = "redis-7.2.4.zip" },
  @{ url = "https://nginx.org/download/nginx-1.26.2.zip"; outfile = "nginx-1.26.2.zip" }
)

$dest = Join-Path $PSScriptRoot "installers"
if (!(Test-Path $dest)) { New-Item -ItemType Directory -Path $dest | Out-Null }

foreach ($item in $installers) {
  $url = $item.url
  $out = Join-Path $dest $item.outfile
  Write-Host "Downloading $url -> $out"
  try {
    Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
    Write-Host "Downloaded $out"
  } catch {
    Write-Host "Failed to download $url : $_"
  }
}
Write-Host "Done. Check the 'installers' folder."

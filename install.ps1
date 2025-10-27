<#
.SYNOPSIS
  Aplica ícones personalizados para a Lixeira (vazia/cheia) no Windows 11,
  SEM qualquer código de refresh do Explorer.

.PARAMETER EmptyIcon
.\2.ico

.PARAMETER FullIcon
.\1.ico
#>

param(
  [Parameter(Mandatory=$true)]
  [string]$EmptyIcon,
  [Parameter(Mandatory=$true)]
  [string]$FullIcon
)

$ErrorActionPreference = 'Stop'

function Assert-Icon {
  param([string]$Path, [string]$Label)
  if (-not (Test-Path -LiteralPath $Path)) { throw "Arquivo não encontrado: $Label -> $Path" }
  if ([IO.Path]::GetExtension($Path).ToLowerInvariant() -ne ".ico") {
    throw "$Label deve ser um .ico: $Path"
  }
}

# 1) Normalizar e validar
$EmptyIcon = (Resolve-Path -LiteralPath $EmptyIcon).Path
$FullIcon  = (Resolve-Path -LiteralPath $FullIcon).Path
Assert-Icon $EmptyIcon "EmptyIcon"
Assert-Icon $FullIcon  "FullIcon"

# 2) Pasta de trabalho (para manter ícones estáveis ao longo do tempo)
$AppDir = Join-Path $env:LOCALAPPDATA 'RecycleBinMario'
New-Item -ItemType Directory -Force -Path $AppDir | Out-Null

$DstEmpty = Join-Path $AppDir 'empty.ico'
$DstFull  = Join-Path $AppDir 'full.ico'
Copy-Item -LiteralPath $EmptyIcon -Destination $DstEmpty -Force
Copy-Item -LiteralPath $FullIcon  -Destination $DstFull  -Force

# 3) Backup e escrita no Registro (HKCU)
$clsidPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon'
New-Item -Path $clsidPath -Force | Out-Null

$backup = @{
  timestamp = (Get-Date).ToString('o')
  empty     = (Get-ItemProperty -Path $clsidPath -Name 'empty' -ErrorAction SilentlyContinue).empty
  full      = (Get-ItemProperty -Path $clsidPath -Name 'full'  -ErrorAction SilentlyContinue).full
}
$BackupPath = Join-Path $AppDir 'backup.recyclebin.json'
$backup | ConvertTo-Json | Set-Content -Path $BackupPath -Encoding UTF8

Set-ItemProperty -Path $clsidPath -Name 'empty' -Type String -Value $DstEmpty
Set-ItemProperty -Path $clsidPath -Name 'full'  -Type String -Value $DstFull

Write-Host "✔ Ícones aplicados (sem refresh forçado)."
Write-Host "   Vazia -> $DstEmpty"
Write-Host "   Cheia -> $DstFull"
Write-Host "✔ Backup em: $BackupPath"

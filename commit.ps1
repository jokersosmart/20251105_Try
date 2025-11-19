# 快速執行自動提交
param([string]$Message = "")

if ([string]::IsNullOrWhiteSpace($Message)) {
    & .\.specify\scripts\powershell\auto-commit.ps1
} else {
    & .\.specify\scripts\powershell\auto-commit.ps1 -Message $Message
}

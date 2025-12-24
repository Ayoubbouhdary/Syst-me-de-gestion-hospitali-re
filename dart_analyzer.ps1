# Analyseur Dart simple en PowerShell

param(
    [string]$AnalyzeFile = "reports/analyze_output.txt",
    [string]$OutputDir = "reports"
)

# Créer le répertoire
if (-not (Test-Path $OutputDir)) { mkdir $OutputDir | Out-Null }

Write-Host "Parsing l'analyse Dart..."

# Parser le fichier
$issues = @()
$content = Get-Content $AnalyzeFile -Raw
$lines = $content -split "`n"

foreach ($line in $lines) {
    if ($line -match '^\s+(\w+)\s+-\s+(.+?)\s+-\s+(.+?):(\d+):(\d+)\s+-\s+(\w+)') {
        $issues += @{
            Severity = $matches[1].ToLower()
            Message  = $matches[2].Trim()
            File     = $matches[3]
            Line     = $matches[4]
            Column   = $matches[5]
            Rule     = $matches[6]
        }
    }
}


Write-Host "✓ Trouvé $($issues.Count) problèmes"
Write-Host ""

# Grouper par fichier
$byFile = @{}
foreach ($issue in $issues) {
    if (-not $byFile.ContainsKey($issue.File)) { $byFile[$issue.File] = @() }
    $byFile[$issue.File] += $issue
}

# Statistiques
$totalErrors = ($issues | Where-Object { $_.Severity -eq 'error' }).Count
$totalWarnings = ($issues | Where-Object { $_.Severity -eq 'warning' }).Count
$totalInfos = ($issues | Where-Object { $_.Severity -eq 'info' }).Count

# Générer HTML
$html = "<!DOCTYPE html><html><head><meta charset=UTF-8><title>Dart Analysis</title><style>
body { font-family: Arial; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 20px; margin: 0; }
.container { max-width: 1200px; margin: 0 auto; }
.header { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
.stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; margin-top: 15px; }
.stat { background: #f5f5f5; padding: 15px; border-radius: 4px; text-align: center; }
.stat strong { display: block; font-size: 24px; color: #333; }
.file-group { background: white; margin-bottom: 15px; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
.file-header { background: #f5f5f5; padding: 15px 20px; border-left: 4px solid #667eea; cursor: pointer; }
.file-header h3 { margin: 0; color: #333; font-size: 14px; }
.issue { padding: 12px 20px; border-bottom: 1px solid #eee; display: flex; gap: 15px; }
.badge { min-width: 70px; padding: 3px 8px; border-radius: 4px; font-size: 11px; font-weight: bold; color: white; text-align: center; }
.badge.error { background: #d32f2f; } .badge.warning { background: #f57c00; } .badge.info { background: #1976d2; }
.content { flex: 1; font-size: 13px; }
.location { color: #999; font-size: 11px; }
.message { color: #333; margin-top: 3px; }
.rule { color: #666; font-size: 11px; margin-top: 3px; font-family: monospace; }
.footer { background: white; padding: 15px; text-align: center; color: #999; font-size: 12px; border-radius: 8px; }
</style></head><body><div class=container><div class=header>
<h1>📊 Rapport Dart Analysis</h1>
<p>Date: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')</p>
<div class=stats>
<div class=stat><strong>$($issues.Count)</strong> Problèmes</div>
<div class=stat><strong>$totalErrors</strong> Erreurs</div>
<div class=stat><strong>$totalWarnings</strong> Avertissements</div>
<div class=stat><strong>$totalInfos</strong> Infos</div>
</div></div>"

foreach ($file in ($byFile.Keys | Sort-Object)) {
    $fileIssues = $byFile[$file]
    $html += "<div class=file-group><div class=file-header><h3>📄 $file</h3></div>"
    
    foreach ($issue in ($fileIssues | Sort-Object { [int]$_.Line })) {
        $html += "<div class=issue><div class='badge $($issue.Severity)'>$($issue.Severity)</div><div class=content>
        <div class=location>Ligne $($issue.Line), Col $($issue.Column)</div>
        <div class=message>$($issue.Message)</div>
        <div class=rule>$($issue.Rule)</div></div></div>"
    }
    
    $html += "</div>"
}

$html += "<div class=footer>Généré le $(Get-Date -Format 'dd/MM/yyyy à HH:mm:ss') | Dart Analyzer</div></div></body></html>"

$html | Out-File -FilePath "$OutputDir/dart_analysis.html" -Encoding UTF8
Write-Host "✓ Rapport HTML: $OutputDir/dart_analysis.html"

# Générer JSON
$issues | ConvertTo-Json | Out-File -FilePath "$OutputDir/dart_analysis.json" -Encoding UTF8
Write-Host "✓ Rapport JSON: $OutputDir/dart_analysis.json"

# Générer CSV
$issues | ConvertTo-Csv -NoTypeInformation | Out-File -FilePath "$OutputDir/dart_analysis.csv" -Encoding UTF8
Write-Host "✓ Rapport CSV: $OutputDir/dart_analysis.csv"

Write-Host ""
Write-Host "📊 Résumé:"
Write-Host "  Problèmes totaux: $($issues.Count)"
Write-Host "  Erreurs: $totalErrors"
Write-Host "  Avertissements: $totalWarnings"
Write-Host "  Infos: $totalInfos"
Write-Host "  Fichiers affectés: $($byFile.Keys.Count)"

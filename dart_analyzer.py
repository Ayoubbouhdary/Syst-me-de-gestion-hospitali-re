#!/usr/bin/env python3
"""
Analyseur Dart personnalisé - Convertit flutter analyze en rapports structurés
Génère : JSON, HTML, CSV et SARIF
"""

import json
import re
import sys
from datetime import datetime
from pathlib import Path
from typing import List, Dict, Any

class DartAnalyzer:
    """Analyse le code Dart et génère des rapports"""
    
    SEVERITY_LEVELS = {
        'error': 3,
        'warning': 2,
        'info': 1
    }
    
    SEVERITY_COLORS = {
        'error': '#d32f2f',
        'warning': '#f57c00',
        'info': '#1976d2'
    }
    
    def __init__(self, project_root: str):
        self.project_root = Path(project_root)
        self.issues = []
        self.stats = {
            'total': 0,
            'errors': 0,
            'warnings': 0,
            'infos': 0,
            'files': set(),
            'by_type': {}
        }
    
    def parse_analyze_output(self, output: str) -> List[Dict[str, Any]]:
        """Parse la sortie de flutter analyze"""
        issues = []
        lines = output.split('\n')
        
        # Pattern pour matcher les problèmes
        pattern = r'^\s+(\w+)\s+-\s+(.+?)\s+-\s+(.+?):(\d+):(\d+)\s+-\s+(\w+)'
        
        for line in lines:
            match = re.match(pattern, line)
            if match:
                severity, message, file_path, line_num, col_num, rule_id = match.groups()
                
                issue = {
                    'severity': severity.lower(),
                    'message': message.strip(),
                    'file': file_path,
                    'line': int(line_num),
                    'column': int(col_num),
                    'rule': rule_id,
                    'timestamp': datetime.now().isoformat()
                }
                
                issues.append(issue)
                self._update_stats(issue)
        
        return issues
    
    def _update_stats(self, issue: Dict[str, Any]):
        """Met à jour les statistiques"""
        severity = issue['severity']
        self.stats['total'] += 1
        self.stats[severity + 's'] += 1
        self.stats['files'].add(issue['file'])
        
        rule = issue['rule']
        self.stats['by_type'][rule] = self.stats['by_type'].get(rule, 0) + 1
    
    def generate_json_report(self, output_path: str):
        """Génère un rapport JSON"""
        report = {
            'timestamp': datetime.now().isoformat(),
            'project': str(self.project_root),
            'statistics': {
                'total_issues': self.stats['total'],
                'errors': self.stats['errors'],
                'warnings': self.stats['warnings'],
                'infos': self.stats['infos'],
                'affected_files': len(self.stats['files']),
                'issue_types': self.stats['by_type']
            },
            'issues': self.issues
        }
        
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(report, f, indent=2, ensure_ascii=False)
        
        print(f"✓ Rapport JSON généré: {output_path}")
    
    def generate_csv_report(self, output_path: str):
        """Génère un rapport CSV"""
        import csv
        
        with open(output_path, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=['severity', 'file', 'line', 'column', 'rule', 'message'])
            writer.writeheader()
            
            for issue in sorted(self.issues, key=lambda x: (x['file'], x['line'])):
                writer.writerow({
                    'severity': issue['severity'],
                    'file': issue['file'],
                    'line': issue['line'],
                    'column': issue['column'],
                    'rule': issue['rule'],
                    'message': issue['message']
                })
        
        print(f"✓ Rapport CSV généré: {output_path}")
    
    def generate_html_report(self, output_path: str):
        """Génère un rapport HTML interactif"""
        
        # Grouper par fichier
        by_file = {}
        for issue in self.issues:
            file = issue['file']
            if file not in by_file:
                by_file[file] = []
            by_file[file].append(issue)
        
        html = f"""<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rapport d'Analyse Dart - {self.project_root.name}</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }}
        .container {{ max-width: 1200px; margin: 0 auto; }}
        .header {{
            background: white;
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }}
        .header h1 {{ color: #333; margin-bottom: 20px; }}
        .stats {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }}
        .stat-card {{
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }}
        .stat-card h3 {{ font-size: 14px; opacity: 0.9; margin-bottom: 10px; }}
        .stat-card .number {{ font-size: 32px; font-weight: bold; }}
        
        .error-card {{ background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }}
        .warning-card {{ background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); }}
        .info-card {{ background: linear-gradient(135deg, #30cfd0 0%, #330867 100%); }}
        
        .issues-container {{
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
        }}
        
        .file-group {{
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }}
        
        .file-header {{
            background: #f5f5f5;
            padding: 15px 20px;
            border-left: 4px solid #667eea;
            cursor: pointer;
            user-select: none;
        }}
        
        .file-header:hover {{ background: #efefef; }}
        .file-header h3 {{ color: #333; font-size: 16px; }}
        .file-header .count {{ color: #999; font-size: 12px; margin-left: 10px; }}
        
        .issues {{
            display: none;
            padding: 0;
        }}
        
        .issues.expanded {{ display: block; }}
        
        .issue {{
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            gap: 15px;
            align-items: flex-start;
        }}
        
        .issue:last-child {{ border-bottom: none; }}
        
        .issue-badge {{
            min-width: 80px;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
            text-align: center;
            color: white;
        }}
        
        .issue-badge.error {{ background: #d32f2f; }}
        .issue-badge.warning {{ background: #f57c00; }}
        .issue-badge.info {{ background: #1976d2; }}
        
        .issue-content {{ flex: 1; }}
        .issue-location {{ color: #999; font-size: 12px; }}
        .issue-rule {{ 
            color: #666;
            font-size: 12px;
            margin-top: 5px;
            font-family: 'Courier New', monospace;
        }}
        .issue-message {{ 
            color: #333;
            margin-top: 5px;
            line-height: 1.4;
        }}
        
        .footer {{
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
            text-align: center;
            color: #999;
            font-size: 12px;
        }}
        
        .summary {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }}
        
        .summary-item {{
            padding: 10px;
            background: #f5f5f5;
            border-radius: 4px;
            text-align: center;
        }}
        
        .summary-item strong {{ display: block; color: #333; }}
        .summary-item span {{ color: #999; font-size: 12px; }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Rapport d'Analyse Dart</h1>
            <p><strong>Projet:</strong> {self.project_root.name}</p>
            <p><strong>Date:</strong> {datetime.now().strftime('%d/%m/%Y %H:%M:%S')}</p>
            
            <div class="stats">
                <div class="stat-card">
                    <h3>Problèmes Totaux</h3>
                    <div class="number">{self.stats['total']}</div>
                </div>
                <div class="stat-card error-card">
                    <h3>Erreurs</h3>
                    <div class="number">{self.stats['errors']}</div>
                </div>
                <div class="stat-card warning-card">
                    <h3>Avertissements</h3>
                    <div class="number">{self.stats['warnings']}</div>
                </div>
                <div class="stat-card info-card">
                    <h3>Infos</h3>
                    <div class="number">{self.stats['infos']}</div>
                </div>
            </div>
            
            <div class="summary">
                <div class="summary-item">
                    <strong>{len(self.stats['files'])}</strong>
                    <span>Fichiers affectés</span>
                </div>
                <div class="summary-item">
                    <strong>{len(self.stats['by_type'])}</strong>
                    <span>Types de problèmes</span>
                </div>
            </div>
        </div>
        
        <div class="issues-container">
"""
        
        for file_path in sorted(by_file.keys()):
            issues = by_file[file_path]
            error_count = sum(1 for i in issues if i['severity'] == 'error')
            warning_count = sum(1 for i in issues if i['severity'] == 'warning')
            info_count = sum(1 for i in issues if i['severity'] == 'info')
            
            html += f"""
            <div class="file-group">
                <div class="file-header" onclick="this.nextElementSibling.classList.toggle('expanded')">
                    <div>
                        <h3>📄 {file_path}</h3>
                        <span class="count">{len(issues)} problème(s) 
                            {'🔴 ' + str(error_count) if error_count > 0 else ''} 
                            {'🟡 ' + str(warning_count) if warning_count > 0 else ''} 
                            {'🔵 ' + str(info_count) if info_count > 0 else ''}
                        </span>
                    </div>
                </div>
                <div class="issues expanded">
"""
            
            for issue in sorted(issues, key=lambda x: x['line']):
                html += f"""
                    <div class="issue">
                        <div class="issue-badge {issue['severity']}">{issue['severity']}</div>
                        <div class="issue-content">
                            <div class="issue-location">Ligne {issue['line']}, Colonne {issue['column']}</div>
                            <div class="issue-message">{issue['message']}</div>
                            <div class="issue-rule">Règle: {issue['rule']}</div>
                        </div>
                    </div>
"""
            
            html += """
                </div>
            </div>
"""
        
        html += f"""
        </div>
        
        <div class="footer">
            <p>Généré le {datetime.now().strftime('%d/%m/%Y à %H:%M:%S')} | Analyse Dart</p>
        </div>
    </div>
    
    <script>
        // Auto-expand les fichiers avec erreurs
        document.querySelectorAll('.file-group').forEach(group => {{
            const header = group.querySelector('.file-header');
            const hasErrors = header.textContent.includes('🔴');
            if (hasErrors) {{
                group.querySelector('.issues').classList.add('expanded');
            }}
        }});
    </script>
</body>
</html>
"""
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(html)
        
        print(f"✓ Rapport HTML généré: {output_path}")
    
    def generate_sarif_report(self, output_path: str):
        """Génère un rapport SARIF (compatible SonarQube)"""
        
        results = []
        for issue in self.issues:
            result = {
                "ruleId": issue['rule'],
                "level": "error" if issue['severity'] == 'error' else "warning",
                "message": {
                    "text": issue['message']
                },
                "locations": [
                    {
                        "physicalLocation": {
                            "artifactLocation": {
                                "uri": issue['file']
                            },
                            "region": {
                                "startLine": issue['line'],
                                "startColumn": issue['column']
                            }
                        }
                    }
                ]
            }
            results.append(result)
        
        sarif = {
            "version": "2.1.0",
            "$schema": "https://json.schemastore.org/sarif-2.1.0.json",
            "runs": [
                {
                    "tool": {
                        "driver": {
                            "name": "Dart Analyzer",
                            "version": "latest",
                            "informationUri": "https://dart.dev/guides/language/analysis-options"
                        }
                    },
                    "results": results
                }
            ]
        }
        
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(sarif, f, indent=2)
        
        print(f"✓ Rapport SARIF généré: {output_path}")


def main():
    """Point d'entrée principal"""
    if len(sys.argv) < 2:
        print("Usage: python dart_analyzer.py <analyze_output_file> [output_dir]")
        sys.exit(1)
    
    analyze_output = sys.argv[1]
    output_dir = sys.argv[2] if len(sys.argv) > 2 else "."
    project_root = sys.argv[3] if len(sys.argv) > 3 else "."
    
    # Lire la sortie d'analyse
    with open(analyze_output, 'r', encoding='utf-8') as f:
        analyze_text = f.read()
    
    # Créer l'analyseur
    analyzer = DartAnalyzer(project_root)
    analyzer.issues = analyzer.parse_analyze_output(analyze_text)
    
    # Générer les rapports
    Path(output_dir).mkdir(parents=True, exist_ok=True)
    
    analyzer.generate_json_report(f"{output_dir}/dart_analysis.json")
    analyzer.generate_csv_report(f"{output_dir}/dart_analysis.csv")
    analyzer.generate_html_report(f"{output_dir}/dart_analysis.html")
    analyzer.generate_sarif_report(f"{output_dir}/dart_analysis.sarif")
    
    print(f"\n📊 Résumé:")
    print(f"  Total: {analyzer.stats['total']}")
    print(f"  Erreurs: {analyzer.stats['errors']}")
    print(f"  Avertissements: {analyzer.stats['warnings']}")
    print(f"  Infos: {analyzer.stats['infos']}")
    print(f"  Fichiers affectés: {len(analyzer.stats['files'])}")


if __name__ == '__main__':
    main()

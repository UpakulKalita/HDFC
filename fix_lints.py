
import re
import os
from collections import defaultdict

def fix_lints():
    analysis_file = 'analysis_output.txt'
    if not os.path.exists(analysis_file):
        print("analysis_output.txt not found")
        return

    with open(analysis_file, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    pattern = re.compile(r'\[info\] (.*?) \((.*?):(\d+):(\d+)\)')
    issues = pattern.findall(content)
    
    file_issues = defaultdict(list)
    for msg, file_path, line, col in issues:
        file_issues[file_path].append((msg, int(line), int(col)))

    for path, issues in file_issues.items():
        if not os.path.exists(path):
            continue
            
        print(f"Fixing {path}")
        with open(path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            
        # Process in reverse order to not mess up indices
        issues.sort(key=lambda x: (x[1], x[2]), reverse=True)
        
        for msg, line_num, col in issues:
            idx = line_num - 1
            if idx >= len(lines): continue
            
            line_content = lines[idx]
            
            if "'withOpacity' is deprecated" in msg:
                lines[idx] = line_content.replace('.withOpacity(', '.withValues(alpha: ')
            elif "Unused import:" in msg or "unused_import" in msg.lower():
                lines[idx] = "DELETE_LINE\n"
            elif "Unnecessary use of multiple underscores" in msg:
                lines[idx] = line_content.replace('___', '_').replace('__', '_')
        
        # Write back
        new_lines = [l for l in lines if l != "DELETE_LINE\n"]
        with open(path, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)

if __name__ == "__main__":
    fix_lints()

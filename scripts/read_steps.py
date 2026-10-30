import json

with open(r'C:\Users\Amirhossein\.gemini\antigravity-ide\brain\ac779555-bd05-4f82-9cb5-d3484faf22f2\.system_generated\logs\transcript.jsonl', 'r', encoding='utf-8') as f:
    for line in f:
        data = json.loads(line)
        idx = data.get('step_index')
        if idx in [963, 964, 965, 966, 967]:
            print(f"Step {idx} ({data.get('type')}): {data.get('content') or data.get('tool_calls')}")

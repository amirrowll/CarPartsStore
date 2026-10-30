$content = Get-Content -Path "scripts/db_inspect.py" -Raw -Encoding utf8
$bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
$b64 = [System.Convert]::ToBase64String($bytes)
$cmd = "echo $b64 | base64 -d | python3"
& "C:\Program Files\Git\bin\bash.exe" scripts/ssh_cmd.sh $cmd

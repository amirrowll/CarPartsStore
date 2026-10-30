const { execSync } = require('child_process');
const fs = require('fs');

function runRemote(cmd) {
  const b64 = Buffer.from(cmd).toString('base64');
  const bashCmd = `scripts/ssh_cmd.sh "echo ${b64} | base64 -d | bash"`;
  return execSync(`"C:\\Program Files\\Git\\bin\\bash.exe" ${bashCmd}`, { encoding: 'utf-8', timeout: 180000 });
}

function runRemotePython(pyCode) {
  const b64 = Buffer.from(pyCode).toString('base64');
  const bashCmd = `scripts/ssh_cmd.sh "echo ${b64} | base64 -d | python3"`;
  return execSync(`"C:\\Program Files\\Git\\bin\\bash.exe" ${bashCmd}`, { encoding: 'utf-8', timeout: 180000 });
}

module.exports = { runRemote, runRemotePython };

if (require.main === module) {
  const pyCode = fs.readFileSync('scripts/audit_and_fix.py', 'utf-8');
  console.log(runRemotePython(pyCode));
}

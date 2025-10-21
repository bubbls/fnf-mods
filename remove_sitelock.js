const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'rewrite-round2', 'Gamaverse.js');
const backupPath = filePath + '.bak';

console.log('Reading', filePath);
let src = fs.readFileSync(filePath, 'utf8');

// Backup original
fs.writeFileSync(backupPath, src, 'utf8');
console.log('Backup written to', backupPath);

let newSrc = src;

// Replace isHostUrlAllowed function to always return true
newSrc = newSrc.replace(/isHostUrlAllowed:\s*function\s*\(\)\s*\{[\s\S]*?\},/m, `isHostUrlAllowed: function () {\n            // Site-lock disabled: always allow host so the game can run anywhere.\n            return true;\n          },`);

// Replace checkSiteLock to simply mark URL checked
newSrc = newSrc.replace(/checkSiteLock:\s*function\s*\(\)\s*\{[\s\S]*?\},/m, `checkSiteLock: function () {\n            // Site-lock disabled: skip host validation and allow the game to run.\n            if (this["_urlChecked"]) return;\n            this["_urlChecked"] = !![];\n          },`);

if (newSrc === src) {
  console.error('No replacements were made. Patterns may not have matched. No changes written.');
  process.exitCode = 2;
} else {
  fs.writeFileSync(filePath, newSrc, 'utf8');
  console.log('File updated in place.');
}

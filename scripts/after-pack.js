const { spawn } = require('child_process');
const { readFileSync, writeFileSync, openSync } = require("fs");
const { resolve } = require("path");

module.exports = async ({ outDir, appOutDir }) => {
	const updateFile = resolve(appOutDir, 'resources/app-update.yml');
	const content = readFileSync(updateFile, "utf-8");
	if (!content.includes("host: github.gongt.net")) {
		console.log("patching app-update.yml...");
		writeFileSync(updateFile, content.trim() + "\nhost: github.gongt.net\n", "utf-8");
	}

	const out = openSync(resolve(outDir, "package-content.list"), "a");
	const p = spawn("asar", ['list', resolve(appOutDir, 'resources/app.asar')], {
		stdio: [process.stdin, out, out]
	});

	const exitCode = await new Promise((resolve, reject) => {
		p.on('close', resolve);
		p.on('error', reject);
	});

	if (exitCode != 0) {
		console.error('未知问题 - 不能解析app.asar');
		process.exit(exitCode);
	}
};

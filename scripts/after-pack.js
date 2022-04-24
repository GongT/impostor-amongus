const { spawnSync } = require('child_process');
module.exports = function ({ appOutDir }) {
	const ret = spawnSync("asar", ['list', `${appOutDir}/resources/app.asar`], { stdio: "inherit" });
	if (ret.error) {
		throw ret.error;
	}
	if (ret.status != 0) {
		process.exit(ret.status);
	}
};

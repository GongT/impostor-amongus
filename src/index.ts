import { resolve } from 'path';
import { app, BrowserWindow } from 'electron';
import logger from 'electron-log';
import { autoUpdater } from 'electron-updater';

logger.transports.file.level = 'silly';
autoUpdater.logger = logger;
autoUpdater.autoInstallOnAppQuit = true;
autoUpdater.autoDownload = true;
autoUpdater.allowPrerelease = false;
autoUpdater.disableWebInstaller = true;
autoUpdater.checkForUpdatesAndNotify({
	body: '程序退出后将自动更新',
	title: '发现新版本',
});

app.whenReady().then(() => {
	const win = new BrowserWindow();
	win.show();
	win.setTitle('test!!!');
	win.loadFile(resolve(__dirname, 'index.html'));
});

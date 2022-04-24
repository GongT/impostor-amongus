import { resolve } from 'path';
import { app, BrowserWindow } from 'electron';
import { autoUpdater } from 'electron-updater';
import logger from 'electron-log';

logger.transports.file.level = 'verbose';
autoUpdater.logger = logger;
autoUpdater.checkForUpdatesAndNotify();

app.whenReady().then(() => {
	const win = new BrowserWindow();
	win.show();
	win.setTitle('test!!!');
	win.loadFile(resolve(__dirname, 'index.html'));
});

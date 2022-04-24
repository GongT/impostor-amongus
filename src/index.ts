import { app, BrowserWindow } from 'electron';
import { autoUpdater } from 'electron-updater';

autoUpdater.checkForUpdatesAndNotify();

export function test(): string {
	return 'hello world';
}

app.whenReady().then(() => {
	const win = new BrowserWindow();
	win.show();
	win.setTitle('test!!!');
	win.loadFile('./index.html');
});

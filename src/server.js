import express from 'express';
import cron from 'node-cron';
import sleep from 'atomic-sleep';
import db, { migrate } from '@lib/server/db.js';

const isDev = process.env.ENV !== 'production';

migrate();

cron.schedule(
    '* * * * *',
    async () => {
        console.log('Start task...');
        sleep(1000);
        console.log(db().query('SELECT * FROM posts'));
        console.log('Task executed');
    }
);

async function createServer() {
    const app = express();

    app.get('/healthcheck', (req, res) => {
        res.end('ok');
    });

    if (isDev) {
        const { createServer: createViteServer } = await import('vite');

        const vite = await createViteServer({
            server: { middlewareMode: true },
            appType: 'custom'
        });

        app.use(vite.middlewares);
    } else {
        const { handler } = await import('./handler.js');
        app.use(handler);
    }

    const PORT = process.env.PORT || (isDev ? 5173 : 3000);
    app.listen(
        PORT,
        () => {
            console.log(`Server started on http://localhost:${PORT} in ${isDev ? 'development' : 'production'} mode`);
        }
    );
}

createServer().catch(err => {
    console.error('Error while starting server:', err);
    process.exit(1);
});

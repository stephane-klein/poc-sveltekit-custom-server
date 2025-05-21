import { fileURLToPath } from 'url';
import fs from 'fs';
import path from 'path';
import db, { migrate } from '@lib/server/db.js';

migrate();

db().exec(fs.readFileSync(
    path.join(
        path.dirname(fileURLToPath(import.meta.url)),
        '../sqls/seed.sql'
    ),
    'utf8'
));


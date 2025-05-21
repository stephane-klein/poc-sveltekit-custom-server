import { fileURLToPath } from 'url';
import path from 'path';
import DB from '@beenotung/better-sqlite3-helper';

DB({
    path: process.env.SQLITE_PATH || 'sqlite3.db',
    migrate: false
})

DB().pragma('foreign_keys = ON');

export const migrate = () => {
    console.log('Start data model migration…');
    DB().migrate({
        table: 'migration',
        migrationsPath: path.join(
            path.dirname(fileURLToPath(import.meta.url)),
            '../../../sqls/migrations'
        )
    });
    console.log('Data model migration completed');
}

export default DB;

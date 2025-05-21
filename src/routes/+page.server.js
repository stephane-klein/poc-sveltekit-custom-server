import db from '@lib/server/db.js';

export async function load() {
    return {
        posts: db().query('SELECT * FROM posts')
    }
}

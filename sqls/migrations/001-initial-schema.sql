-- Up
CREATE TABLE categories (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE posts (
    id INTEGER PRIMARY KEY, 
    category_id INTEGER, 
    title TEXT,
    CONSTRAINT post_fk_category_id FOREIGN KEY (category_id)
    REFERENCES categories (id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO categories (id, name) VALUES (1, 'Business');
INSERT INTO categories (id, name) VALUES (2, 'Technology');

-- Down
DROP TABLE categories;
DROP TABLE posts;

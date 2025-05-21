-- Up
CREATE INDEX post_ix_category_id ON posts (category_id);

-- Down
DROP INDEX post_ix_category_id;

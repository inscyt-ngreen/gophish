
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
UPDATE campaigns SET launch_date = created_date;

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back


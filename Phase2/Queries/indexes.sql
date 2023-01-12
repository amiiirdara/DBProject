
CREATE UNIQUE INDEX safebox_id ON SafeBox (safebox_id);

CREATE UNIQUE INDEX floor ON Hall (floor);

CREATE INDEX hall_floor ON SafeBox (hall_floor);

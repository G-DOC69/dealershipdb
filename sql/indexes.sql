USE dealership;

-- Good FK indexes (MySQL creates indexes for FK columns if not present, but explicit is fine)
CREATE INDEX idx_cars_user_id ON cars(user_id);
CREATE INDEX idx_photos_car_id ON photos(car_id);
CREATE INDEX idx_photos_event_id ON photos(event_id);
CREATE INDEX idx_contact_user_id ON contact_messages(user_id);
CREATE INDEX idx_users_role_id ON users(role_id);

-- Search & filter indexes
CREATE INDEX idx_cars_brand ON cars(brand);
CREATE INDEX idx_cars_model ON cars(model);
CREATE INDEX idx_cars_brand_model ON cars(brand, model);
CREATE INDEX idx_cars_price ON cars(price);
CREATE INDEX idx_cars_mileage ON cars(mileage);
CREATE INDEX idx_cars_is_available ON cars(is_available);

-- For analytics / time series
CREATE INDEX idx_contact_created_at ON contact_messages(created_at);
CREATE INDEX idx_events_event_date ON events(event_date);
CREATE INDEX idx_photos_upload_time ON photos(upload_time);

-- Fulltext index on cars.description for MySQL (InnoDB)
ALTER TABLE cars ADD FULLTEXT INDEX ft_cars_description (description);

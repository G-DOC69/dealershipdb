-- Use or create the database
CREATE DATABASE IF NOT EXISTS dealership CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
USE dealership;

-- ROLES
CREATE TABLE IF NOT EXISTS roles (
                                     id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                     name VARCHAR(100) NOT NULL
    ) ENGINE=InnoDB;

-- USERS
CREATE TABLE IF NOT EXISTS users (
                                     id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                     username VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(50),
    enabled BOOLEAN NOT NULL DEFAULT FALSE,
    role_id BIGINT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL
    ) ENGINE=InnoDB;

-- CARS
CREATE TABLE IF NOT EXISTS cars (
                                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                    user_id BIGINT NOT NULL,
                                    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    year INT,
    mileage INT NOT NULL DEFAULT 0,
    color VARCHAR(100),
    price DECIMAL(12,2),
    description TEXT,
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATE,
    last_modified_at DATE,
    CONSTRAINT fk_cars_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    ) ENGINE=InnoDB;

-- EVENTS
CREATE TABLE IF NOT EXISTS events (
                                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      title VARCHAR(255),
    event_date DATETIME,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;

-- PHOTOS
-- Note: either car_id or event_id can be set; we keep both nullable.
CREATE TABLE IF NOT EXISTS photos (
                                      id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      file_name VARCHAR(255),
    mime_type VARCHAR(255),
    upload_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    data LONGBLOB,
    car_id BIGINT DEFAULT NULL,
    event_id BIGINT DEFAULT NULL,
    CONSTRAINT fk_photos_car FOREIGN KEY (car_id) REFERENCES cars(id) ON DELETE CASCADE,
    CONSTRAINT fk_photos_event FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE SET NULL,
    CONSTRAINT uq_photos_event UNIQUE (event_id) -- ensures 1:1 event->photo if event_id used
    ) ENGINE=InnoDB;

-- CONTACT MESSAGES
CREATE TABLE IF NOT EXISTS contact_messages (
                                                id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                                username VARCHAR(255),
    phone VARCHAR(50),
    message TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_id BIGINT DEFAULT NULL,
    CONSTRAINT fk_contact_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
    ) ENGINE=InnoDB;

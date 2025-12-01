CREATE VIEW most_popular_car_brands AS
SELECT
    brand,
    COUNT(id) AS listing_count
FROM
    cars
GROUP BY
    brand
ORDER BY
    listing_count DESC;

CREATE VIEW average_price_by_brand_model AS
SELECT
    brand,
    model,
    AVG(price) AS average_price
FROM
    cars
GROUP BY
    brand,
    model
ORDER BY
    brand,
    model;

CREATE VIEW lowest_mileage_cars AS
SELECT
    id,
    brand,
    model,
        year,
        mileage,
        price
        FROM
        cars
        ORDER BY
        mileage ASC;

CREATE VIEW cars_with_no_photos AS
SELECT
    c.id AS car_id,
    c.brand,
    c.model,
    c.year,
    c.price
FROM
    cars c
        LEFT JOIN
    photos p ON c.id = p.car_id
WHERE
    p.id IS NULL;

CREATE VIEW events_with_no_photos AS
SELECT
    e.id AS event_id,
    e.title,
    e.event_date,
    e.description
FROM
    events e
        LEFT JOIN
    photos p ON e.id = p.event_id
WHERE
    p.id IS NULL;

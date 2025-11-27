# Problem Statement — Dealership Data Project

## Project overview
This project models a car dealership website that is designed to be easily expanded (franchised) to support multiple locations, many users, and additional services (reviews, maintenance history, transactions, test drives). The current dataset models users, roles, cars, photos, events, and contact messages.

## Business goals
1. Provide fast, accurate search and filtering of cars (brand, model, price, mileage).
2. Detect listings that lack photos or incomplete metadata to improve listing quality.
3. Produce analytics to support pricing and inventory decisions (average prices by brand/model, most popular brands).
4. Track inbound interest (contact messages) and lead volumes over time.

## Optimization problems to solve
- **Query performance at scale.** With 1000+ rows per table and future growth, full table scans for common filters (brand/model, price ranges) will be slow. Indexing is required.
- **Large binary data (photos) management.** Storing images in the DB increases I/O and backup size; consider separating metadata and blobs or storing files on disk/object storage and only storing paths/URLs.
- **Joins across large tables.** Joins between `cars` and `photos` or `users` and `cars` are frequent; foreign-key indexes are necessary.
- **View creation for repeated analytics.** Predefined views for common analytics (popular brands, avg prices, cars without photos) improve reproducibility and can be optimized.

## Assumptions for future expansion (ER model considerations)
- The schema should allow adding `locations` (dealership branches), `transactions`, `reviews`, and `maintenance_records` without breaking existing relations.
- `cars` can be assigned to a `location` in the future (1:Many).
- `photos` design keeps a small metadata row in DB and allows storing images externally.

## Business problems (chosen for the project)
1. Most popular car brands in inventory (by count of listings).
2. Average price for each brand + model (pricing insight).
3. Cars with the lowest mileage (good for highlighting deals).
4. Search for cars with no photos (data quality).
5. Search for events with no photos (event completeness).

Each of these will be implemented as a SQL view so the AI agent can create and manage them, and queries will be provided for analysis.
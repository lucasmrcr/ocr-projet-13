-- Création de la table "User"
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20)
);

-- Création de la table "Agency"
CREATE TABLE agencies (
    agency_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    phone_number VARCHAR(20)
);

-- Création de la table "Vehicle"
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    model VARCHAR(255) NOT NULL,
    brand VARCHAR(255) NOT NULL,
    acriss_category VARCHAR(10),
    max_kilometers INT,
    daily_rate NUMERIC(10, 2) NOT NULL,
    agency_id INT NOT NULL,
    FOREIGN KEY (agency_id) REFERENCES agencies(agency_id) ON DELETE CASCADE
);

-- Création de la table "Booking"
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE
);

-- Création de la table "Payment"
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    amount NUMERIC(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    method VARCHAR(50) NOT NULL,
    booking_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

-- Index pour accélérer les recherches sur les emails des utilisateurs
CREATE INDEX idx_users_email ON users(email);

-- Index sur les véhicules pour la recherche par modèle et marque
CREATE INDEX idx_vehicles_model_brand ON vehicles(model, brand);

-- Index sur les réservations pour la recherche par date de début et de fin
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);

-- Index pour la recherche par montant des paiements
CREATE INDEX idx_payments_amount ON payments(amount);

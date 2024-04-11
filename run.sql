CREATE TABLE customer (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    join_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customer (id, name, email, password, phone, address) VALUES ('C001', 'John Doe', 'example@mail.com', 'password', '1234567890', '123 Main St, New York, NY');

CREATE TABLE product (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    image VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    description LONG VARCHAR NOT NULL,
    rating DECIMAL(2, 1) NOT NULL DEFAULT 0.0,
    purchase_count INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
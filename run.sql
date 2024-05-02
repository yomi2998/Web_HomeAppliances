CREATE TABLE customer (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    name VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    birth_date DATE NOT NULL,
    join_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_session (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    user_id INT NOT NULL,
    session_id VARCHAR(512) NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES customer(id) ON DELETE CASCADE
);

CREATE TABLE shipping_details (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    user_id INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    address_2 VARCHAR(255) DEFAULT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    zip_code VARCHAR(50) NOT NULL,
    recipient_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES customer(id) ON DELETE CASCADE,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE admin (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE admin_session (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    admin_id INT NOT NULL,
    session_id VARCHAR(512) NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES admin(id) ON DELETE CASCADE
);

INSERT INTO admin (username, password) VALUES ('admin', '123');

CREATE TABLE staff (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    name VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    join_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE staff_session (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    staff_id INT NOT NULL,
    session_id VARCHAR(512) NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE
);

CREATE TABLE category ( 
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    name VARCHAR(100) NOT NULL
);

INSERT INTO category (name) VALUES ('Kitchen');
INSERT INTO category (name) VALUES ('Laundry');
INSERT INTO category (name) VALUES ('Cleaning');
INSERT INTO category (name) VALUES ('Entertainment');
INSERT INTO category (name) VALUES ('Health');
INSERT INTO category (name) VALUES ('Smart Home');
INSERT INTO category (name) VALUES ('Climate Control');

CREATE TABLE product (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    name VARCHAR(255) NOT NULL,
    display_image BLOB(16M) NOT NULL,
    extension VARCHAR(64) NOT NULL,
    description LONG VARCHAR NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    sold INT NOT NULL DEFAULT 0,
    category_id INT,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET NULL
);

CREATE TABLE product_image (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    product_id INT NOT NULL,
    image BLOB(16M) NOT NULL,
    extension VARCHAR(64) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
);

CREATE TABLE product_rating (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    product_id INT NOT NULL,
    user_id INT,
    rating INT NOT NULL,
    description LONG VARCHAR NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES customer(id) ON DELETE SET NULL
);

CREATE TABLE product_rating_image (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    product_rating_id INT NOT NULL,
    image BLOB(16M) NOT NULL,
    FOREIGN KEY (product_rating_id) REFERENCES product_rating(id) ON DELETE CASCADE
);

CREATE TABLE card ( -- for user
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    card_number VARCHAR(20) NOT NULL,
    expiry_date VARCHAR(10) NOT NULL,
    cvv VARCHAR(3) NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES customer(id) ON DELETE CASCADE
);

CREATE TABLE cart (
    user_id INT NOT NULL,
    product_id INT,
    quantity INT NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES customer(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE SET NULL --notify user that product is no longer available then remove from cart
);

CREATE TABLE discount (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    code VARCHAR(20) NOT NULL,
    static_value BOOLEAN NOT NULL DEFAULT FALSE,
    value DECIMAL(10, 2) NOT NULL,
    min_spend DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    enforce_category BOOLEAN NOT NULL DEFAULT FALSE,
    category_id INT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    start_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET NULL
);

CREATE TABLE cust_order (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    user_id INT,
    total_price DECIMAL(10, 2) NOT NULL,
    total_discount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    total_final_price DECIMAL(10, 2) NOT NULL,
    address VARCHAR(255) NOT NULL,
    address_2 VARCHAR(255) DEFAULT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    zip_code VARCHAR(50) NOT NULL,
    recipient_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES customer(id) ON DELETE NO ACTION
);

CREATE TABLE order_product ( -- this is where u can get amount of discount applied/total product price
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    order_id INT NOT NULL,
    discount_id INT NOT NULL DEFAULT 0, -- 0 = No discount
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE SET NULL,
    FOREIGN KEY (discount_id) REFERENCES discount(id)
);

CREATE TABLE order_status (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    order_id INT NOT NULL,
    status LONG VARCHAR NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(id) ON DELETE CASCADE
);

CREATE TABLE topup (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    is_refund BOOLEAN NOT NULL DEFAULT FALSE,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    card_holder VARCHAR(100) NOT NULL,
    card_number VARCHAR(20) NOT NULL,
    expiry_date VARCHAR(10) NOT NULL,
    cvv VARCHAR(3) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES customer(id) ON DELETE CASCADE
);

CREATE TABLE feedback (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(Start with 1, Increment by 1),
    user_id INT NOT NULL,
    title LONG VARCHAR NOT NULL,
    description LONG VARCHAR NOT NULL,
    comment LONG VARCHAR DEFAULT NULL,
    is_resolved BOOLEAN NOT NULL DEFAULT FALSE,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES customer(id) ON DELETE CASCADE
);
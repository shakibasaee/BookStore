CREATE TABLE IF NOT EXISTS user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    phone TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    role TEXT CHECK(role IN ('admin', 'customer', 'author')) NOT NULL
);

CREATE TABLE IF NOT EXISTS author (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    city TEXT NOT NULL,
    goodreads_link TEXT,
    bank_account_number TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user (id)
);

CREATE TABLE IF NOT EXISTS customer (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    subscription_model TEXT CHECK(subscription_model IN ('free', 'plus', 'premium')) NOT NULL,
    subscription_end_time TEXT,
    wallet_money REAL NOT NULL DEFAULT 0.0,
    FOREIGN KEY (user_id) REFERENCES user (id)
);

CREATE TABLE IF NOT EXISTS genre (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS city (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS book (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    isbn TEXT NOT NULL UNIQUE,
    price REAL NOT NULL,
    genre_id INTEGER NOT NULL,
    units INTEGER NOT NULL DEFAULT 0,
    description TEXT,
    FOREIGN KEY (genre_id) REFERENCES genre (id)
);

CREATE TABLE IF NOT EXISTS book_author (
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book (id),
    FOREIGN KEY (author_id) REFERENCES author (id)
);

CREATE TABLE IF NOT EXISTS reservation (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT,
    price REAL NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (id),
    FOREIGN KEY (book_id) REFERENCES book (id)
);

INSERT INTO user (username, first_name, last_name, phone, email, password, role) VALUES
('admin1', 'Admin', 'User', '1234567890', 'admin@example.com', 'adminpass', 'admin'),
('author1', 'John', 'Doe', '1234567891', 'author1@example.com', 'authorpass', 'author'),
('author2', 'Jane', 'Smith', '1234567892', 'author2@example.com', 'authorpass', 'author'),
('customer1', 'Alice', 'Brown', '1234567893', 'customer1@example.com', 'customerpass', 'customer'),
('customer2', 'Bob', 'White', '1234567894', 'customer2@example.com', 'customerpass', 'customer');

INSERT INTO author (user_id, city, goodreads_link, bank_account_number) VALUES
(2, 'New York', 'https://goodreads.com/author1', '123-456-789'),
(3, 'London', 'https://goodreads.com/author2', '987-654-321');

INSERT INTO customer (user_id, subscription_model, subscription_end_time, wallet_money) VALUES
(4, 'free', '2025-12-31', 50.0),
(5, 'plus', '2025-12-31', 100.0);

INSERT INTO genre (name) VALUES
('Fiction'),
('Non-Fiction'),
('Science'),
('Fantasy');

INSERT INTO book (title, isbn, price, genre_id, units, description) VALUES
('Book One', '1234567890', 19.99, 1, 10, 'A great fiction book.'),
('Book Two', '0987654321', 29.99, 2, 5, 'A great non-fiction book.'),
('Book Three', '1122334455', 39.99, 3, 2, 'A fascinating science book.');

INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 1);

INSERT INTO reservation (customer_id, book_id, start_date, end_date, price) VALUES
(1, 1, '2025-01-01', '2025-01-10', 19.99),
(2, 2, '2025-01-05', '2025-01-15', 29.99);
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    nickname VARCHAR(100),
    avatar VARCHAR(255),
    role VARCHAR(20) DEFAULT 'user',
    status INT DEFAULT 1,
    vip_level INT DEFAULT 0,
    balance DECIMAL(10,2) DEFAULT 0.00,
    create_time DATETIME DEFAULT NOW(),
    last_login_time DATETIME
);

CREATE TABLE IF NOT EXISTS categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    parent_id INT DEFAULT 0,
    sort_order INT DEFAULT 0,
    icon VARCHAR(255),
    status INT DEFAULT 1,
    create_time DATETIME DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    author_id INT,
    category_id INT,
    cover_image VARCHAR(255),
    description TEXT,
    price DECIMAL(10,2) DEFAULT 0.00,
    word_count INT DEFAULT 0,
    chapter_count INT DEFAULT 0,
    status INT DEFAULT 1,
    is_free INT DEFAULT 0,
    view_count INT DEFAULT 0,
    favorite_count INT DEFAULT 0,
    rating DECIMAL(3,2) DEFAULT 0.00,
    publisher VARCHAR(100),
    publish_date DATE,
    create_time DATETIME DEFAULT NOW(),
    update_time DATETIME DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS chapters (
    id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    chapter_number INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    word_count INT DEFAULT 0,
    is_free INT DEFAULT 0,
    price DECIMAL(10,2) DEFAULT 0.00,
    status INT DEFAULT 1,
    create_time DATETIME DEFAULT NOW(),
    update_time DATETIME DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS favorites (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    create_time DATETIME DEFAULT NOW(),
    UNIQUE KEY unique_favorite (user_id, book_id)
);

CREATE TABLE IF NOT EXISTS reading_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    chapter_id INT,
    last_read_time DATETIME DEFAULT NOW(),
    read_progress INT DEFAULT 0,
    UNIQUE KEY unique_record (user_id, book_id)
);

CREATE TABLE IF NOT EXISTS comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    content TEXT NOT NULL,
    rating INT DEFAULT 5,
    status INT DEFAULT 1,
    create_time DATETIME DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS purchase_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    purchase_time DATETIME DEFAULT NOW(),
    UNIQUE KEY unique_purchase (user_id, book_id)
);

CREATE TABLE IF NOT EXISTS user_book_submissions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category_id INT,
    cover_image VARCHAR(255),
    description TEXT,
    price DECIMAL(10,2) DEFAULT 0.00,
    word_count INT DEFAULT 0,
    is_free INT DEFAULT 0,
    status INT DEFAULT 0,
    reject_reason VARCHAR(255),
    create_time DATETIME DEFAULT NOW(),
    update_time DATETIME DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS user_chapter_submissions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    chapter_number INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    is_free INT DEFAULT 0,
    status INT DEFAULT 0,
    reject_reason VARCHAR(255),
    create_time DATETIME DEFAULT NOW(),
    update_time DATETIME DEFAULT NOW()
);

ALTER TABLE books ADD INDEX IF NOT EXISTS idx_category (category_id);
ALTER TABLE chapters ADD INDEX IF NOT EXISTS idx_book (book_id);
ALTER TABLE favorites ADD INDEX IF NOT EXISTS idx_user_fav (user_id);
ALTER TABLE favorites ADD INDEX IF NOT EXISTS idx_book_fav (book_id);
ALTER TABLE reading_records ADD INDEX IF NOT EXISTS idx_user_read (user_id);
ALTER TABLE reading_records ADD INDEX IF NOT EXISTS idx_book_read (book_id);
ALTER TABLE comments ADD INDEX IF NOT EXISTS idx_user_comment (user_id);
ALTER TABLE comments ADD INDEX IF NOT EXISTS idx_book_comment (book_id);
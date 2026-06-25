CREATE DATABASE IF NOT EXISTS book_store DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE book_store;

CREATE TABLE users (
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

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    parent_id INT DEFAULT 0,
    sort_order INT DEFAULT 0,
    icon VARCHAR(255),
    status INT DEFAULT 1,
    create_time DATETIME DEFAULT NOW()
);

CREATE TABLE books (
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

CREATE TABLE chapters (
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

CREATE TABLE favorites (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    create_time DATETIME DEFAULT NOW(),
    UNIQUE KEY unique_favorite (user_id, book_id)
);

CREATE TABLE reading_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    chapter_id INT,
    last_read_time DATETIME DEFAULT NOW(),
    read_progress INT DEFAULT 0,
    UNIQUE KEY unique_record (user_id, book_id)
);

CREATE TABLE comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    content TEXT NOT NULL,
    rating INT DEFAULT 5,
    status INT DEFAULT 1,
    create_time DATETIME DEFAULT NOW()
);

CREATE TABLE purchase_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    purchase_time DATETIME DEFAULT NOW(),
    UNIQUE KEY unique_purchase (user_id, book_id)
);

INSERT INTO users (username, password, nickname, role, status) VALUES 
('admin', 'admin123', 'admin', 'admin', 1);

INSERT INTO categories (name, description, parent_id, sort_order) VALUES 
('玄幻小说', '玄幻奇幻类小说', 0, 1),
('都市小说', '都市生活类小说', 0, 2),
('历史小说', '历史军事类小说', 0, 3),
('科幻小说', '科幻未来类小说', 0, 4),
('言情小说', '言情爱情类小说', 0, 5),
('武侠小说', '武侠仙侠类小说', 0, 6),
('悬疑小说', '悬疑推理类小说', 0, 7),
('文学名著', '经典文学作品', 0, 8);

INSERT INTO books (title, author, category_id, description, price, word_count, chapter_count, status, is_free, view_count, favorite_count, rating) VALUES 
('斗破苍穹', '天蚕土豆', 1, '斗气世界的传奇故事', 0.00, 5000000, 1600, 2, 1, 100000, 50000, 9.5),
('完美世界', '辰东', 1, '大荒世界的冒险', 0.00, 4000000, 1200, 2, 1, 80000, 40000, 9.3),
('都市至尊', '作者A', 2, '都市传奇', 30.00, 3000000, 800, 2, 0, 60000, 30000, 8.8),
('明朝那些事儿', '当年明月', 3, '历史故事', 0.00, 2000000, 500, 2, 1, 90000, 45000, 9.6),
('三体', '刘慈欣', 4, '科幻巨作', 50.00, 2500000, 300, 2, 0, 120000, 60000, 9.8),
('何以笙箫默', '顾漫', 5, '言情小说', 20.00, 1500000, 400, 2, 0, 70000, 35000, 9.0),
('天龙八部', '金庸', 6, '武侠经典', 0.00, 3000000, 800, 2, 1, 150000, 80000, 9.7),
('鬼吹灯', '天下霸唱', 7, '悬疑探险', 40.00, 2000000, 600, 2, 0, 50000, 25000, 8.5),
('红楼梦', '曹雪芹', 8, '文学名著', 0.00, 1000000, 120, 2, 1, 200000, 100000, 9.9);

INSERT INTO chapters (book_id, chapter_number, title, content, word_count, is_free) VALUES 
(1, 1, '第一章 陨落的天才', '萧炎站在山崖之上...', 3000, 1),
(1, 2, '第二章 家族危机', '萧家大厅内...', 3500, 1),
(1, 3, '第三章 神秘戒指', '萧炎回到房间...', 2800, 0),
(2, 1, '第一章 石村', '大荒深处...', 3200, 1),
(2, 2, '第二章 神山', '远处神山...', 3600, 1),
(2, 3, '第三章 小不点', '石村中有个孩子...', 3000, 0),
(5, 1, '第一章 科学边界', '汪淼站在门前...', 4000, 1),
(5, 2, '第二章 三体问题', '叶文洁接收到信号...', 4500, 1),
(5, 3, '第三章 宇宙闪烁', '宇宙为你闪烁...', 3800, 0);

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

ALTER TABLE books ADD INDEX idx_category (category_id);
ALTER TABLE chapters ADD INDEX idx_book (book_id);
ALTER TABLE favorites ADD INDEX idx_user (user_id);
ALTER TABLE favorites ADD INDEX idx_book (book_id);
ALTER TABLE reading_records ADD INDEX idx_user (user_id);
ALTER TABLE reading_records ADD INDEX idx_book (book_id);
ALTER TABLE comments ADD INDEX idx_user (user_id);
ALTER TABLE comments ADD INDEX idx_book (book_id);

CREATE TABLE user_chapter_submissions (
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
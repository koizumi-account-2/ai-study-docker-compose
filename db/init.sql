-- テーブル削除（順番に注意）
DROP TABLE IF EXISTS T_USER_AGENT_USAGE;
DROP TABLE IF EXISTS T_USER_CONTEXT;
DROP TABLE IF EXISTS T_USER;
DROP TABLE IF EXISTS T_AUTHORITY;

-- T_AUTHORITY テーブル
CREATE TABLE T_AUTHORITY (
    id CHAR(1) PRIMARY KEY,
    rank VARCHAR(20) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- T_USER テーブル
CREATE TABLE T_USER (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    authority_id CHAR(1) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (authority_id) REFERENCES T_AUTHORITY(id)
);

-- T_USER_CONTEXT テーブル
CREATE TABLE T_USER_CONTEXT (
    id INT PRIMARY KEY,
    user_context VARCHAR(255),
    total_tokens INTEGER,
    FOREIGN KEY (id) REFERENCES T_USER(id)
);

-- T_USER_AGENT_USAGE テーブル
CREATE TABLE T_USER_AGENT_USAGE (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    prompt_tokens INTEGER NOT NULL,
    completion_tokens INTEGER NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (email) REFERENCES T_USER(email)
);

-- 権限の初期データ
INSERT INTO T_AUTHORITY (id, rank, description) VALUES
('A','ADMIN', 'Administrator Level'),
('B','POWER_USER','Moderator Level'),
('C','NORMAL','User Level');

-- ユーザーの初期データ
INSERT INTO T_USER (email, password, authority_id) VALUES
('admin@example.com', 'test','A'),
('moderator@example.com', '$2a$10$yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy','B'),
('user@example.com', 'test','C');

-- ユーザーコンテキストの初期データ
INSERT INTO T_USER_CONTEXT (id, user_context, total_tokens) VALUES
(1, 'IT企業に入社してから３年が経過しました。特にフロントエンドが得意分野です。', 123),
(2, 'IT企業に入社してから10年が経過しました。特にインフラが得意分野です。', 4000);
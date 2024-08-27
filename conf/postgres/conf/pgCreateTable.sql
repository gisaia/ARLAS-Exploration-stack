DROP TABLE IF EXISTS user_data;

CREATE TABLE user_data (
    docKey VARCHAR(255) NOT NULL,
    docZone VARCHAR(255) NOT NULL,
    docOwner VARCHAR(255) NOT NULL,
    docOrganization VARCHAR(255) NOT NULL,
    id VARCHAR(255) PRIMARY KEY,
    lastUpdateDate TIMESTAMP,
    docValue JSON
);
CREATE UNIQUE INDEX doc_key_idx_orga ON user_data (docKey, docZone,docOrganization);

DROP TABLE IF EXISTS user_data_readers;

CREATE TABLE user_data_readers (
    data_id VARCHAR(255) ,
    reader VARCHAR(255) NOT NULL,
    FOREIGN KEY (data_id) REFERENCES user_data (id)
);

DROP TABLE IF EXISTS user_data_writers;

CREATE TABLE user_data_writers (
    data_id VARCHAR(255) ,
    writer VARCHAR(255) NOT NULL,
    FOREIGN KEY (data_id) REFERENCES user_data (id)
);
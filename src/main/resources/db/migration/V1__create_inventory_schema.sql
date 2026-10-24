-- Initial schema for the current JPA entities.
-- Hibernate's Spring Boot physical naming strategy maps camelCase fields to snake_case columns.

CREATE TABLE category (
    category_id INT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(255),
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (category_id)
) ENGINE=InnoDB;

CREATE TABLE category_log (
    category_id INT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(255),
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (category_id)
) ENGINE=InnoDB;

CREATE TABLE invoice (
    invoice_id INT NOT NULL AUTO_INCREMENT,
    line_total DOUBLE NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(255),
    quantity DOUBLE NOT NULL,
    total DOUBLE NOT NULL,
    version DECIMAL(38, 2),
    PRIMARY KEY (invoice_id)
) ENGINE=InnoDB;

CREATE TABLE permission (
    permission_id INT NOT NULL AUTO_INCREMENT,
    permission_name VARCHAR(255),
    PRIMARY KEY (permission_id)
) ENGINE=InnoDB;

CREATE TABLE permission_log (
    permission_id INT NOT NULL AUTO_INCREMENT,
    permission_name VARCHAR(255),
    PRIMARY KEY (permission_id)
) ENGINE=InnoDB;

CREATE TABLE pricing (
    pricing_id INT NOT NULL AUTO_INCREMENT,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    pricing_discount_precentage DECIMAL(38, 2),
    pricing_effective_date DATE,
    pricing_expire_date DATE,
    pricing_name VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (pricing_id)
) ENGINE=InnoDB;

CREATE TABLE pricing_log (
    pricing_id INT NOT NULL AUTO_INCREMENT,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    pricing_discount_precentage DECIMAL(38, 2),
    pricing_effective_date DATE,
    pricing_expire_date DATE,
    pricing_name VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (pricing_id)
) ENGINE=InnoDB;

CREATE TABLE product (
    product_id INT NOT NULL AUTO_INCREMENT,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    productbuying_price DOUBLE NOT NULL,
    product_is_service TINYINT NOT NULL,
    product_name VARCHAR(255),
    productselling_price DOUBLE NOT NULL,
    version DECIMAL(38, 2),
    category_id INT,
    PRIMARY KEY (product_id),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category (category_id)
) ENGINE=InnoDB;

CREATE TABLE product_log (
    product_id INT NOT NULL AUTO_INCREMENT,
    category_id INT NOT NULL,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    pricing_id INT NOT NULL,
    productbuying_price DOUBLE NOT NULL,
    product_is_service TINYINT NOT NULL,
    product_name VARCHAR(255),
    productselling_price DOUBLE NOT NULL,
    version DECIMAL(38, 2),
    PRIMARY KEY (product_id)
) ENGINE=InnoDB;

CREATE TABLE role (
    role_id INT NOT NULL AUTO_INCREMENT,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    role_name VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (role_id)
) ENGINE=InnoDB;

CREATE TABLE role_log (
    role_id INT NOT NULL AUTO_INCREMENT,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    role_name VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (role_id)
) ENGINE=InnoDB;

CREATE TABLE stock (
    ref_id INT NOT NULL AUTO_INCREMENT,
    branch_id VARCHAR(255),
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    date_stock DATE,
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    quantity INT NOT NULL,
    version DECIMAL(38, 2),
    category_id INT,
    product_id INT,
    supplier_id INT,
    PRIMARY KEY (ref_id),
    CONSTRAINT fk_stock_category FOREIGN KEY (category_id) REFERENCES category (category_id),
    CONSTRAINT fk_stock_product FOREIGN KEY (product_id) REFERENCES product (product_id),
    CONSTRAINT fk_stock_supplier FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
) ENGINE=InnoDB;

CREATE TABLE stock_log (
    ref_id INT NOT NULL AUTO_INCREMENT,
    category_id INT NOT NULL,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    date_stock DATE,
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    supplier_id INT NOT NULL,
    version DECIMAL(38, 2),
    PRIMARY KEY (ref_id)
) ENGINE=InnoDB;

CREATE TABLE supplier (
    supplier_id INT NOT NULL AUTO_INCREMENT,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    supplier_company VARCHAR(255),
    supplier_contact DECIMAL(38, 2),
    supplier_name VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (supplier_id)
) ENGINE=InnoDB;

CREATE TABLE supplier_log (
    supplier_id INT NOT NULL AUTO_INCREMENT,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    supplier_company VARCHAR(255),
    supplier_contact DECIMAL(38, 2),
    supplier_name VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (supplier_id)
) ENGINE=InnoDB;

CREATE TABLE `user` (
    user_id INT NOT NULL AUTO_INCREMENT,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    user_address VARCHAR(255),
    user_contact_number DECIMAL(38, 2),
    user_email VARCHAR(255),
    user_fname VARCHAR(255),
    user_lname VARCHAR(255),
    user_name VARCHAR(255),
    password VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (user_id)
) ENGINE=InnoDB;

CREATE TABLE user_log (
    user_id INT NOT NULL AUTO_INCREMENT,
    created_date_time DATETIME(6),
    created_user VARCHAR(255),
    last_modified_date_time DATETIME(6),
    last_modified_user VARCHAR(255),
    user_address VARCHAR(255),
    user_contact_number DECIMAL(38, 2),
    user_email VARCHAR(255),
    user_fname VARCHAR(255),
    user_lname VARCHAR(255),
    user_name VARCHAR(255),
    version DECIMAL(38, 2),
    PRIMARY KEY (user_id)
) ENGINE=InnoDB;

CREATE TABLE product_invoice (
    ref_id INT NOT NULL AUTO_INCREMENT,
    invoice_invoice_id INT,
    product_product_id INT,
    PRIMARY KEY (ref_id),
    CONSTRAINT fk_product_invoice_invoice FOREIGN KEY (invoice_invoice_id) REFERENCES invoice (invoice_id),
    CONSTRAINT fk_product_invoice_product FOREIGN KEY (product_product_id) REFERENCES product (product_id)
) ENGINE=InnoDB;

CREATE TABLE product_pricing (
    ref_id INT NOT NULL AUTO_INCREMENT,
    pricing_pricing_id INT,
    product_product_id INT,
    PRIMARY KEY (ref_id),
    CONSTRAINT fk_product_pricing_pricing FOREIGN KEY (pricing_pricing_id) REFERENCES pricing (pricing_id),
    CONSTRAINT fk_product_pricing_product FOREIGN KEY (product_product_id) REFERENCES product (product_id)
) ENGINE=InnoDB;

CREATE TABLE role_permission (
    ref_id INT NOT NULL AUTO_INCREMENT,
    permission_permission_id INT,
    role_role_id INT,
    PRIMARY KEY (ref_id),
    CONSTRAINT fk_role_permission_permission FOREIGN KEY (permission_permission_id) REFERENCES permission (permission_id),
    CONSTRAINT fk_role_permission_role FOREIGN KEY (role_role_id) REFERENCES `role` (role_id)
) ENGINE=InnoDB;

CREATE TABLE user_role (
    ref_id INT NOT NULL AUTO_INCREMENT,
    role_role_id INT,
    user_user_id INT,
    PRIMARY KEY (ref_id),
    CONSTRAINT fk_user_role_role FOREIGN KEY (role_role_id) REFERENCES `role` (role_id),
    CONSTRAINT fk_user_role_user FOREIGN KEY (user_user_id) REFERENCES `user` (user_id)
) ENGINE=InnoDB;

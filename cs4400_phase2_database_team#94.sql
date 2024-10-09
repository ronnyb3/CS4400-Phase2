CREATE TABLE User (
    username VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(255),
    birthdate DATE
);
CREATE TABLE Product (
    barcode VARCHAR(50) PRIMARY KEY,
    iname VARCHAR(100) NOT NULL,
    weight DECIMAL(10, 2)
);
CREATE TABLE Location (
    label VARCHAR(50) PRIMARY KEY,
    space DECIMAL(10, 2),
    x_coord DECIMAL(10, 2) NOT NULL,
    y_coord DECIMAL(10, 2) NOT NULL
);
CREATE TABLE Business (
    name VARCHAR(100) PRIMARY KEY,
    rating DECIMAL(3, 2),
    spent DECIMAL(15, 2),
    location_label VARCHAR(50),
    FOREIGN KEY (location_label) REFERENCES Location(label)
);
CREATE TABLE Service (
    ID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location_label VARCHAR(50),
    managed_by VARCHAR(50),
    FOREIGN KEY (location_label) REFERENCES Location(label)
    FOREIGN KEY (managed_by) REFERENCES Worker(username)
);
CREATE TABLE Van (
    tag VARCHAR(50),
    ID int,
    capacity DECIMAL(10, 2),
    sales DECIMAL(15, 2),
    fuel DECIMAL(10, 2),
    controlled_by VARCHAR(50),
    owned_by VARCHAR(50),
    location_label VARCHAR(50),
    PRIMARY KEY (tag, ID),
    FOREIGN KEY (ID) REFERENCES Service(ID),
    FOREIGN KEY (controlled_by) REFERENCES Driver(username)
    FOREIGN KEY (owned_by) REFERENCES Service(ID)
    FOREIGN KEY (location_label) REFERENCES Location(label)
);
CREATE TABLE Employee (
    username VARCHAR(50) PRIMARY KEY,
    taxID VARCHAR(50) NOT NULL,
    hired DATE,
    salary DECIMAL(15, 2),
    experience INT,
    FOREIGN KEY (username) REFERENCES User(username)
);
CREATE TABLE Owner (
    username VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (username) REFERENCES User(username)
);
CREATE TABLE Driver (
    username VARCHAR(50) PRIMARY KEY,
    licenseID VARCHAR(50) NOT NULL,
    license_type VARCHAR(50),
    successful_trips INT,
    FOREIGN KEY (username) REFERENCES User(username)
);
CREATE TABLE Worker (
    username VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (username) REFERENCES User(username)
);
CREATE TABLE Fund (
    owner_username VARCHAR(50),
    business_name VARCHAR(100),
    invested DECIMAL(15, 2),
    date DATE,
    PRIMARY KEY (owner_username, business_name),
    FOREIGN KEY (owner_username) REFERENCES Owner(username),
    FOREIGN KEY (business_name) REFERENCES Business(name)
);
CREATE TABLE WorkFor (
    worker_username VARCHAR(50),
    service_ID INT,
    PRIMARY KEY (worker_username, service_ID),
    FOREIGN KEY (worker_username) REFERENCES Worker(username),
    FOREIGN KEY (service_ID) REFERENCES Service(ID)
);
CREATE TABLE Contain (
    van_tag VARCHAR(50),
    vanID INT,
    product_barcode VARCHAR(50),
    quantity INT,
    price DECIMAL(15, 2),
    PRIMARY KEY (van_tag, vanID, product_barcode),
    FOREIGN KEY (van_tag, vanID) REFERENCES Van(tag, ID),
    FOREIGN KEY (product_barcode) REFERENCES Product(barcode)
);

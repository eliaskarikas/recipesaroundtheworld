DROP DATABASE IF EXISTS culinary;
CREATE DATABASE culinary;
USE culinary;

DROP TABLE IF EXISTS Region;
CREATE TABLE Region (
	region_id INT PRIMARY KEY AUTO_INCREMENT, 
    region_name VARCHAR(200) NOT NULL
);


DROP TABLE IF EXISTS Recipe;
CREATE TABLE Recipe (
	recipe_id INT PRIMARY KEY AUTO_INCREMENT,
    recipe_name VARCHAR(200) NOT NULL,
    region_id INT NOT NULL,
    CONSTRAINT recip_fk_region FOREIGN KEY (region_id) REFERENCES Region (region_id) 
);


DROP TABLE IF EXISTS Ingredient;
CREATE TABLE Ingredient (
	ingredient_id INT PRIMARY KEY AUTO_INCREMENT,
    ingredient_name VARCHAR(256) NOT NULL,
    category VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Ingredient_List;
CREATE TABLE Ingredient_List (
	recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    CONSTRAINT il_fk_recipe FOREIGN KEY (recipe_id) REFERENCES Recipe (recipe_id),
    CONSTRAINT il_fk_ingred FOREIGN KEY (ingredient_id) REFERENCES Ingredient (ingredient_id)
    
);

CREATE TABLE Country (
	country_name VARCHAR(75) NOT NULL,
	country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_code VARCHAR(8) NOT NULL,
    region_id INT NOT NULL,
    CONSTRAINT country_fk_reg FOREIGN KEY (region_id) REFERENCES Region (region_id)
);

DROP TABLE IF EXISTS Diet_Composition;
CREATE TABLE Diet_Composition (
	diet_composition_id INT PRIMARY KEY AUTO_INCREMENT,
    animal_protein FLOAT NOT NULL,
    plant_protein FLOAT NOT NULL,
    fats FLOAT NOT NULL,
	carbohydrates FLOAT NOT NULL,
    calories INT,
    year YEAR NOT NULL,
    country_id INT NOT NULL,
    CONSTRAINT dc_fk_country FOREIGN KEY (country_id) REFERENCES Country (country_id)
    );
    
DROP TABLE IF EXISTS Disease;
CREATE TABLE Disease (
	disease_id INT PRIMARY KEY AUTO_INCREMENT,
    obesity_popshare VARCHAR(10),
    undernourishment_popshare VARCHAR(10),
    gdp INT,
    year YEAR NOT NULL,
    country_id INT NOT NULL,
    CONSTRAINT dis_fk_country FOREIGN KEY (country_id) REFERENCES Country (country_id)
);

LOAD DATA LOCAL INFILE './CulinaryDB/region.csv'
INTO TABLE region
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\n"
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './CulinaryDB/Recipetable.txt'
INTO TABLE recipe
FIELDS TERMINATED BY "	"
LINES TERMINATED BY "\n"
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './CulinaryDB/ingredient.csv'
INTO TABLE ingredient
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\n"
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './CulinaryDB/ingredient_list.csv'
INTO TABLE ingredient_list
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\n"
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './CulinaryDB/countryid.csv'
INTO TABLE country
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\n"
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './CulinaryDB/disease.csv'
INTO TABLE disease
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\n"
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './CulinaryDB/diet_composition.csv'
INTO TABLE diet_composition
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\n"
IGNORE 1 LINES;

UPDATE disease SET gdp=NULL WHERE gdp=0;
UPDATE disease SET undernourishment_popshare=NULL WHERE undernourishment_popshare like "0";
UPDATE diet_composition SET calories=NULL WHERE calories=0;
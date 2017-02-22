# create MappedProducts table:
USE DSM;
CREATE TABLE MappedProducts (
	product MEDIUMINT(8) unsigned,
    place_name VARCHAR(128),
    spatial_resolution VARCHAR(128),
    area_description VARCHAR(128),
    product_description VARCHAR(128)
);
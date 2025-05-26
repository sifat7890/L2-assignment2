CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(200) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50)
);

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES species(species_id),
    ranger_id INTEGER REFERENCES rangers(ranger_id),
    location VARCHAR(200) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT
);


INSERT INTO rangers( name,region) VALUES
(  'Alice Green', 'Northern Hills'),
(  'Bob White', 'River Delta'),
(  'Carol King', 'Mountain Range');

INSERT INTO species( common_name,scientific_name,discovery_date,conservation_status) VALUES
( 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
( 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
( 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
( 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

INSERT INTO sightings( species_id,ranger_id,location,sighting_time,notes) VALUES
( 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
( 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
( 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
( 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

 


-- Problem 1:
INSERT INTO rangers( name,region) VALUES('Derek Fox','Coastal Plains');

-- Problem 2:
SELECT COUNT(species_id) AS unique_species_count FROM species;

-- Problem 3:
SELECT * FROM sightings  WHERE location LIKE '%Pass%';

-- Problem 4:
SELECT name,COUNT(sightings.sighting_id) AS total_sightings  FROM rangers
LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY name;

-- Problem 5:
SELECT common_name FROM species WHERE species_id NOT IN (SELECT species_id FROM  sightings);

-- Problem 6:
SELECT common_name ,sighting_time ,name FROM sightings
JOIN species on species.species_id =sightings.species_id
JOIN rangers on rangers.ranger_id =sightings.ranger_id
ORDER BY sighting_time DESC LIMIT 2 ;


-- Problem 7:
UPDATE species SET conservation_status ='Historic' WHERE discovery_date <'1800-01-01';

-- Problem 8:
SELECT sighting_id, 
    case
        WHEN extract(HOUR FROM sighting_time)<12 THEN 'Morning'
        WHEN extract(HOUR FROM sighting_time)BETWEEN 12 AND 17 THEN 'Afternoon'
        Else 'Evening'
    END AS time_of_day
FROM  sightings;

-- Problem 9:
DELETE FROM rangers WHERE ranger_id NOT IN(SELECT ranger_id FROM  sightings);
--Database creation using the csv files from https://github.com/MuseumofModernArt/collection

CREATE TABLE artists(
  ConstituentID TEXT NOT NULL PRIMARY KEY UNIQUE,	
  DisplayName TEXT,
  ArtistBio TEXT,
  Nationality TEXT,
  Gender TEXT,
  BeginDate TEXT,
  EndDate TEXT,
  "Wiki QID" TEXT,
  ULAN INT);
  
copy artists (ConstituentID, DisplayName, ArtistBio, Nationality, Gender, BeginDate, EndDate, "Wiki QID", ULAN) from '/Users/awesome/Downloads/Artists.csv' WITH (FORMAT CSV, HEADER);

CREATE TABLE artworks(
  Title	TEXT,
  Artist	TEXT,
  ConstituentID	TEXT,
  ArtistBio	TEXT,
  Nationality	TEXT,
  BeginDate	TEXT,
  EndDate	TEXT,
  Gender TEXT,
  "Date" TEXT,
  Medium TEXT,
  Dimensions TEXT,
  CreditLine	TEXT,
  AccessionNumber	TEXT,
  Classification	TEXT,
  Department	TEXT,
  DateAcquired	TEXT,
  Cataloged	TEXT,
  ObjectID	INT NOT NULL PRIMARY KEY UNIQUE,
  URL	TEXT,
  ThumbnailURL TEXT,
  "Circumference (cm)" TEXT,
  "Depth (cm)" TEXT,
  "Diameter (cm)"	TEXT,
  "Height (cm)" TEXT,
  "Length (cm)" TEXT,
  "Weight (kg)" TEXT,
  "Width (cm)" TEXT,	
  "Seat Height (cm)" TEXT,
  "Duration (sec.)" TEXT
);
  
  
copy artworks (Title, Artist, ConstituentID, ArtistBio, Nationality, BeginDate, EndDate, Gender, "Date", Medium, Dimensions, CreditLine, 
  AccessionNumber, Classification, Department, DateAcquired, Cataloged, ObjectID, URL, ThumbnailURL,
  "Circumference (cm)",	"Depth (cm)",	"Diameter (cm)",	"Height (cm)",	"Length (cm)", "Weight (kg)",	"Width (cm)",	"Seat Height (cm)",	"Duration (sec.)"
             )from '/Users/awesome/Downloads/Artworks.csv' WITH (FORMAT CSV, HEADER);

CREATE TABLE artworks2 AS
SELECT *, unnest(string_to_array(constituentid, ', ')) as "constituentid2", unnest(string_to_array(artist, ', ')) as "artist2" 
FROM artworks;

CREATE TABLE artists_artworks AS
SELECT Title, artist2, constituentid2, ObjectID
FROM artworks2;

ALTER TABLE artists_artworks
ADD CONSTRAINT artists_artworks_fk
FOREIGN KEY (constituentid2) REFERENCES artists(constituentid);

CREATE TABLE dimensions AS
SELECT title, ObjectID, Dimensions, "Depth (cm)",	"Height (cm)",	"Width (cm)"
FROM artworks;

ALTER TABLE dimensions 
ADD CONSTRAINT unq_ObjectID UNIQUE (ObjectID);

ALTER TABLE artists_artworks
ADD CONSTRAINT artists_artworks_fk2
FOREIGN KEY (ObjectID) REFERENCES dimensions(ObjectID);

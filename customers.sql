BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "customers" (
	"id"	INTEGER NOT NULL,
	"name"	string NOT NULL,
	"email"	string NOT NULL UNIQUE,
	"date_added"	date DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "customers" VALUES (1,'mariospr','mariosp@gmail.com','2024-07-20 13:09:47');
INSERT INTO "customers" VALUES (2,'leandros','thoidhsleandros@gmail.com','2024-07-20 13:15:41');
INSERT INTO "customers" VALUES (4,'nikolas','nikolas@gmail.com','2024-07-22');
INSERT INTO "customers" VALUES (5,'giorgos','giorgos@hotmail.gr','2024-07-22');
INSERT INTO "customers" VALUES (6,'neoklhs','neoklhsemail@gmail.com','2024-07-22');
INSERT INTO "customers" VALUES (7,'giannhs','giannhs@yahoo.gr','2024-07-22');
INSERT INTO "customers" VALUES (8,'andreas','andreast@gmail.com','2024-07-22');
INSERT INTO "customers" VALUES (10,'Anastasia','Anastasia@gmail.com','2024-07-22');
COMMIT;

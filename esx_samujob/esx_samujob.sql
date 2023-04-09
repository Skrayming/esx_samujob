USE `essentialmode`;



INSERT INTO `addon_account` (name, label, shared) VALUES

	('society_samu', 'samu', 1)

;



INSERT INTO `addon_inventory` (name, label, shared) VALUES

	('society_samu', 'samu', 1)

;



INSERT INTO `datastore` (name, label, shared) VALUES

	('society_samu', 'SMUR', 1)

;



INSERT INTO `job_grades` (job_name, grade, name, label, salary) VALUES

	('samu',0,'recruit','Stagiaire',20)

	('samu',1,'officer','Medecin',40,)

	('samu',2,'boss','Chirurgien',80)



INSERT INTO `jobs` (name, label) VALUES

	('samu','samu')

;




ALTER TABLE `users`

	ADD `is_dead` TINYINT(1) NULL DEFAULT '0'

;


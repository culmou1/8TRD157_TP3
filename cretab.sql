drop table Film CASCADE CONSTRAINTS;
drop table EquipeTournage CASCADE CONSTRAINTS;
drop table Role CASCADE CONSTRAINTS;
drop table Membre CASCADE CONSTRAINTS;
drop table Employe CASCADE CONSTRAINTS;
drop table Client CASCADE CONSTRAINTS;
drop table Adresse CASCADE CONSTRAINTS;
drop table Location CASCADE CONSTRAINTS;
drop table Copie CASCADE CONSTRAINTS;
drop table Forfait CASCADE CONSTRAINTS;
drop table InfoCredit CASCADE CONSTRAINTS;
drop table GenreFilm CASCADE CONSTRAINTS;
drop table Genre CASCADE CONSTRAINTS;
drop table PaysFilm CASCADE CONSTRAINTS;
drop table Pays CASCADE CONSTRAINTS;
drop table Scenariste CASCADE CONSTRAINTS;
drop table Annonce CASCADE CONSTRAINTS;
drop table TypeTournage CASCADE CONSTRAINTS;
drop sequence SequenceIdMembre;
drop sequence SequenceIdForfait;
drop sequence SequenceIdFilms;
drop fonction FINDIDFORFAIT;
drop procedure AjoutForfait;
drop procedure AjoutClient;
drop procedure AjoutMembre;
drop procedure AjoutFilm;
create table TypeTournage
(
	idTypeTournage number(10) primary key,
	fonction char(70) not null
);
create table EquipeTournage
(
	idPersonne number(10) primary key,
	nom char(70) not null,
	anniversaire date,
	lieu char(70),
	photo char(255),
	bio blob,
	fk_idTypeTournage number(10) not null,
	foreign key (fk_idTypeTournage) references TypeTournage(idTypeTournage)
);
create table Film
(
	idFilm number(10) primary key,
	titre char(90) not null,
	annee number(4) not null,
	langue char(90) not null,
	duree number(4) not null,
	resumes blob not null,
	realisateur char(90) not null,
	poster char(255) not null,
	equipeTournageIdRealisateur number(10) references EquipeTournage(idPersonne) not null,
	CHECK (annee > 1894),
	CHECK (duree > 0)
);
create table Membre
(
	idMembre number(10) primary key,
	nomFamille char(50) not null,
	prenom char(50) not null,
	courriel char(65) not null unique,
	tel char(25) not null,
	anniversaire date not null,
	motDePasse char(50) not null
);
create table Employe
(
	fk_idMembre number(10) not null,
	matricule char(7) not null unique,
	foreign key (fk_idMembre) references Membre(idMembre)
);
create table Forfait
(
	idForfait number(10) primary key,
	nom char(255) unique,
	counts float(10),
	locationMaximale number(3) not null,
	duree number(3) not null,
	CHECK (duree > 0),
	CHECK (locationMaximale > 0)
);
create table Client
(
	fk_idMembre number(10) not null,
	idForfait number(10) references Forfait(idForfait),
	foreign key (fk_idMembre) references Membre(idMembre)
);
create table Adresse
(
	fk_idMembre number(10) not null,
	adresse char(70) not null,
	ville char(60) not null,
	province char(60) not null,
	codePostal char(10) not null,
	foreign key (fk_idMembre) references Membre(idMembre)
);
create table Copie
(
	numeroCopie number(10) primary key,
	idFilm number(10) references Film(idFilm)
);
create table Location
(
	idLocation number(10) primary key,
	idMembre number(10) references Membre(idMembre),
	numeroCopie number(10) references Copie(numeroCopie),
	dateLocation date not null
);
create table InfoCredit
(
	fk_idMembre number(10) not null,
	carte char(50) not null,
	numero_carte char(40) not null,
	expMois number(2) not null,
	expAnnee number(4) not null,
	CVV number(3) not null,
	foreign key (fk_idMembre) references Membre(idMembre),
	CHECK (expMois BETWEEN 1 AND 12)
	/*CHECK (expAnnee >= CURRENT_DATE("YYYY"))*/
);
create table Genre
(
	idGenre number(10) primary key,
	genre char(50) not null unique
);
create table GenreFilm
(
	idFilm number(10) references Film(idFilm),
	ifGenre number(10) references Genre(idGenre)
);
create table Pays
(
	idPays number(10) primary key,
	pays char(50) not null unique
);
create table PaysFilm
(
	idFilm number(10) references Film(idFilm),
	idPays number(10) references Pays(idPays)
);
create table Scenariste
(
	idScenariste number(10) primary key,
	idFilm number(10) references Film(idFilm),
	nom char(70) not null
);
create table Annonce
(
	idAnnonce number(10) primary key,
	idFilm number(10) references Film(idFilm),
	annonce char(255) not null
);
create table Role
(
	idRole number(10) primary key,
	idPersonne number(10) references EquipeTournage(idPersonne),
	idFilm number(10) references Film(idFilm),
	personnage char(70) not null
);


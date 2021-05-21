drop database if exists kolokvij_vjezba_4;
create database kolokvij_vjezba_4;
use kolokvij_vjezba_4;

create table punac(
	sifra int not null primary key auto_increment,
	treciputa datetime,
	majica varchar(46),
	jmbag char(11) not null,
	novcica decimal(18,7) not null,
	maraka decimal(12,6)not null,
	ostavljen int not null
);

create table ostavljen(
	sifra int not null primary key auto_increment,
	modelnaocala varchar(43),
	introvertno bit,
	kuna decimal(14,10)
);

create table snasa(
	sifra int not null primary key auto_increment,
	introvertno bit,
	treciputa datetime,
	haljina varchar(44) not null,
	zena int not null
);

create table becar(
	sifra int not null primary key auto_increment,
	novcica decimal(14,8),
	kratkamajica varchar(48) not null,
	bojaociju varchar(36) not null,
	snasa int not null
);

create table prijatelj(
	sifra int not null primary key auto_increment,
	eura decimal(16,9),
	prstena int not null,
	gustoca decimal(16,5),
	jmbag char(11) not null,
	suknja varchar(47) not null,
	becar int not null
);

create table zena(
	sifra int not null primary key auto_increment,
	suknja varchar(39) not null,
	lipa decimal(18,7),
	prstena int not null
);

create table mladic(
	sifra int not null primary key auto_increment,
	kuna decimal(15,9),
	lipa decimal(18,5),
	nausnica int,
	stilfrizura varchar(49),
	vesta varchar(34) not null
);

create table zena_mladic(
	sifra int not null primary key auto_increment,
	zena int not null,
	mladic int not null
);

alter table punac add foreign key (ostavljen) references ostavljen(sifra);

alter table prijatelj add foreign key (becar) references becar(sifra);

alter table becar add foreign key (snasa) references snasa(sifra);

alter table snasa add foreign key (zena) references zena(sifra);

alter table zena_mladic add foreign key (zena) references zena(sifra);
alter table zena_mladic add foreign key (mladic) references mladic(sifra);

#U tablice becar, snasa i zena_mladic unesite po 3 retka.

insert into zena(suknja,prstena)
values('plava suknja',1), 
('zelena suknja',2), 
('bijela suknja',2);

insert into snasa(haljina,zena)
values('crvena haljina',1),
('crna haljina',2),
('ljetna haljina',3);

insert into becar(kratkamajica,bojaociju,snasa)
values('bijela','crna',3),
('sportska','smeđa',2),
('za po kući','zelena',1);

insert into mladic(vesta)
values('Adidas'),('Nike'),('Iz Lidla');

insert into zena_mladic(zena,mladic)
values(3,1),(3,2),(3,3);

#U tablici punac postavite svim zapisima kolonu majica na vrijednost Osijek.
update punac set majica = 'Osijek';

#U tablici prijatelj obrišite sve zapise čija je vrijednost kolone prstena veće od 17.
delete from prijatelj where prstena > 17;

#Izlistajte haljina iz tablice snasa uz uvjet da vrijednost kolone treciputa nepoznate.
select haljina from snasa where treciputa is null;

/*Prikažite nausnica iz tablice mladic, jmbag iz tablice prijatelj te
kratkamajica iz tablice becar uz uvjet da su vrijednosti kolone
treciputa iz tablice snasa poznate te da su vrijednosti kolone lipa iz
tablice zena različite od 29. Podatke posložite po kratkamajica iz
tablice becar silazno.*/

#mladic, prijatelj, becar, snasa, zena
select a.nausnica, f.jmbag, e.kratkamajica 
from mladic a inner join zena_mladic b on a.sifra = b.mladic 
inner join zena c on b.zena = c.sifra 
inner join snasa d on c.sifra = d.zena 
inner join becar e on d.sifra = e.snasa 
inner join prijatelj f on e.sifra = f.becar 
where d.treciputa is not null and c.lipa != 29.00;

#Prikažite kolone lipa i prstena iz tablice zena čiji se primarni ključ ne nalaze u tablici zena_mladic.
select z.lipa, z.prstena 
from zena z inner join zena_mladic zm on z.sifra = zm.zena 
where zm.zena is null; #nisam siguran je li ovo točno






















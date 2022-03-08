SET SQL_SAFE_UPDATES =0;
create database ExercicioBD;
Use ExercicioBD;
create table ator(
					coda integer,
					nomeart varchar(25), 
                    nomereal varchar(25), 
                    nacionalidade varchar(25),
                    sexo char, 
                    indicacoesoscar integer, 
                    num_oscar integer ,
primary key(coda));


create table Filme(
					codf integer, 
					nome varchar(20), 
					ano year,
                    orcamento float,
					tempo float, 
primary key(codf));

CREATE TABLE personagem(
						coda integer, 
						 codf integer, 
						 personagem varchar(25), 
                        cache float, 
primary key(coda,codf),
foreign key (coda) references ator(coda),
foreign key (codf) references filme(codf)
);


insert into ator(coda,nomeart,nomereal,nacionalidade,sexo,indicacoesoscar,num_oscar)
values(1, 'Demi Moore', 'MariadaSilva','USA','f', 0, 0),
	(2,'Brad Pitt', 'JoaoPaulo','USA','m', 1, 0),
	(3, 'Dustin Hoffman', 'DustinHoffman','USA','m', 2, 0),
	(4, 'Jessica Lange', 'JessicaLange','USA','f', 4, 2),
	(5, 'Sonia Braga', 'SoniaBraga','Brasil','f', 0, 0);


insert into filme (codf,nome,ano,orcamento,tempo)
values(1, 'A Jurada', 1996,1000000, 18),
(2, 'A Letra Escarlate', 1995,10000000, 24),
(3, 'Seven', 1995,1500000, 20),
(4, 'Tootsie', 1982,500000, 16),
(5, 'Tieta', 1995,2000000, 18);

insert into personagem(coda,codf,personagem,cache)
values (1,1,'Mary',3000),
		(1,2,'Sandy',5000),
        (2,3,'John',5000),
        (3,4,'Mary',1000),
        (4,4,'Tootsie',2000),
        (5,5,'Tiete',500);
        
/*Semana 8*/    
#1   
update ator
set sexo = 'm'
where nomeart ='Brad Pitt';

#2
UPDATE personagem
SET cache = cache*1.1;

#3
DELETE FROM  filme
WHERE nome = 'Tieta';

#4
DELETE FROM  personagem
WHERE personagem = 'Tootsie';

#drop table ator; apagando toda a tabela
/*Semana9*/

#1
SELECT*FROM (ator) 
where sexo = 'f';

#2
SELECT sexo,nomeart
FROM (ator);

#3 
SELECT nomeart,num_oscar,indicacoesoscar
FROM (ator);

#4
SELECT filme.codf 
FROM filme,personagem 
WHERE personagem.codf = filme.codf AND personagem.cache < 1000;

#5
SELECT personagem.personagem 
FROM personagem,ator
WHERE ator.coda = personagem.coda IN (SELECT coda FROM ator WHERE ator.nomeart = 'Demi Moore');

#6 
SELECT nome 
FROM filme,personagem,ator 
WHERE filme.codf = personagem.codf AND ator.coda = personagem.coda
IN (SELECT coda FROM ator WHERE ator.nomeart = 'Demi Moore');

#7
SELECT * FROM ator
WHERE nomeart LIKE 'Jessica%';

#8
SELECT nomeart 
FROM ator 
WHERE indicacoesoscar = num_oscar + 2;

#9
#O "asc" vai definir que a ordem é ascendente (crescente), caso queira descendente (decrescente), utilize "desc".
SELECT nomeart 
FROM ator 
ORDER BY nomeart ASC;

#10
SELECT personagem.personagem, nomeart 
FROM personagem, ator 
WHERE ator.coda = personagem.coda AND ator.sexo = 'f';

#11
SELECT COUNT(*)
FROM ator 
WHERE sexo = 'f';

#12
SELECT sum(orcamento) 
FROM filme;


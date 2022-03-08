SET SQL_SAFE_UPDATES =0;
create database script_cinema;
Use script_cinema;

create table ator(coda integer, nomeart varchar(20), nomereal varchar(20), sexo char(2), 
idade integer, indicacoes_oscar integer, oscar integer, primary key(coda)) ENGINE= INNODB;


create table filme(codf integer, nome varchar(20), ano integer, tempo integer, primary key(codf))
ENGINE= INNODB;

CREATE TABLE personagem (coda integer, codf integer, personagem varchar(12), cache real, primary key(coda, codf)) ENGINE= INNODB;

ALTER TABLE personagem ADD foreign key (coda) references ator(coda);
ALTER TABLE personagem ADD foreign key (codf) references filme(codf);


insert into ator values (1, 'demi moore', 'maria da silva','f', 32, 0, 0);
insert into ator values (2, 'brad pitt', 'joao paulo','m', 28, 1, 0);
insert into ator values (3, 'dustin hoffman', 'dustin','m', 46, 2, 0);
insert into ator values (4, 'jessica lange', 'jessica','f', 42, 4, 2);
insert into ator values (5, 'sonia braga', 'sonia braga','f', 60, 0, 0);



insert into filme values(1, 'a jurada', 1996, 18);
insert into filme values(2, 'a letra escarlate', 1995, 24);
insert into filme values(3, 'seven', 1995, 20);
insert into filme values(4, 'tootsie', 1982, 16);
insert into filme values(5, 'tieta', 1995, 18);


insert into personagem values (1,1, 'mary', 3000);
insert into personagem values (1,2, 'sandy', 5000);
insert into personagem values (2,3, 'john', 5000);
insert into personagem values (3,4, 'mary', 10000);
insert into personagem values (4,4, 'tootsie', 2000);
insert into personagem values (5,5, 'tieta', 500);

/*Semana 10*/
#1  a soma das idades das atrizes.
select sum(idade)
from ator
where sexo = 'f';


#2. o nome do artista e o número de filmes em que participou;
select ator.nomeart, count(personagem.coda) 
from ator,personagem 
where ator.coda = personagem.coda 
group by ator.coda;




#3. para cada ator que não ganhou oscar, listar o seu nome, ano de seu filme mais antigo e do mais novo;
SELECT a.nomereal, MIN(F.ano), MAX(f.ano)
FROM ator a, filme f
WHERE a.oscar = '0'
GROUP BY a.nomereal;

#4. para cada filme listar: o nome do filme, média de cachês pagos por filme, cachê mais alto, cachê mais baixo, e total dos cachês pagos;
SELECT movie.nome, AVG(pg.cache), MAX(pg.cache), MIN(pg.cache), SUM(pg.cache)
FROM filme movie, personagem pg
WHERE movie.codf = pg.codf
GROUP BY movie.nome;

#5. o nome do artista e o número de filmes em que participou, para todo artista que participou de no mínimo 2 filmes;
SELECT art.nomeart, COUNT(*)
FROM ator art, filme movie, personagem p
WHERE art.coda = p.coda AND p.codf = movie.codf
GROUP BY art.nomeart
HAVING COUNT(*) >= 2;

#6. o número de caches distintos maiores do que 2000 pagos em cada filme, para todo filme onde a soma dos cachês destes artistas foi inferior a 8000. ( use count (distinct cache) )

SELECT movie.nome, count(distinct cache)
FROM personagem p, filme movie
WHERE p.cache > 2000 AND movie.codf = p.codf
GROUP BY movie.nome
HAVING SUM(p.cache) < 8000
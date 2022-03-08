SET SQL_SAFE_UPDATES =0;
create database ExTrigger;
Use ExTrigger;

create table departamento (		Dnum int, 
							nome varchar(10), 
							TotalSal float);
alter table departmento add primary key (Dnum);

create table empregado (
							id int,
                            nome varchar(10),
                            salario float, 
                            dnum int);
alter table empregado add primary key (id);
alter table empregado add foreign key(Dnum) references departamento(Dnum);

create table FolhaPagto (
							id int auto_increment, 
							salario float, 
							codemp int,
primary key(id));
alter table FolhaPagto add foreign key(codemp) references empregado(id);

#2) Insira na tabela Departamento:
INSERT INTO departamento (Dnum , nome , TotalSal )
VALUE(1,"computação",0),
(2,"matemática", 0);

#3) Crie uma trigger que atualize o TotalSal da tabela Depto, sempre que um novo empregado for inserido.

CREATE TRIGGER tgr_empregado_insert AFTER INSERT 
ON empregado
FOR EACH ROW
UPDATE departamento SET  TotalSal = TotalSal +  NEW.salario
WHERE Dnum = NEW.Dnum;

INSERT INTO empregado (id , nome ,salario, dnum )
VALUE (1,"Luiza",3000,1),
(2,"Bruno",2000,1),
(3,"Maria",5000,2);

SELECT * FROM departamento;
drop trigger tgr_empregado_insert;

// delimiter ;
#4) Crie uma trigger que atualize o TotaSal, sempre que um empregado trocar de depto.
CREATE TRIGGER tgr_empregado_atualiza AFTER UPDATE 
ON empregado
FOR EACH ROW

UPDATE departamento SET TotalSal = TotalSal +  NEW.salario
WHERE Dnum = NEW.Dnum;
UPDATE departamento SET TotalSal = TotalSal - OLD.salario
WHERE Dnum = OLD.Dnum;

UPDATE empregado SET dnum = 2 WHERE dnum = 1;
SELECT * FROM departamento ;

// delimiter ;

#5) Exclua a trigger criada no exercício 3 (não se pode ter 2 trigger com a mesma ação na mesma tabela).
DROP trigger tgr_empregado_insert;

#6)Crie uma trigger que insere uma tupla na tabela FolhaPagamento sempre que for inserido um novo empregado na tabela empregado.
CREATE TRIGGER  tgr_empregado_insert AFTER INSERT
ON empregado
FOR EACH ROW
INSERT INTO FolhaPagto 
VALUES (NEW.salario, NEW.id);
alter table NUTR_CTRL alter column ID char(3) not null

alter table NUTR_DIAG alter column CODE char(7) not null

alter table NUTR_FACT alter column CODE char(8) not null

alter table NUTR_FACT_GRPS alter column FGRC char(4) not null

alter table NUTR_FOOD_REQD alter column REQID char(5) not null
alter table NUTR_FOOD_REQD alter column REQCODE char(8) not null

alter table NUTR_FOOD_REQS alter column REQID char(5) not null

alter table NUTR_LOG alter column ID char(10) not null

alter table NUTR_MISC alter column COD char(4) not null

alter table NUTR_PADM alter column AN char(7) not null

alter table NUTR_REPORTS alter column RCOD char(4) not null
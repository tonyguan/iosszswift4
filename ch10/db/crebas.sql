/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2014/1/11 17:58:47                           */
/*==============================================================*/


drop DATABASE if exists schoolDB;

CREATE DATABASE schoolDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

use schoolDB;

drop table if exists Category1;

drop table if exists Category2;

drop table if exists Course;


/*==============================================================*/
/* Table: Category1                                             */
/*==============================================================*/
create table Category1
(
   _id                  int not null auto_increment,
   _name                varchar(20),
   primary key (_id)
);

/*==============================================================*/
/* Table: Category2                                             */
/*==============================================================*/
create table Category2
(
   _id                  int not null auto_increment,
   _name                varchar(20),
   _id1                 int,
   primary key (_id)
);

/*==============================================================*/
/* Table: Course                                                */
/*==============================================================*/
create table Course
(
   _id                  int not null auto_increment,
   _name                varchar(100),
   People_Number        int,
   Class_Hour           int,
   Charges              float,
   Teacher              varchar(100),
   Picture              varchar(100),
   URL                  varchar(500),
   Description          varchar(1000),
   _id2                 int,
   primary key (_id)
);

alter table Category2 add constraint FK_Reference_1 foreign key (_id1)
      references Category1 (_id) on delete restrict on update restrict;

alter table Course add constraint FK_Reference_2 foreign key (_id2)
      references Category2 (_id) on delete restrict on update restrict;


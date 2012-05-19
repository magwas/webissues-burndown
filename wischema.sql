                create table alerts (
                  alert_id int(11), 
                  user_id int(11),
                  folder_id int(11), 
                  view_id int(11),
                  alert_email tinyint(4)  ,
                  stamp_id int(11)  
                );
                create table attr_types (
                  attr_id int(11)   ,
                  type_id int(11)  ,
                  attr_name varchar(40)    ,
                  attr_def longtext    
                );
                create table attr_values (
                  issue_id int(11)  ,
                  attr_id int(11)  ,
                  attr_value varchar(255)    
                ) ;
                create table changes (
                  change_id int(11)  ,
                  issue_id int(11)  ,
                  change_type tinyint(4)  ,
                  stamp_id int(11)  ,
                  attr_id int(11)  ,
                  value_old varchar(255)    ,
                  value_new varchar(255)    ,
                  from_folder_id int(11)  ,
                  to_folder_id int(11)  
                ) ;
                create table change_stubs (
                  stub_id int(11)  ,
                  change_id int(11)  ,
                  issue_id int(11)  
                ) ;
                create table comments (
                  comment_id int(11)  ,
                  comment_text longtext    
                ) ;
                create table files (
                  file_id int(11)  ,
                  file_name varchar(80)    ,
                  file_size int(11)  ,
                  file_data longblob,
                  file_descr varchar(255)    ,
                  file_storage tinyint(4)  
                ) ;
                create table folders (
                  folder_id int(11)   ,
                  project_id int(11)  ,
                  type_id int(11)  ,
                  folder_name varchar(40)    ,
                  stamp_id int(11)  
                ) ;
                create table issues (
                  issue_id int(11)  ,
                  folder_id int(11)  ,
                  issue_name varchar(255)    ,
                  stamp_id int(11)  ,
                  stub_id int(11)  
                ) ;
                create table issue_states (
                  state_id int(11)   ,
                  user_id int(11)  ,
                  issue_id int(11)  ,
                  read_id int(11)  
                ) ;
                create table issue_stubs (
                  stub_id int(11)  ,
                  prev_id int(11)  ,
                  issue_id int(11)  ,
                  folder_id int(11)  
                ) ;
                create table issue_types (
                  type_id int(11)   ,
                  type_name varchar(40)    
                ) ;
                create table log_events (
                  event_id int(11)   ,
                  event_type varchar(16)       ,
                  event_severity tinyint(4)  ,
                  event_message longtext    ,
                  event_time int(11)  ,
                  user_id int(11)  ,
                  host_name varchar(40)       
                ) ;
                create table preferences (
                  user_id int(11)  ,
                  pref_key varchar(40)    ,
                  pref_value longtext    
                ) ;
                create table projects (
                  project_id int(11)   ,
                  project_name varchar(40)    
                ) ;
                create table rights (
                  project_id int(11)  ,
                  user_id int(11)  ,
                  project_access tinyint(4)  
                ) ;
                create table server (
                  server_name varchar(40)    ,
                  server_uuid char(36)       ,
                  db_version varchar(20)       
                ) ;
                create table sessions (
                  session_id char(32)       ,
                  user_id int(11)  ,
                  session_data longtext    ,
                  last_access int(11)  
                ) ;
                create table settings (
                  set_key varchar(40)    ,
                  set_value longtext    
                ) ;
                create table stamps (
                  stamp_id int(11)   ,
                  user_id int(11)  ,
                  stamp_time int(11)  
                ) ;
                create table users (
                  user_id int(11)   ,
                  user_login varchar(40)    ,
                  user_name varchar(40)    ,
                  user_passwd varchar(255)       ,
                  user_access tinyint(4)  ,
                  passwd_temp tinyint(4)  
                ) ;
                create table views (
                  view_id int(11)   ,
                  type_id int(11)  ,
                  user_id int(11)  ,
                  view_name varchar(40)    ,
                  view_def longtext    
                ) ;
                create table view_settings (
                  type_id int(11)  ,
                  set_key varchar(40)    ,
                  set_value longtext    
                ) ;

--- create table sizes (shirt varchar(2),num int);
--- create table dates (d varchar(10));
--- insert into dates values ('2012-05-01');
--- insert into dates values ('2012-05-02');
--- insert into dates values ('2012-05-03');
--- insert into dates values ('2012-05-04');
--- insert into dates values ('2012-05-05');
--- insert into dates values ('2012-05-06');
--- insert into dates values ('2012-05-07');
--- insert into dates values ('2012-05-08');
--- insert into dates values ('2012-05-09');
--- insert into dates values ('2012-05-10');
--- insert into dates values ('2012-05-11');
--- insert into dates values ('2012-05-12');
--- insert into dates values ('2012-05-13');
--- insert into dates values ('2012-05-14');
--- insert into dates values ('2012-05-15');
--- insert into dates values ('2012-05-16');
------  insert into dates values ('2012-05-17');
--- insert into dates values ('2012-05-18');
--- insert into dates values ('2012-05-19');
--- insert into dates values ('2012-05-20');
--- insert into dates values ('2012-05-21');
--- insert into dates values ('2012-05-22');
--- insert into dates values ('2012-05-23');
--- insert into dates values ('2012-05-24');
--- 
--- create unique index i_sizes_pk on sizes(shirt);
--- insert into sizes values ('XS', 1);
--- insert into sizes values ('S', 2);
--- insert into sizes values ('M', 4);
--- insert into sizes values ('L', 8);
--- insert into sizes values ('XL', 16);
--- create index i_attr_values_issue on attr_values(issue_id);
--- create unique index i_issue_pk on issues(issue_id);
--- create unique index i_stamps_pk on stamps(stamp_id);
--- create index i_changes_stamp on changes(stamp_id);
--- create index i_issues_stamp on issues(stamp_id);
--- create index i_attr_values_attr on attr_values(attr_id);
--- create index i_changes_attr on changes(attr_id);
--- create index i_stamps_time on stamps(stamp_time);
--- delete from changes where attr_id not in (15,13,7);
--- delete from changes where stamp_id in (select stamp_id from stamps where stamp_time < strftime('%s','2012-05-01'));
--- delete from issues where stamp_id in (select stamp_id from stamps where stamp_time < strftime('%s','2012-05-01'));
--- insert into attr_values select issue_id,13,'M' from issues where issue_id not in (select issue_id from attr_values where attr_id=13);



--- drop view allchange;
--- create view allchange as select a.attr_id,a.issue_id,s.stamp_time, a.attr_value as value
---  from issues i, attr_values a, stamps s
---  where  i.issue_id and a.issue_id = i.issue_id and s.stamp_id=i.stamp_id and a.attr_id in (15,13,7)
--- union select c.attr_id,c.issue_id,s.stamp_time, c.value_new as value
---  from changes c, stamps s
---  where s.stamp_id=c.stamp_id and c.attr_id in (15,13,7);
--- 
--- --- drop view dailybug;
--- create view dailybug as select b.*,a.d from 
--- 	(select ac.attr_id,ac.issue_id,max(ac.stamp_time) as stamp_time,d.d
--- 		from allchange ac, dates d
--- 		where stamp_time < strftime('%s',d.d)
--- 		group by issue_id,attr_id,d.d) as a,
--- 	allchange b
--- 	where a.attr_id=b.attr_id and a.issue_id=b.issue_id and a.stamp_time=b.stamp_time;
--- 
--- select sprint.value, shirt.value,shirt.issue_id from dailybug sprint, dailybug shirt where shirt.issue_id=sprint.issue_id and shirt.attr_id=13 and sprint.attr_id=15 order by sprint.issue_id;
create table states (issue_id int, milestone varchar(64), status varchar(10),size int, date varchar(10));

.separator ','
.import changes.csv changes
.import stamps.csv stamps


--- select * from allchange limit 10;
--- story point: 13. mérföldkő: 15, státusz: 7


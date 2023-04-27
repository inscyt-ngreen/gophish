
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE IF NOT EXISTS roles (id SERIAL PRIMARY KEY,slug VARCHAR(255) NOT NULL UNIQUE,name VARCHAR(255) NOT NULL UNIQUE,description VARCHAR(255) );
CREATE TABLE IF NOT EXISTS users (id serial,username varchar(255) NOT NULL UNIQUE,hash varchar(255),api_key varchar(255) NOT NULL UNIQUE,role_id integer,password_change_required boolean,last_login timestamp,account_locked boolean );
CREATE TABLE IF NOT EXISTS templates (id serial primary key,user_id bigint,name varchar(255),subject varchar(255),text text,html text,modified_date timestamp,envelope_sender varchar(255) );
CREATE TABLE IF NOT EXISTS targets (id serial primary key,first_name varchar(255),last_name varchar(255),email varchar(255),position varchar(255) );
CREATE TABLE IF NOT EXISTS smtp(id bigserial primary key,user_id bigint,interface_type varchar(255),name varchar(255),host varchar(255),username varchar(255),password varchar(255),from_address varchar(255),modified_date timestamp,ignore_cert_errors boolean );
CREATE TABLE IF NOT EXISTS results (id serial primary key,campaign_id bigint,user_id bigint,r_id varchar(255),email varchar(255),first_name varchar(255),last_name varchar(255),status varchar(255) NOT NULL ,ip varchar(255),latitude real,longitude real,position varchar(255),send_date timestamp,reported boolean default false,modified_date timestamp );
CREATE TABLE IF NOT EXISTS pages (id serial primary key,user_id bigint,name varchar(255),html text,modified_date timestamp,capture_credentials boolean,capture_passwords boolean,redirect_url TEXT );
CREATE TABLE IF NOT EXISTS groups (id serial primary key,user_id bigint,name varchar(255),modified_date timestamp );
CREATE TABLE IF NOT EXISTS group_targets (group_id bigserial,target_id bigint );
CREATE TABLE IF NOT EXISTS events (id serial primary key,campaign_id bigint,email varchar(255),time timestamp,message varchar(255),details bytea );
CREATE TABLE IF NOT EXISTS campaigns (id serial primary key,user_id bigint,name varchar(255) NOT NULL,created_date timestamp,completed_date timestamp,template_id bigint,page_id bigint,status varchar(255),url varchar(255),smtp_id bigint,launch_date timestamp,send_by_date timestamp );
CREATE TABLE IF NOT EXISTS attachments (id serial primary key,template_id bigint,content text,type varchar(255),name varchar(255) );
CREATE TABLE IF NOT EXISTS headers (id serial primary key,key varchar(255),value varchar(255),smtp_id bigint );
CREATE TABLE IF NOT EXISTS mail_logs (id serial primary key,campaign_id integer,user_id integer,send_date timestamp,send_attempt integer,r_id varchar(255),processing boolean );
CREATE TABLE IF NOT EXISTS email_requests (id serial primary key,user_id integer,template_id integer,page_id integer,first_name varchar(255),last_name varchar(255),email varchar(255),position varchar(255),url varchar(255),r_id varchar(255),from_address varchar(255) );
CREATE TABLE IF NOT EXISTS permissions (id SERIAL PRIMARY KEY,slug VARCHAR(255) NOT NULL UNIQUE,name VARCHAR(255) NOT NULL UNIQUE,description VARCHAR(255) );
CREATE TABLE IF NOT EXISTS role_permissions (role_id INTEGER NOT NULL,permission_id INTEGER NOT NULL );
CREATE TABLE IF NOT EXISTS webhooks (id serial primary key,name varchar(255),url varchar(1000),secret varchar(255),is_active boolean default false );
CREATE TABLE IF NOT EXISTS imap (user_id bigint,host varchar(255),port int,username varchar(255),password varchar(255),modified_date timestamp,tls boolean,enabled boolean,folder varchar(255),restrict_domain varchar(255),delete_reported_campaign_email boolean,last_login timestamp,imap_freq int,ignore_cert_errors boolean );

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE webhooks;
DROP TABLE role_permissions;
DROP TABLE permissions;
DROP TABLE email_requests;
DROP TABLE mail_logs;
DROP TABLE headers;
DROP TABLE attachments;
DROP TABLE campaigns;
DROP TABLE events;
DROP TABLE group_targets;
DROP TABLE groups;
DROP TABLE pages;
DROP TABLE results;
DROP TABLE smtp;
DROP TABLE targets;
DROP TABLE templates;
DROP TABLE users;
DROP TABLE roles;

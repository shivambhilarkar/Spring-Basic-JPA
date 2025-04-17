--SEQUENCES


CREATE SEQUENCE "org_seq"
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1;

CREATE SEQUENCE "user_seq"
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1;

CREATE SEQUENCE "group_seq"
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1;

CREATE SEQUENCE "resource_seq"
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1;



CREATE TABLE org (
  orgid INT NOT NULL DEFAULT nextval('"org_seq"'::regclass),
  displayname varchar(50) NOT NULL,
  orgshortname varchar (25) NOT NULL,
  orgrootname varchar (64) NOT NULL,
  versioned boolean NOT NULL,
  sharedoutsideorg boolean NOT NULL,
  encrypted boolean NOT NULL,
  isautoonboardenabled boolean NOT NULL DEFAULT true,
  endpointexpirationtime INT NOT NULL,
  lastupdateuser varchar(100) NOT NULL,
  lastupdatetime  TIMESTAMP NOT NULL,
  CONSTRAINT "org_pk" PRIMARY KEY (orgid),
  CONSTRAINT "org_unq" UNIQUE (orgshortname)
);

DROP INDEX IF EXISTS public.idx_org;
CREATE INDEX idx_org ON public.org USING btree (orgshortname, displayname);


CREATE TABLE public.user (
  userid INT NOT NULL DEFAULT nextval('"user_seq"'::regclass),
  firstname VARCHAR (20) ,
  accountid INT,
  lastname VARCHAR (20),
  username VARCHAR (100) NOT NULL,
  email VARCHAR (100) NOT NULL,
  mobile VARCHAR (15) NULL,
  active boolean NOT NULL DEFAULT true,
  canpay boolean NOT NULL DEFAULT true,
  orgid INT NOT NULL,
  lastupdateuser VARCHAR(50) NOT NULL,
  lastupdatetime TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "user_pk" PRIMARY KEY (userid),
  CONSTRAINT "username_unq1" UNIQUE ("username","orgid"),
  CONSTRAINT "email_unq2" UNIQUE ("email"),
  CONSTRAINT "user_fk1" FOREIGN KEY (orgid) REFERENCES "org"(orgid)
);

DROP INDEX IF EXISTS  public.idx_user;
CREATE INDEX idx_user ON public.user USING btree (email, username, firstname,lastname,active,accountid,orgid);

CREATE TABLE  public.group (
  groupid INT NOT NULL DEFAULT nextval('"group_seq"'::regclass),
  name varchar (50) NOT NULL,
  description varchar (255) NULL,
  orgid INT NOT NULL,
  email VARCHAR NOT NULL,
  lastupdateuser VARCHAR(100) NOT NULL,
  lastupdatetime TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "group_pk" PRIMARY KEY (groupid),
  CONSTRAINT "group_fk1" FOREIGN KEY (orgid) REFERENCES "org"(orgid),
  CONSTRAINT "group_fk2" FOREIGN KEY (email) REFERENCES "user"(email),
  CONSTRAINT "group_unq" UNIQUE ("name","orgid","email")
);


DROP INDEX IF EXISTS  public.idx_group;
CREATE INDEX idx_group ON public.group USING btree (name,orgid,email);

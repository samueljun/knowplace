CREATE SCHEMA public;

CREATE TABLE test_lamps ( 
	node_address         int4 NOT NULL,
	time                 timestamp NOT NULL,
	data_value           int4,
	CONSTRAINT test_lamps_pkey PRIMARY KEY ( node_address, time ),
	CONSTRAINT test_lamps_pkey UNIQUE ( node_address )
 );

CREATE TABLE public.users ( 
	user_id              varchar( 20 ) NOT NULL,
	email                varchar( 50 ),
	first_name           varchar( 50 ),
	last_name            varchar( 50 ),
	security_pin         int4,
	CONSTRAINT pk_users PRIMARY KEY ( user_id )
 );

CREATE TABLE public.hubs ( 
	hub_id               int4 NOT NULL,
	api_key              varchar( 50 ),
	name                 varchar( 50 ),
	pan_id               int4,
	users_user_id        varchar( 20 ) NOT NULL,
	CONSTRAINT pk_hubs PRIMARY KEY ( hub_id )
 );

CREATE INDEX idx_hubs ON public.hubs ( users_user_id );

CREATE TABLE public.nodes ( 
	node_id              int4 NOT NULL,
	address              varchar( 100 ),
	hubs_hub_id          int4 NOT NULL,
	name                 varchar( 50 ),
	type                 varchar( 10 ),
	CONSTRAINT pk_nodes PRIMARY KEY ( node_id )
 );

CREATE INDEX idx_nodes ON public.nodes ( hubs_hub_id );

CREATE TABLE public.pins ( 
	pin_id               int4 NOT NULL,
	data_type            varchar( 50 ),
	nodes_node_id        int4 NOT NULL,
	CONSTRAINT pk_pins PRIMARY KEY ( pin_id )
 );

CREATE INDEX idx_pins ON public.pins ( nodes_node_id );

CREATE TABLE public.tags ( 
	tag                  varchar( 50 ) NOT NULL,
	pins_pin_id          int4 NOT NULL,
	CONSTRAINT pk_tags PRIMARY KEY ( tag, pins_pin_id )
 );

CREATE INDEX idx_tags ON public.tags ( pins_pin_id );

CREATE TABLE public.permissions ( 
	users_user_id        varchar( 20 ) NOT NULL,
	pins_pin_id          int4,
	read                 bool,
	write                bool,
	CONSTRAINT pk_permissions PRIMARY KEY ( users_user_id )
 );

CREATE INDEX idx_permissions ON public.permissions ( pins_pin_id );

CREATE TABLE public.pin_data ( 
	time                 timestamp NOT NULL,
	pin_type             varchar( 50 ),
	pin_value            varchar( 50 ),
	pins_pin_id          int4 NOT NULL,
	CONSTRAINT pk_pin_data PRIMARY KEY ( time )
 );

ALTER TABLE public.hubs ADD CONSTRAINT fk_hubs_users FOREIGN KEY ( users_user_id ) REFERENCES public.users( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.nodes ADD CONSTRAINT fk_nodes_hubs FOREIGN KEY ( hubs_hub_id ) REFERENCES public.hubs( hub_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.permissions ADD CONSTRAINT fk_permissions_pins FOREIGN KEY ( pins_pin_id ) REFERENCES public.pins( pin_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.permissions ADD CONSTRAINT fk_permissions_users FOREIGN KEY ( users_user_id ) REFERENCES public.users( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.pin_data ADD CONSTRAINT fk_pin_data_pins FOREIGN KEY ( pins_pin_id ) REFERENCES public.pins( pin_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.pins ADD CONSTRAINT fk_pins_nodes FOREIGN KEY ( nodes_node_id ) REFERENCES public.nodes( node_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.tags ADD CONSTRAINT fk_tags_pins FOREIGN KEY ( pins_pin_id ) REFERENCES public.pins( pin_id ) ON DELETE CASCADE ON UPDATE CASCADE;


DROP TABLE IF EXISTS public.pin_data CASCADE;
DROP TABLE IF EXISTS public.permissions CASCADE;
DROP TABLE IF EXISTS public.tags CASCADE;
DROP TABLE IF EXISTS public.pins CASCADE;
DROP TABLE IF EXISTS public.nodes CASCADE;
DROP TABLE IF EXISTS public.hubs CASCADE;
DROP TABLE IF EXISTS public.users CASCADE;
DROP TABLE IF EXISTS public.max_node_id CASCADE;
DROP TABLE IF EXISTS test_lamps CASCADE;
DROP SCHEMA public;
CREATE SCHEMA public;

CREATE TABLE public.max_node_id (
	id					int4 DEFAULT 0 NOT NULL,
	CONSTRAINT pk_max_node_id PRIMARY KEY (id)
);
COMMENT ON TABLE public.max_node_id IS 'Keep track of node id';

CREATE TABLE public.test_lamps (
	node_address		int4 NOT NULL,
	time				timestamp NOT NULL,
	data_value			int4,
	CONSTRAINT pk_test_lamps PRIMARY KEY (node_address, time)
);

CREATE TABLE public.users (
	user_id				varchar(20) NOT NULL,
	email				varchar(50),
	first_name			varchar(50),
	last_name			varchar(50),
	security_pin		int4,
	CONSTRAINT pk_users PRIMARY KEY (user_id)
);

CREATE TABLE public.hubs (
	hub_id				int4 NOT NULL,
	name				varchar(50),
	api_key				varchar(50),
	pan_id				int4,
	users_user_id		varchar(20) NOT NULL,
	CONSTRAINT pk_hubs PRIMARY KEY (hub_id)
);
CREATE INDEX idx_hubs ON public.hubs (users_user_id);

CREATE TABLE public.nodes (
	node_id				int4 NOT NULL,
	name				varchar(50) NOT NULL,
	address_low			varchar(8) NOT NULL,
	address_high		varchar(8) NOT NULL,
	current_value		varchar(50),
	hubs_hub_id			int4 NOT NULL,
	CONSTRAINT pk_nodes PRIMARY KEY (node_id)
);
CREATE INDEX idx_nodes ON public.nodes (hubs_hub_id);

CREATE TABLE public.pins (
	pin_id				int4 NOT NULL,
	name				varchar(50),
	type				varchar(50),
	nodes_node_id		int4 NOT NULL,
	CONSTRAINT pk_pins PRIMARY KEY (pin_id)
);
CREATE INDEX idx_pins ON public.pins (nodes_node_id);

CREATE TABLE public.pin_data (
	time				timestamp NOT NULL,
	pin_value			varchar(50),
	pins_pin_id			int4 NOT NULL,
	CONSTRAINT pk_pin_data PRIMARY KEY (time)
);

CREATE TABLE public.permissions (
	users_user_id		varchar(20) NOT NULL,
	pins_pin_id			int4,
	read				bool,
	write				bool,
	CONSTRAINT pk_permissions PRIMARY KEY (users_user_id)
);
CREATE INDEX idx_permissions ON public.permissions (pins_pin_id);

CREATE TABLE public.tags (
	tag					varchar(50) NOT NULL,
	pins_pin_id			int4 NOT NULL,
	CONSTRAINT pk_tags PRIMARY KEY (tag, pins_pin_id)
);
CREATE INDEX idx_tags ON public.tags (pins_pin_id);



ALTER TABLE public.hubs ADD CONSTRAINT fk_hubs_users FOREIGN KEY (users_user_id) REFERENCES public.users( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.nodes ADD CONSTRAINT fk_nodes_hubs FOREIGN KEY (hubs_hub_id ) REFERENCES public.hubs( hub_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.permissions ADD CONSTRAINT fk_permissions_pins FOREIGN KEY (pins_pin_id ) REFERENCES public.pins( pin_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.permissions ADD CONSTRAINT fk_permissions_users FOREIGN KEY (users_user_id ) REFERENCES public.users( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.pin_data ADD CONSTRAINT fk_pin_data_pins FOREIGN KEY (pins_pin_id ) REFERENCES public.pins( pin_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.pins ADD CONSTRAINT fk_pins_nodes FOREIGN KEY (nodes_node_id ) REFERENCES public.nodes( node_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE public.tags ADD CONSTRAINT fk_tags_pins FOREIGN KEY (pins_pin_id ) REFERENCES public.pins( pin_id ) ON DELETE CASCADE ON UPDATE CASCADE;

-- Test Data for MyDataServlet
INSERT INTO users VALUES ('0', 'eggert@cs.ucla.edu', 'Paul', 'Eggert', 1234);
INSERT INTO hubs VALUES (0, 'UCLA Hub', 'api_key_0', 1234, '0');
INSERT INTO max_node_id VALUES (0);
INSERT INTO nodes VALUES (0, 'Air Conditioner', '0013a200', '40315568', '0', 0);
-- INSERT INTO nodes VALUES (1, 'Desk Lamp', '0013a200', '40315565', '1', 0);
-- INSERT INTO max_node_id VALUES (1);
INSERT INTO pins VALUES (0, 'Air Conditioner Pin', 'control_V', 0);
-- INSERT INTO pins VALUES (1, 'Desk Lamp Pin', 'control_B', 1);
-- INSERT INTO tags VALUES ('lamp', 0);
-- INSERT INTO tags VALUES ('light', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:23:53', '0', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:52:07', '1', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 12:32:38', '0', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-30 12:32:38', '1', 1);

-- Test Data for TestLampServlet
INSERT INTO test_lamps VALUES (1, now(), 0);
INSERT INTO test_lamps VALUES (2, now(), 1);
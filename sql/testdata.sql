-- Test Data for MyDataServlet
INSERT INTO users VALUES ('0', 'eggert@cs.ucla.edu', 'Paul', 'Eggert', 1234);
INSERT INTO hubs VALUES (0, 'api_key_0', 'UCLA_Hub', 1234, '0');
INSERT INTO nodes VALUES (0, 0, 99, 0, 'Room Lamp', 'light');
INSERT INTO nodes VALUES (1, 100, 199, 0, 'Desk Lamp', 'light');
INSERT INTO max_node_id VALUES (1); 
INSERT INTO pins VALUES (0, 'control_B', 'Room Lamp Pin', 0);
INSERT INTO pins VALUES (1, 'control_B', 'Desk Lamp Pin', 1);
INSERT INTO tags VALUES ('lamp', 0);
INSERT INTO tags VALUES ('light', 0);
INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:23:53', 'control_B', '1', 0);
INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:52:07', 'control_B', '0', 0);
INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 12:32:38', 'control_B', '1', 0);
INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-30 12:32:38', 'control_B', '1', 1);

-- Test Data for TestLampServlet
INSERT INTO test_lamps VALUES (1, now(), 0);
INSERT INTO test_lamps VALUES (2, now(), 1);
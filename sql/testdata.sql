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
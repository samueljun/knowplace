-- Test Data for MyDataServlet
INSERT INTO users VALUES ('0', 'eggert@cs.ucla.edu', 'Paul', 'Eggert', 1234);
INSERT INTO hubs VALUES (0, 'api_key_0', 'UCLA_Hub', 1234, '0');
INSERT INTO nodes VALUES (0, 'nodes_address', 0, 'node_name', 'light');
INSERT INTO pins VALUES (0, 'binary', 'pin_name', 0);
INSERT INTO tags VALUES ('lamp', 0);
INSERT INTO tags VALUES ('light', 0);
INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:23:53', 'binary', 'on', 0);
INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:52:07', 'binary', 'off', 0);
INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 12:32:38', 'binary', 'on', 0);

-- Test Data for TestLampServlet
INSERT INTO test_lamps VALUES (1, now(), 0);
INSERT INTO test_lamps VALUES (2, now(), 1);
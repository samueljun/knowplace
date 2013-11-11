-- Test Data for MyDataServlet
INSERT INTO users VALUES ('0', 'eggert@cs.ucla.edu', 'Paul', 'Eggert', 1234);

-- INSERT INTO max_hub_id VALUES (0);
-- INSERT INTO max_node_id VALUES (0);
-- INSERT INTO max_pin_id VALUES (0);

INSERT INTO hubs VALUES (0, 'UCLA Hub', 'api_key_0', 1234, '0');
INSERT INTO hubs VALUES (1, 'Extra Hub', 'api_key_1', 5678, '0');
INSERT INTO max_hub_id VALUES (1);
---INSERT INTO nodes VALUES (0, 'Air Conditioner', '0013a200', '40315568', '0', 0);
-- INSERT INTO pins VALUES (0, 'Air Conditioner Pin', 'control_V', 0);
INSERT INTO nodes VALUES (0, 'Desk Lamp', '0013a200', '40315565', '1', 0);
INSERT INTO pins  VALUES (0, 'Desk Lamp Pin', 'control_B', 0);
-- INSERT INTO max_node_id VALUES (1);

INSERT INTO nodes VALUES (1, 'iPhone BT_Isaac', '1', '1', '31415926', 0);
INSERT INTO pins  VALUES (1, 'iPhone BT_Isaac Pin', 'sensor_M', 1);

INSERT INTO nodes VALUES (2, 'iPhone R_Isaac', '2', '2', 'SuperSectretMessageForIsaac', 0);
INSERT INTO pins  VALUES (2, 'iPhone R_Isaac Pin', 'control_R', 2);

INSERT INTO nodes VALUES (3, 'iPhone BT_Sang', '3', '3', '53589793', 0);
INSERT INTO pins  VALUES (3, 'iPhone BT_Sang Pin', 'sensor_M', 3);

INSERT INTO nodes VALUES (4, 'iPhone R_Sang', '4', '4', 'SuperSectretMessageForSang', 0);
INSERT INTO pins  VALUES (4, 'iPhone R_Sang Pin', 'control_R', 4);

INSERT INTO nodes VALUES (5, 'Extra hub node', '5', '5', 'wat', 1);
INSERT INTO pins VALUES (5, 'Extra hub node pin5', 'control_R', 5);
INSERT INTO pins Values (6, 'Extra hub node pin6', 'control_R', 5);
INSERT INTO max_node_id VALUES (5);
INSERT INTO max_pin_id VALUES (6);
-- INSERT INTO tags VALUES ('lamp', 0);
-- INSERT INTO tags VALUES ('light', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:23:53', '0', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:52:07', '1', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 12:32:38', '0', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-30 12:32:38', '1', 1);

-- Test Data for TestLampServlet
--INSERT INTO test_lamps VALUES (1, now(), 0);
--INSERT INTO test_lamps VALUES (2, now(), 1);
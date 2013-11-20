-- Test Data for MyDataServlet
INSERT INTO users VALUES ('0', 'eggert@cs.ucla.edu', 'Paul', 'Eggert', 1234);

-- INSERT INTO max_hub_id VALUES (0);
-- INSERT INTO max_node_id VALUES (0);
-- INSERT INTO max_pin_id VALUES (0);

INSERT INTO hubs VALUES (0, 'iPhone Sang', 'api_key_sang', 1234, '0');
INSERT INTO hubs VALUES (1, 'iPhone Isaac', 'api_key_isaac', 5678, '0');
INSERT INTO hubs VALUES (2, 'XBee Hub', 'api_key_xbee', 1991, '0');
INSERT INTO max_hub_id VALUES (2);
---INSERT INTO nodes VALUES (0, 'Air Conditioner', '0013a200', '40315568', '0', 0);
-- INSERT INTO pins VALUES (0, 'Air Conditioner Pin', 'control_V', 0);
INSERT INTO nodes VALUES (0, 'Desk Lamp', '0013a200', '40315565', '1', 2);
INSERT INTO pins  VALUES (0, 'Desk Lamp Pin', 'control_B', '1', 0);
-- INSERT INTO max_node_id VALUES (1);

INSERT INTO nodes VALUES (1, 'iPhone BT_Isaac', '1', '1', '31415926', 1);
INSERT INTO pins  VALUES (1, 'iPhone BT_Isaac Pin', 'sensor_M', '31415926', 1);
INSERT INTO pins  VALUES (5, 'iBeacon_Isaac Pin', 'static_ID', '15440', 1);

INSERT INTO nodes VALUES (2, 'iPhone R_Isaac', '2', '2', 'SuperSectretMessageForIsaac', 1);
INSERT INTO pins  VALUES (2, 'iPhone R_Isaac Pin', 'control_R', 'SuperSectretMessageForIsaac', 2);

INSERT INTO nodes VALUES (3, 'iPhone BT_Sang', '3', '3', '53589793', 0);
INSERT INTO pins  VALUES (3, 'iPhone BT_Sang Pin', 'sensor_M', '53589793', 3);
INSERT INTO pins  VALUES (6, 'iBeacon_Sang Pin', 'static_ID', '5496', 3);

INSERT INTO nodes VALUES (4, 'iPhone R_Sang', '4', '4', 'SuperSectretMessageForSang', 0);
INSERT INTO pins  VALUES (4, 'iPhone R_Sang Pin', 'control_R', 'SuperSectretMessageForSang', 4);

INSERT INTO max_node_id VALUES (4);
INSERT INTO max_pin_id VALUES (6);

INSERT INTO recipes VALUES (0, 3, 'SINGLE', 'Sang->Isaac_BT0', -1);
INSERT INTO ingredients VALUES (2, '=', '0', 'receivedZero', FALSE, 0);

INSERT INTO recipes VALUES (1, 3, 'SINGLE', 'Sang->Isaac_BT1', -1);
INSERT INTO ingredients VALUES(2, '=', '1', 'receivedOne', FALSE, 1);

INSERT INTO recipes VALUES (2, 1, 'SINLGE', 'Isaac->Sang_BT2', -1);
INSERT INTO ingredients VALUES (4, '=', '0', 'receivedZero', FALSE, 2);

INSERT INTO recipes VALUES (3, 1, 'SINGLE', 'Isaac->Sang_BT3', -1);
INSERT INTO ingredients VALUES(4, '=', '1', 'receivedOne', FALSE, 3);

-- lamp automation
INSERT INTO recipes VALUES (4, 3, 'SINGLE', 'Isaac->Sang_BT0', -1);
INSERT INTO ingredients VALUES (0, '=', '0', '0', FALSE, 4);

INSERT INTO recipes VALUES (5, 3, 'SINGLE', 'Isaac->Sang_BT0', -1);
INSERT INTO ingredients VALUES(0, '=', '1', '1', FALSE, 5);

INSERT INTO recipes VALUES (6, 3, 'SINGLE', 'Isaac->Sang_BT0', -1);
INSERT INTO ingredients VALUES (0, '=', '0', '0', FALSE, 6);

INSERT INTO recipes VALUES (7, 3, 'SINGLE', 'Isaac->Sang_BT1', -1);
INSERT INTO ingredients VALUES(0, '=', '15440', '1', FALSE, 7);


INSERT INTO max_recipe_id VALUES(7);
-- INSERT INTO tags VALUES ('lamp', 0);
-- INSERT INTO tags VALUES ('light', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:23:53', '0', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:52:07', '1', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 12:32:38', '0', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-30 12:32:38', '1', 1);

-- Test Data for TestLampServlet
--INSERT INTO test_lamps VALUES (1, now(), 0);
--INSERT INTO test_lamps VALUES (2, now(), 1);
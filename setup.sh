#!/bin/bash
rm -r tomcat.8080 
mvn package && sh target/bin/webapp

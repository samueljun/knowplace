#!/bin/bash

if [ -d "tomcat.8080" ]; then
	rm -r tomcat.8080
fi

mvn package && sh target/bin/webapp

#!/bin/bash

docker pull mongo

docker run -p 27017:27017 --name mongo -d mongo


// docker exec -it mongo bash

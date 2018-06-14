#!/bin/bash

TAG=$(echo "$1"|sed 's/ /+/g')

w3m "google.com/search?q=$TAG" &

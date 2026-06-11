#!/bin/bash

find . -name "main.tf" -execdir bash -c 'cd "$(dirname "{}")" && terraform init -upgrade' \;
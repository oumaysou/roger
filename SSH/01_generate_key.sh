#!/bin/bash
#Lancer sur Shell
ssh-keygen -t rsa -C "oumaysou@student.42.fr"
chmod 400 "~/.ssh/id_rsa.pub"
ssh-copy-id oumaysou@10.12.33.1 -p 5432

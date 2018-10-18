#!/bin/sh

count=$(curl gopher://localhost | grep 'DOCTYPE HTML PUBLIC' | wc -l)

if [[ count -gt 0 ]]; then
  exit 1
else
  exit 0
fi

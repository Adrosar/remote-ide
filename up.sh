#!/bin/bash
docker build --tag adrosar/remote-ide . && docker compose up -d

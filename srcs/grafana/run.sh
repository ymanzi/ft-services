#!/bin/bash

telegraf &
grafana-server --homepath=/grafana

#!/bin/bash
git checkout 0.7
head=$(git rev-parse --short HEAD)
epoch=$(date +%s)
go build .
rm -rf build
mkdir -p build/usr/bin
mkdir -p build/usr/share/replication-manager/dashboard
mkdir -p build/etc/replication-manager
cp replication-manager build/usr/bin/
cp etc/config.toml.sample build/etc/replication-manager/config.toml.sample
cp dashboard/* build/usr/share/replication-manager/dashboard/
fpm --epoch $epoch --iteration $head -v 0.7.0 -C build -s dir -t rpm -n replication-manager .
fpm --package replication-manager-0.7.0-$head.tar -C build -s dir -t tar -n replication-manager .
gzip replication-manager-0.7.0-$head.tar
fpm --epoch $epoch --iteration $head -v 0.7.0 -C build -s dir -t deb -n replication-manager .
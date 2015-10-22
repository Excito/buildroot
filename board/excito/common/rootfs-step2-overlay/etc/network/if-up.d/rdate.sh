#!/bin/sh

if [ "$IFACE" != "lo" ] ; then
	/usr/sbin/rdate time.nist.gov
fi

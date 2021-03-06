#
# Copyright (C) 2008 OpenedHand Ltd.
#

DESCRIPTION = "NFS package groups"
LICENSE = "MIT"
PR = "r1"

inherit packagegroup

PACKAGES = "${PN}-server"

# For backwards compatibility after rename
RPROVIDES_${PN}-server = "task-core-nfs-server"

SUMMARY_${PN}-server = "NFS server"
RDEPENDS_${PN}-server = "\
    nfs-utils \
    nfs-utils-client \
    "

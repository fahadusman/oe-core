#
# ex:ts=4:sw=4:sts=4:et
# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
#
# Add external binary pkg to the repo and install them:
#
# Specify where are the external binary pkg dir
#EXTERNAL_PACKAGE_DIR = "<path1> <path2> ..."
# Specify which pkg will be installed
#EXTERNAL_INSTALL_PACKAGE = "<pkg1> <pkg2> ..."

#
# Add the external binary rpm into the repo, copy the binary rpm files
# from EXTERNAL_PACKAGE_DIR to ${DEPLOY_DIR_RPM}/external, and put them
# to the relevant arch dir.
#
add_external_rpm () {
    local supported_archs
    supported_archs="$@"

    # Clean the EXTERNAL_DIR_RPM dir and re-copy
    [ ! -d "${EXTERNAL_DIR_RPM}" ] || rm -fr ${EXTERNAL_DIR_RPM}

    if [ -n "${EXTERNAL_PACKAGE_DIR}" -a -n "${EXTERNAL_INSTALL_PACKAGE}" ]; then
        echo "Adding external binary rpms to the repo ..."
        for f in `find ${EXTERNAL_PACKAGE_DIR} -type f  -name '*.rpm'`; do
            arch="`echo $f | awk -F\. '{print $(NF-1)}'`"
            found=""
            for archvar in $supported_archs; do
                # Only pick up the supported arch's rpm
                if [ "$arch" == "$archvar" ]; then
                    [ -d "${EXTERNAL_DIR_RPM}/$arch" ] || mkdir -p ${EXTERNAL_DIR_RPM}/$arch
                    cp -f $f ${EXTERNAL_DIR_RPM}/$arch/
                    found="1"
                    break
                fi
            done
            [ -n "$found" ] || echo "Uknown arch $arch"
        done
    fi
}


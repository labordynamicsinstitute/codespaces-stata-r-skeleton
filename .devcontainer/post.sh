 #!/bin/sh
 if [ ! -f stata.lic ]
 then
    if [ -z ${STATA_LIC_BASE64} ]
    then
        echo "No license found."
        exit 2
    else
        echo "${STATA_LIC_BASE64}" | base64 -d > /home/statauser/stata.lic 
    fi
fi
#docker buildx install
echo "init done."
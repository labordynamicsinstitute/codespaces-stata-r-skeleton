 #!/bin/sh
 if [ ! -f stata.lic ]
 then
    if [ -z "${STATA_LIC_BASE64}" ]
    then
        echo "No license found."
        exit 2
    else 
        echo "${STATA_LIC_BASE64}" | base64 -d > /tmp/stata.lic
        [ -f /tmp/stata.lic ] && sudo mv /tmp/stata.lic /usr/local/stata/stata.lic
        [ -f /usr/local/stata/stata.lic ] && sudo chmod -w /usr/local/stata/stata.lic 
    fi
fi

if [ -f install.R ]
then
    echo "installing R packages..."
    Rscript install.R
fi
#docker buildx install
echo "post done."

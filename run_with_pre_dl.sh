docker run \
    -d \
    -e PRE_DOWNLOAD_DIR=/opt/pre_download \
    -v $(pwd)/download:/opt/pre_download \
    --name ofsm_pre_dl \
    dawn/ofsm_pre_dl:latest

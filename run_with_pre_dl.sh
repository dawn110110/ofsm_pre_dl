docker run \
    -d \
    -e PRE_DOWNLOAD_DIR=/opt/pre_download \
    -e TZ=Asia/Shanghai \
    -v $(pwd)/download:/opt/pre_download \
    -v $(pwd)/entrypoint.sh:/opt/entrypoint_pre_dl.sh \
    --name ofsm_pre_dl \
    -p 8080:80 \
    -p 34197:34197/udp \
    dawn/ofsm_pre_dl:latest

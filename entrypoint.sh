#!/bin/bash

init_config() {
    jq_cmd='.'

    if [ -n "$RCON_PASS" ]; then
      jq_cmd="${jq_cmd} | .rcon_pass = \"$RCON_PASS\""
      echo "Factorio rcon password is '$RCON_PASS'"
    fi

    jq_cmd="${jq_cmd} | .sq_lite_database_file = \"/opt/fsm-data/sqlite.db\""
    jq_cmd="${jq_cmd} | .log_file = \"/opt/fsm-data/factorio-server-manager.log\""

    jq "${jq_cmd}" /opt/fsm/conf.json >/opt/fsm-data/conf.json
}

random_pass() {
    LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom | fold -w 24 | head -n 1
}

install_game() {
    if [ "$PRE_DOWNLOAD_DIR" == "" ]
    then
        # 没有预下载，回退到默认的现下载.
        echo "no PRE_DOWNLOAD_DIR envrinment variable given, try direct download now"
        curl --location "https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64" \
             --output /tmp/factorio_${FACTORIO_VERSION}.tar.xz
        tar -xf /tmp/factorio_${FACTORIO_VERSION}.tar.xz
        rm /tmp/factorio_${FACTORIO_VERSION}.tar.xz
    else
        # 使用预下载目录
        echo "PRE_DOWNLOAD_DIR=${PRE_DOWNLOAD_DIR} given. won't download, woooo!"
        LATEST_FILE=$(ls -t1 ${PRE_DOWNLOAD_DIR} | head -n 1)
        if [ "$LATEST_FILE" == "" ]
        then
            echo "could not find file under "$PRE_DOWNLOAD_DIR", exit now"
            exit 1
        fi
        echo "Found latest file. [file_name="${LATEST_FILE}"]"
        set -x
        tar -xf ${PRE_DOWNLOAD_DIR}/${LATEST_FILE}
        ls -alt
        echo "Extract done"
    fi
}

if [ ! -f /opt/fsm-data/conf.json ]; then
    init_config
fi

install_game

cd /opt/fsm && ./factorio-server-manager --conf /opt/fsm-data/conf.json --dir /opt/factorio --port 80

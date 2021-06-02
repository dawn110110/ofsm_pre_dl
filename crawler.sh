# 最新版本的 factorio 下载地址 (linux x64 headless 版）
F_LATEST_DOWNLOAD_PATH=$(curl https://www.factorio.com/download 2>/dev/null \
    | grep get-download \
    | grep headless \
    | grep linux64 \
    | grep -v stable \
    | awk -F '"' '{print $2}')

# 类似这样 https://www.factorio.com/get-download/1.1.34/headless/linux64
F_LATEST_DOWNLOAD_URL="https://www.factorio.com"${F_LATEST_DOWNLOAD_PATH}

F_VERSION=$(echo $F_LATEST_DOWNLOAD_PATH | awk -F '/' '{print $(NF-2)}')
F_LOCAL_NAME="factorio_linux64_headless_"$F_VERSION".tar.xz"

DL_DIR=${1:-"./download"}
mkdir -p $DL_DIR
DL_FULL_PATH=${DL_DIR}/${F_LOCAL_NAME}

if [ -f ${DL_FULL_PATH} ]
then
    >&2 echo $(date +"%y-%m-%d %H:%M:%S, ")"no new version found. [current_latest_version=${F_VERSION}]"
else
    echo $(date +"%y-%m-%d %H:%M:%S, ")"Found new factorio version. [version=${F_VERSION}, dl_path=${DL_FULL_PATH}]"
    axel ${F_LATEST_DOWNLOAD_URL} -o ${DL_FULL_PATH}
    echo $(date +"%y-%m-%d %H:%M:%S, ")"Download finish. [dl_path=${DL_FULL_PATH}]"
fi

# CN 镜像源设置，根据时区判断（CST 时区时设置）
if test (date +%Z) = CST
    set -x HF_ENDPOINT "https://hf-mirror.com"
    set -x PUB_HOSTED_URL "https://mirrors.cernet.edu.cn/dart-pub"
    set -x FLUTTER_STORAGE_BASE_URL "https://mirrors.cernet.edu.cn/flutter"
    set -x NODE_MIRROR "https://mirrors.cernet.edu.cn/nodejs-release"
    set -x NVM_NODEJS_ORG_MIRROR "https://mirrors.cernet.edu.cn/nodejs-release"
    set -x RUSTUP_UPDATE_ROOT "https://mirrors.cernet.edu.cn/rustup/rustup"
    set -x RUSTUP_DIST_SERVER "https://mirrors.cernet.edu.cn/rustup"
end

# Homebrew 相关设置
set -x HOMEBREW_BREW_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
set -x HOMEBREW_CORE_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
set -x HOMEBREW_API_DOMAIN "https://mirrors.cernet.edu.cn/homebrew-bottles/api"
set -x HOMEBREW_BOTTLE_DOMAIN "https://mirrors.cernet.edu.cn/homebrew-bottles"
set -x HOMEBREW_PIP_INDEX_URL "https://mirrors.cernet.edu.cn/pypi/web/simple"

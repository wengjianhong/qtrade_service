# qtrade_service

支撑微服务与 protobuf/gRPC 生成库。依赖已安装的 `qtrade_common` 与 `qtrade_engine`；两者均**不**依赖本仓库。

交易引擎进程与 gRPC 接入实现（薄客户端 / `Grpc*Bridge`）见独立仓库 **qtrade_client**；策略插件见 **qtrade_strategy**。

## 内容

- `proto/`：config / account / account_risk
- `src/qtrade_service/service/`：三个支撑服务实现
- `src/qtrade_service/apps/`：三个 `*_service` 可执行文件入口
- 安装库：`libqtrade_service_proto.so`（`qtrade_service_common` 仅私有静态链进微服务，不安装）

公开 `#include` 仍为 `qtrade/...`（构建期 overlay；proto 头安装到 `include/qtrade/proto/`）。

## 构建顺序

```bash
# 1. 先安装 cpputils（见其 README）

# 2. 构建并安装 qtrade_common
cd /home/wengjianhong/GitSpace/qtrade_common
cmake -S . -B build \
  -DCMAKE_INSTALL_PREFIX=/usr/local/qtrade \
  -DCMAKE_PREFIX_PATH=/usr/local/cpputils
cmake --build build -j1
sudo cmake --install build

# 3. 构建并安装 qtrade_engine（仅核心库）
cd /home/wengjianhong/GitSpace/qtrade_engine
cmake -S . -B build \
  -DCMAKE_INSTALL_PREFIX=/usr/local/qtrade \
  -DCMAKE_PREFIX_PATH="/usr/local/cpputils;/usr/local/qtrade"
cmake --build build -j1
sudo cmake --install build

# 4. 构建 qtrade_service
cd /home/wengjianhong/GitSpace/qtrade_service
cmake -S . -B build \
  -DCMAKE_INSTALL_PREFIX=/usr/local/qtrade \
  -DCMAKE_PREFIX_PATH="/usr/local/cpputils;/usr/local/qtrade"
cmake --build build -j1
sudo cmake --install build
```

也可在工作区根目录执行：

```bash
/home/wengjianhong/GitSpace/scripts/cmake-build.sh
```

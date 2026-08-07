# qtrade_service

支撑微服务与引擎侧 gRPC 桥接实现。**依赖**已安装的 `qtrade_engine`（`find_package(qtrade_engine)`）；`qtrade_engine` **不**依赖本仓库。

交易引擎进程见独立仓库 **qtrade_client**；策略插件见 **qtrade_strategy**。

## 内容

- `proto/`：config / account / account_risk
- `src/qtrade/service/`：三个支撑服务实现
- `src/qtrade/client/`：gRPC 薄客户端
- `src/qtrade/bridge/`：`GrpcConfigBridge` / `GrpcAccountBridge` / `GrpcAccountRiskBridge`
- `apps/`：三个 `*_service` 可执行文件

## 构建顺序

```bash
# 1. 先构建并安装 qtrade_engine（仅核心库）
cd /home/wengjianhong/GitSpace/qtrade_engine
cmake -B build -DCMAKE_INSTALL_PREFIX=/usr/local/qtrade -DCMAKE_PREFIX_PATH=/usr/local/cpputils
cmake --build build -j1
sudo cmake --install build

# 2. 再构建 qtrade_service
cd /home/wengjianhong/GitSpace/qtrade_service
cmake -B build \
  -DCMAKE_INSTALL_PREFIX=/usr/local/qtrade \
  -DCMAKE_PREFIX_PATH="/usr/local/cpputils;/usr/local/qtrade"
cmake --build build -j1
sudo cmake --install build
```

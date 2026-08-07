/// @file      grpc_bridge_plugin.cpp
/// @brief     官方 gRPC 桥接插件 C ABI 导出（可编为 .so 供 dlopen）
/// @details   options_json 为 ServiceConfig 端点对象；config 另需 engine_id 字段。
/// @author    wengjianhong
/// @date      2026-08-06
/// @copyright CC BY-NC-SA 4.0
#include "qtrade/bridge/grpc_account_bridge.hpp"
#include "qtrade/bridge/grpc_account_risk_bridge.hpp"
#include "qtrade/bridge/grpc_config_bridge.hpp"
#include "qtrade/common/config/service_config.hpp"
#include "qtrade/common/json/json_util.hpp"

#include <qtrade/bridge/bridge_plugin_abi.h>

#include <spdlog/spdlog.h>

#include <optional>
#include <string>

namespace {

#if defined(__GNUC__) || defined(__clang__)
#define QTRADE_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define QTRADE_PLUGIN_EXPORT
#endif

[[nodiscard]] std::optional<qtrade::common::config::ServiceConfig> ParseBridgeOptions(
  const char* options_json,
  std::string* engine_id_out) {
  if (options_json == nullptr || options_json[0] == '\0') {
    spdlog::error("[grpc_bridge_plugin] options_json is empty");
    return std::nullopt;
  }
  const auto parsed = qtrade::common::ParseJsonString(options_json);
  if (!parsed.has_value() || !parsed->is_object()) {
    spdlog::error("[grpc_bridge_plugin] options_json must be a JSON object");
    return std::nullopt;
  }
  const nlohmann::json& root = parsed.value();
  const nlohmann::json& endpoint = root.contains("service") ? root.at("service") : root;
  auto service = qtrade::common::config::ParseServiceEndpoint(endpoint);
  if (!service.has_value()) {
    return std::nullopt;
  }
  if (engine_id_out != nullptr) {
    if (root.contains("engine_id") && root.at("engine_id").is_string()) {
      *engine_id_out = root.at("engine_id").get<std::string>();
    } else if (const auto ext = service->Extension("engine_id"); ext.has_value()) {
      *engine_id_out = ext.value();
    }
  }
  return service;
}

}  // namespace

extern "C" {

QTRADE_PLUGIN_EXPORT int qtrade_bridge_abi_version(void) {
  return QTRADE_BRIDGE_ABI_VERSION;
}

QTRADE_PLUGIN_EXPORT const char* qtrade_bridge_plugin_name(void) {
  return "grpc";
}

QTRADE_PLUGIN_EXPORT qtrade::config::IConfigBridge* qtrade_create_config_bridge(const char* options_json) {
  std::string engine_id;
  auto service = ParseBridgeOptions(options_json, &engine_id);
  if (!service.has_value()) {
    return nullptr;
  }
  if (engine_id.empty()) {
    spdlog::error("[grpc_bridge_plugin] config bridge requires engine_id");
    return nullptr;
  }
  return new qtrade::bridge::GrpcConfigBridge(std::move(service.value()), std::move(engine_id));
}

QTRADE_PLUGIN_EXPORT void qtrade_destroy_config_bridge(qtrade::config::IConfigBridge* bridge) {
  delete bridge;
}

QTRADE_PLUGIN_EXPORT qtrade::account::IAccountBridge* qtrade_create_account_bridge(const char* options_json) {
  auto service = ParseBridgeOptions(options_json, nullptr);
  if (!service.has_value()) {
    return nullptr;
  }
  return new qtrade::bridge::GrpcAccountBridge(std::move(service.value()));
}

QTRADE_PLUGIN_EXPORT void qtrade_destroy_account_bridge(qtrade::account::IAccountBridge* bridge) {
  delete bridge;
}

QTRADE_PLUGIN_EXPORT qtrade::account_risk::IAccountRiskBridge* qtrade_create_account_risk_bridge(
  const char* options_json) {
  auto service = ParseBridgeOptions(options_json, nullptr);
  if (!service.has_value()) {
    return nullptr;
  }
  return new qtrade::bridge::GrpcAccountRiskBridge(std::move(service.value()));
}

QTRADE_PLUGIN_EXPORT void qtrade_destroy_account_risk_bridge(qtrade::account_risk::IAccountRiskBridge* bridge) {
  delete bridge;
}

}  // extern "C"

# Flutter 平台通道（MethodChannel）

## 简介

调用 `MethodChannel('com.example/native').invokeMethod('getNativeData')`。本仓库**未**在 Android/iOS 侧注册对应实现，因此会收到 `PlatformException`，界面把异常信息完整显示出来——用来理解 **「Dart → 原生」没接上时会发生什么**。

## 快速开始

### 环境要求

Flutter SDK。

### 运行

```bash
flutter pub get
flutter run
```

## 概念讲解

### 第一部分：MethodChannel 的角色

它是 Dart 与原生之间「打电话」的管道：方法名、参数需与宿主代码约定一致。名字和 `MainActivity`/Swift 里注册的要匹配。

### 第二部分：捕获 `PlatformException`

Demo 在 `try/on PlatformException/catch` 三层区分「通道未实现」「其它错误」。真实项目里你还可能要处理 `MissingPluginException`（热插件未加载等）。

## 完整示例

见 `lib/main.dart`：`PlatformChannelPage` 的 `_invoke`。

## 注意事项

- 要跑通真实数据，需在对应平台 `MethodChannel` handler 里 `result.success(...)`。
- 二进制数据、大对象传输可改用 `BasicMessageChannel` 等。

## 完整讲解（中文）

平台通道最容易产生的误解是：**写了 Dart 这一头就会自动有原生那一头**。实际上两边都要接线。本 Demo 故意不接原生，让你一眼看到「缺实现」长什么样。等你补上 Kotlin/Swift 代码，同样的 Dart 调用就会从「红字异常」变成「原生返回值」——这条路径一旦走通，以后接入蓝牙、OCR、系统 TTS 都是同一套路。

# 運行前端 Flutter

[回前頁](./develop.md)

由於 Flutter 是一個跨平台的框架，所以你可以在不同的平台上運行 Flutter 應用

## 選擇模擬器

> 我們可以在 `Android`、`IOS`、`Web`、`Windows`、`MacOS`、`Linux` 上運行 Flutter 應用，但是在運行之前，我們需要選擇一個模擬器

- 使用 Chrome 來運行 Web 應用
- 使用 Android Studio 來運行 Android 應用
- 使用 Xcode 來運行 IOS 應用

但我們在 VScode 上配置好環境之後，可以直接使用 VScode 的 Flutter Plugin 來運行應用，方式如下：

- 輸入快速鍵 `ctrl` + `shift` + `p` ，打開 VScode 命令面板
- 打入 `Flutter: Launch Emulator`，選擇你要運行的模擬器
- 運行之後，你應該可以看到模擬器被成功啟用
- 接著打開終端機面板，輸入 `flutter devices` 這可以確認你目前有哪些模擬器可以使用
- 接著輸入 `flutter run` 來運行你的應用（會有選擇畫面，選擇你要運行的模擬器）

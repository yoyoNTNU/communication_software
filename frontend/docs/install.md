# 安裝與建置前端環境

> 本專案前端使用 Flutter 開發，請先安裝 Flutter 環境，並安裝相關套件

[回前頁](./develop.md)

## 安裝 Flutter

> 更多詳細資訊，請參考 [Flutter 官方文件](https://flutter.dev/docs/get-started/install)

### 安裝 Flutter SDK

> 根據不同作業系統，會有些微差異

#### Windows

1. 點擊下載 [Flutter SDK](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.10.5-stable.zip)

2. 解壓縮檔案到預想的目錄

    - 譬如說你可以將解壓縮的檔案放到 `C:\src\flutter` 目錄下

3. 設定 `PATH` 環境變數

    - 點擊開始，搜尋 `env`，點擊 `編輯系統環境變數`
    - 在 `系統變數` 中，點擊 `Path`，點擊 `編輯`
    - 創建一個新的 `PATH` 變數，並將 `flutter\bin` 路徑加入到 `PATH` 變數中

4. 驗證安裝，輸入以下指令

    ```bash
    flutter doctor
    ```

    如果有顯示一些檢查訊息，代表安裝成功

#### macOS

1. 請依據 Apple 版本，安裝 Flutter SDK

   - [Flutter SDK (Apple Silicon)](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.10.5-stable.zip)
   - [Flutter SDK (Intel)](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.10.5-stable.zip)

2. 解壓縮檔案到預想的目錄

    - 譬如說你可以將解壓縮的檔案放到 `~/developer/flutter` 目錄下

        如果是 Apple Silicon，麻煩打開終端機多做一個步驟：

        ```bash
         softwareupdate --install-rosetta --agree-to-license
        ```

3. 設定 `PATH` 環境變數

    - 打開 `~/.zshrc` 或 `~/.bashrc` 檔案，並加入以下內容

        > 請將下列路徑更改為你的 Flutter SDK 路徑

        ```bash
        export PATH="$PATH:$HOME/developer/flutter/bin"
        ```

    - 重新載入 `~/.zshrc` 或 `~/.bashrc` 檔案

        ```bash
        source ~/.zshrc
        source ~/.bashrc
        ```

4. 驗證安裝，輸入以下指令

    ```bash
    flutter doctor
    ```

    如果有顯示一些檢查訊息，代表安裝成功

### 配置 Platform

請打開 Terminal 或是 Command Line，並輸入以下指令

```bash
flutter doctor
```

接著會顯示一個檢查清單，請依據清單中的 issue 提示，將缺少的套件安裝完成

以下為一些常見的 issue 安裝方式

#### Android

1. 安裝 Android Studio

    > 請依據作業系統，安裝 Android Studio

    - [Android Studio (Windows)](https://developer.android.com/studio)
    - [Android Studio (macOS)](https://developer.android.com/studio)

2. 安裝 Android SDK

    - 打開 Android Studio
    - 點擊 `Setting` > `Appearance & Behavior` > `System Settings` > `Android SDK`
    - 選擇 `SDK tools`，勾選 `Android SDK Command-line Tools (latest)`
    - 點擊 `Apply`，便能夠完成安裝

3. Android License 驗證

    - 打開終端機，輸入以下指令

        ```bash
        flutter doctor --android-licenses
        ```

    - 依照提示，輸入 `y` 即可

#### iOS

1. 安裝 Xcode

    - [Xcode (macOS)](https://developer.apple.com/xcode/)

2. 安裝 Xcode Command Line Tools

    - 打開終端機，輸入以下指令

        ```bash
        sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
        sudo xcodebuild -runFirstLaunch
        ```

3. 安裝 CocoaPods

    - 打開終端機，輸入以下指令

        ```bash
        sudo gem install cocoapods
        ```

#### 最後結果

> 請確認 `flutter doctor` 指令執行結果，顯示 `No issues found!`，代表安裝完成

```zsh
❯ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.10.5, on macOS 13.4 22F66 darwin-arm64, locale
    zh-Hant-TW)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.1)
[✓] Xcode - develop for iOS and macOS (Xcode 14.3.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2022.1)
[✓] VS Code (version 1.79.2)
[✓] Connected device (2 available)
[✓] Network resources

• No issues found!
```

### 配置開發環境

> 此處以 VS Code 為例，其他編輯器請自行安裝相關套件

1. 安裝 VS Code

    - [VS Code (Windows)](https://code.visualstudio.com/)
    - [VS Code (macOS)](https://code.visualstudio.com/)

2. 安裝 VS Code Flutter 套件

    - 打開 VS Code
    - 點擊 `Extensions`，搜尋 `Flutter`，並安裝 `Flutter` 套件
    - 點擊 `Extensions`，搜尋 `Dart`，並安裝 `Dart` 套件

### 創建 Flutter 專案

1. 打開 VScode ，並打開 `Command Palette`，輸入 `Flutter: New Project`

   > 備註：`Command Palette` 快捷鍵為 `Ctrl + Shift + P`

2. 輸入專案名稱，並選擇專案儲存路徑

3. 如果沒有反應，關閉 VScode 重新開啟即可看到你的專案

### 運行專案

打開 VScode ，並打開 `Command Palette`，輸入 `Flutter: Launch Emulator`

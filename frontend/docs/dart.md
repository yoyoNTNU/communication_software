# Dart 基礎教學

> 內容擷取自 [Flutter 開發鐵人賽](https://ithelp.ithome.com.tw/articles/10215205)
> ，當中 Day 4 ~ Day 6 的內容

[回前頁](./develop.md)

## 資料型別

有 `int`、`double`、`String`、`bool`、`List`、`Map`、`Set` 等等

舉其中比較沒見過的型別做介紹：

### 1. List

```dart
List<int> list = [1, 2, 3];
```

### 2. Map

> 一般來說，還蠻常使用 Map 來接收 API 回傳的 JSON 格式資料

```dart
Map<String, int> map = {
    'a': 1,
    'b': 2,
    'c': 3,
};
```

### 3. Set

> set 與 list 的差別在於，set 中的元素不會重複

```dart
Set<int> set = {1, 2, 3};
```

### 4. Var & Dynamic

```dart
var a = 1;
var b = 'hello';
var c = true;
```

※ 備註：此種寫法一但宣告後，型別就固定了，不能再改變；若要改變，請參考以下兩種寫法

```dart
dynamic a = 1;  // dynamic 可以改變型別
var b;  // 宣告時不指定內容，可以改變型別
```

## Class

> Example：設計一個 `Student` 類別，
> 包含 `ID`、`status`、`_expectCredit`、`_actualCredit` 四個屬性

```dart
class Student {
    // Properties 屬性
    String _ID;         // 學生 ID
    int _status;        // 學生就學狀態 ( 0 代表休學， 1 代表在學 )
    int _expectCredit;  // 學生預計修習學分
    int _actualCredit;  // 學生實際獲得學分
    int gpa;

    // Constructor 建構子
    Student(this._ID, this.status, this._expectCredit, this._actualCredit);
    Student.noCredit(this._ID, this.status) {
        this._expectCredit = 0;
        this._actualCredit = 0;
    }

    // Getter & Setter
    String get state {  // 取得學生就學狀態（數據轉換成文字）
        return this._status == 0 ? '休學' : '在學';
    }
    String get pass {   // 取得學生是否通過畢業門檻（通過計算獲得）
        return this._actualCredit >= this._expectCredit ? '通過' : '不通過';
    }
    set avgGPA(List<int> gpaList) { // 計算學生平均成績並存入 gpa 屬性
        int sum = 0;
        for (int i = 0; i < gpaList.length; i++) {
            sum += gpaList[i];
        }
        this.gpa = sum / gpaList.length;
    }
}
```

1. 底線開頭的屬性，代表該屬性為 `private`，只能在 `class` 內部使用

2. 可以自定義多個建構方式，實際在外部使用方式如下

    ```dart
    // 指定一般學生為在學狀態，並預計修習 128 學分，實際獲得 128 學分
    Student student1 = Student('A123456789', 1, 128, 128);
    // 指定一位學生為在學狀態，但尚未修習任何學分
    Student student2 = Student.noCredit('B123456789', 1);
    ```

3. 可以自定義 `getter` 與 `setter`，實際在外部使用方式如下

    ```dart
    // 取得學生就學狀態（數據轉換成文字）
    print(student1.state);
    // 取得學生是否通過畢業門檻（通過計算獲得）
    print(student1.pass);
    // 輸入學生各科成績，計算學生平均成績並存入 gpa 屬性
    student1.avgGPA = [80, 90, 100];
    ```

4. Extend 與 Mixin 特性

    ```dart
    // 繼承
    class Student extends Person {
        // ...
    }

    // Mixin
    class Student extends Person with Study {
        // ...
    }
    ```

## Async & Await

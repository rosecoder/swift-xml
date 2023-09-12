# swift-xml

## Overview

swift-xml is a lightweight library for encoding XML in Swift. Built with a focus on type safety, it provides a simple way to generate XML documents directly in Swift code using result builders.

## Usage

### Creating a Document

```swift
let document = Document {
    Node("root", attributes: ["attr": "value"]) {
        Node("child")
    }
}
```

### Encoding

```swift
let data = document.encoded() // returns Data
```

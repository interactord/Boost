// The Swift Programming Language
// https://docs.swift.org/swift-book

public enum DemoLink {
  public enum Path: String {
    case step1
    case step2
  }
}

extension DemoLink {
  public enum QueryItem {
  }
}

extension DemoLink.QueryItem {
  public struct Demo2: Equatable, Codable {
    let name: String
    let age: Int
  }
}

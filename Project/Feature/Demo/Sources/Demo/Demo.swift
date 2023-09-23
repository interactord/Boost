// The Swift Programming Language
// https://docs.swift.org/swift-book

public enum DemoLink {
  public enum Path: String {
    case home
    case page1
    case page2
    case page3
    case page4
  }
}

extension DemoLink {
  public enum QueryItem {
  }
}

// API의 Query를 만들때 사용할 것
extension DemoLink.QueryItem {
  public struct Demo: Equatable, Codable {
//    let page: Int
    //    let age: Int
    
  }
  
  public struct Demo2: Equatable, Codable {
//    let page: Int
    //    let age: Int
  }
  
  public struct Demo3: Equatable, Codable {
//    let page: Int
    //    let age: Int
  }
  
  public struct Demo4: Equatable, Codable {
    let message: String
    //    let age: Int
  }
}

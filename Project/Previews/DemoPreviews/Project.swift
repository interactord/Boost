import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .previewProject(
  projectName: "Demo",
  packages: [
    .local(path: "../../Feature/Demo"),
  ],
  dependencies: [
    .package(product: "Demo"),
  ])

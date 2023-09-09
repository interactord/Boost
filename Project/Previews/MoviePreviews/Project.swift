import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .previewProject(
  projectName: "Movie",
  packages: [
    .local(path: "../../Feature/Movie"),
  ],
  dependencies: [
    .package(product: "Movie"),
  ])

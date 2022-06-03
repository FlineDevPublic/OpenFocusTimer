#!/opt/homebrew/bin/swift-sh

import AnyLint // @FlineDev

// swiftlint:disable:next closure_body_length
try Lint.logSummaryAndExit(arguments: CommandLine.arguments) {
   // MARK: - Variables
   let readmeFile: Regex = #"^README\.md$"#
   let appSwiftFile: Regex = #"^OpenFocusTimer/.*\.swift$"#
   let packageSwiftFile: Regex = #"^Sources/.*\.swift$"#
   let testSwiftFile: Regex = #"^Tests/.*\.swift$"#

   // MARK: - Checks
   // MARK: - ComparisonParamNamingLeft
   try Lint.checkFileContents(
      checkInfo: "ComparisonParamNamingLeft: Using `lhs` is error-prone, prefer `left` instead.",
      regex: #"(\W)(lhs)(\W)"#,
      nonMatchingExamples: [" alhso "],
      includeFilters: [appSwiftFile, packageSwiftFile, testSwiftFile],
      autoCorrectReplacement: "$1left$3",
      autoCorrectExamples: [
         ["before": "{ lhs, rhs in", "after": "{ left, rhs in"],
         ["before": "func == (lhs: Self, rhs: Self)", "after": "func == (left: Self, rhs: Self)"],
      ]
   )

   // MARK: - ComparisonParamNamingRight
   try Lint.checkFileContents(
      checkInfo: "ComparisonParamNamingRight: Using `rhs` is error-prone, prefer `right` instead.",
      regex: #"(\W)(rhs)(\W)"#,
      nonMatchingExamples: [" erhsi "],
      includeFilters: [appSwiftFile, packageSwiftFile, testSwiftFile],
      autoCorrectReplacement: "$1right$3",
      autoCorrectExamples: [
         ["before": "{ lhs, rhs in", "after": "{ lhs, right in"],
         ["before": "func == (lhs: Self, rhs: Self)", "after": "func == (lhs: Self, right: Self)"],
      ]
   )

   // MARK: - DeveloperWarnings
   try Lint.checkFileContents(
      checkInfo: "DeveloperWarnings: Prepend '🧑‍💻 ' to your custom #warnings to differentiate them better from Xcode warnings.",
      regex: #"#warning\((#?)"(?!🧑‍💻 )"#,
      nonMatchingExamples: [#"#warning("🧑‍💻 foo bar")"#],
      includeFilters: [appSwiftFile, packageSwiftFile, testSwiftFile],
      autoCorrectReplacement: #"#warning($1"🧑‍💻 "#,
      autoCorrectExamples: [
         ["before": #"#warning("foo bar")"#, "after": #"#warning("🧑‍💻 foo bar")"#],
         ["before": ##"#warning(#"foo bar"#)"##, "after": ##"#warning(#"🧑‍💻 foo bar"#)"##],
         ["before": #"#warning("🧑‍💻 foo bar")"#, "after": #"#warning("🧑‍💻 foo bar")"#],
      ]
   )

   // MARK: Readme
   try Lint.checkFilePaths(
      checkInfo: "Readme: Each project should have a README.md file, explaining how to use or contribute to the project.",
      regex: readmeFile,
      matchingExamples: ["README.md"],
      nonMatchingExamples: ["README.markdown", "Readme.md", "ReadMe.md"],
      violateIfNoMatchesFound: true
   )

   // MARK: ReadmePath
   try Lint.checkFilePaths(
      checkInfo: "ReadmePath: The README file should be named exactly `README.md`.",
      regex: #"^(.*/)?([Rr][Ee][Aa][Dd][Mm][Ee]\.markdown|readme\.md|Readme\.md|ReadMe\.md)$"#,
      matchingExamples: ["README.markdown", "readme.md", "ReadMe.md"],
      nonMatchingExamples: ["README.md", "CHANGELOG.md", "CONTRIBUTING.md", "api/help.md"],
      autoCorrectReplacement: "$1README.md",
      autoCorrectExamples: [
         ["before": "api/readme.md", "after": "api/README.md"],
         ["before": "ReadMe.md", "after": "README.md"],
         ["before": "README.markdown", "after": "README.md"],
      ]
   )

   // MARK: ReadmeTopLevelTitle
   try Lint.checkFileContents(
      checkInfo: "ReadmeTopLevelTitle: The README.md file should only contain a single top level title.",
      regex: #"(^|\n)#[^#](.*\n)*\n#[^#]"#,
      matchingExamples: [
         """
         # Title
         ## Subtitle
         Lorem ipsum

         # Other Title
         ## Other Subtitle
         """,
      ],
      nonMatchingExamples: [
         """
         # Title
         ## Subtitle
         Lorem ipsum #1 and # 2.

         ## Other Subtitle
         ### Other Subsubtitle
         """,
      ],
      includeFilters: [readmeFile]
   )

   // MARK: ReadmeTypoLicense
   try Lint.checkFileContents(
      checkInfo: "ReadmeTypoLicense: Misspelled word 'license'.",
      regex: #"([\s#]L|l)isence([\s\.,:;])"#,
      matchingExamples: [" lisence:", "## Lisence\n"],
      nonMatchingExamples: [" license:", "## License\n"],
      includeFilters: [readmeFile],
      autoCorrectReplacement: "$1icense$2",
      autoCorrectExamples: [
         ["before": " lisence:", "after": " license:"],
         ["before": "## Lisence\n", "after": "## License\n"],
      ]
   )
}

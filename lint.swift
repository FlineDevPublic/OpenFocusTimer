#!/opt/homebrew/bin/swift-sh
import AnyLint // @Flinesoft

// swiftlint:disable:next closure_body_length
try Lint.logSummaryAndExit(arguments: CommandLine.arguments) {
   // MARK: - Variables
   let readmeFile: Regex = #"^README\.md$"#
   let appSwiftFile: Regex = #"^OpenFocusTimer/.*\.swift$"#
   let packageSwiftFile: Regex = #"^Sources/.*\.swift$"#
   let testSwiftFile: Regex = #"^Tests/.*\.swift$"#

   // MARK: - Checks
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

   // MARK: - DeveloperWarnings
   try Lint.checkFileContents(
      checkInfo: "DeveloperWarnings: Prepend '[Dev] ' to your custom #warnings to differentiate them better from Xcode warnings.",
      regex: #"#warning\((#?)"(\[(DEV|dev|dEv|deV|DEv|DeV)\]\s*)?(?!\[Dev\] )"#,
      nonMatchingExamples: [#"#warning("[Dev] foo bar")"#],
      includeFilters: [appSwiftFile, packageSwiftFile, testSwiftFile],
      autoCorrectReplacement: #"#warning($1"[Dev] "#,
      autoCorrectExamples: [
         ["before": #"#warning("foo bar")"#, "after": #"#warning("[Dev] foo bar")"#],
         ["before": ##"#warning(#"foo bar"#)"##, "after": ##"#warning(#"[Dev] foo bar"#)"##],
         ["before": #"#warning("[DEV] foo bar")"#, "after": #"#warning("[Dev] foo bar")"#],
      ]
   )
}

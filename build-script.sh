#!/bin/bash
set -euxo pipefail

cd OpenFocusTimer

swiftgen

swift-format --recursive ../Sources ../Tests App ../Package.swift --in-place --configuration swift-format.json
swift-format lint --recursive ../Sources ../Tests App ../Package.swift --strict --configuration swift-format.json

swiftlint --strict

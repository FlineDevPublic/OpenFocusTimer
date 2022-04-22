#!/bin/bash
set -euxo pipefail

bartycrouch update
bartycrouch lint

swiftgen

swift-format --recursive ../Sources ../Tests App ../Package.swift --in-place --configuration swift-format.json
swift-format lint --recursive ../Sources ../Tests App ../Package.swift --strict --configuration swift-format.json

swiftlint --strict

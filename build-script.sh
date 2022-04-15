#!/bin/bash
set -euxo pipefail

swiftgen

swift-format --recursive Sources Tests OpenFocusTimer/App Package.swift --in-place
swift-format lint --recursive Sources Tests OpenFocusTimer/App Package.swift --strict

bartycrouch update
bartycrouch lint

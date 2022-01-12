#!/bin/bash
set -euxo pipefail

swift-format --recursive Sources Tests OpenFocusTimer/App Package.swift --in-place

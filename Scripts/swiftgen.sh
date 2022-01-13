#!/bin/sh

BASE_DIRECTORY="seatgeek-iOS"
GENERATED_DIRECTORY="$BASE_DIRECTORY/Generated"
RESSOURCES_DIRECTORY="$BASE_DIRECTORY/Resources"

mkdir -p ${GENERATED_DIRECTORY}

./Pods/SwiftGen/bin/swiftgen storyboards \
    -t scenes-swift5 $BASE_DIRECTORY \
    --output $GENERATED_DIRECTORY/Storyboards.swift
./Pods/SwiftGen/bin/swiftgen strings -p \
	./Template/SwiftGen/strings/public-structured-swift5.stencil \
    $RESSOURCES_DIRECTORY/Localizable/en.lproj/Localizable.strings \
    --output $GENERATED_DIRECTORY/GeneratedLocalizableStrings.swift
./Pods/SwiftGen/bin/swiftgen xcassets \
    -t swift5 \
    $RESSOURCES_DIRECTORY/Assets.xcassets \
    --output $GENERATED_DIRECTORY/GeneratedAssets.swift

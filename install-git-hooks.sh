#!/bin/bash

set -e

TEMPLATE_PATH="$(dirname $0)/hooks"

TARGET_HOOKS_DIR="$(pwd)/.git/hooks"

HOOKS="pre-commit pre-push"

test -d $TARGET_HOOKS_DIR || ( echo "FAILED: $TARGET_HOOKS_DIR not present" && exit 255 )

echo "proceed with installing to $TARGET_HOOKS_DIR? [ENTER]"
read

for hook in $HOOKS; do
	if test -e $TARGET_HOOKS_DIR/$hook; then
		echo "$TARGET_HOOKS_DIR/$hook already exists; migrating ..."
		mkdir -pv $TARGET_HOOKS_DIR/$hook.d
		mv -v $TARGET_HOOKS_DIR/$hook $TARGET_HOOKS_DIR/$hook.d/00_migrated
	fi
done

cp -rv $TEMPLATE_PATH/* $TARGET_HOOKS_DIR/

for hook in $HOOKS; do
	ln -s git-multi-hook.sh $TARGET_HOOKS_DIR/$hook
done

tree $TARGET_HOOKS_DIR

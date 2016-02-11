#!/bin/sh

shopt -s nocaseglob # Make case insensitive

if [ "$#" -lt 1 ]
then
  echo "\nUsage:\n"
  echo "carthage_revert_except [FRAMEWORK] [FRAMEWORK] ...\n"
  exit 1
fi

# git checkout Carthage/Build/Mac --force

for framework in `find Carthage/Build/iOS -iname \*.framework\*`; do
	for arg; do
		exception=${arg[$i]}
		if [[ $framework =~ $exception ]]; then
			echo "Keeping $framework"
		else
			echo "Reverting $framework"
			git checkout "$framework" --force
		fi
	done
done

git clean -f Carthage/Build/iOS/*.bcsymbolmap

echo "\nDone! 🐌🐝🐸"

shopt -u nocaseglob # Turn back on case sensitive
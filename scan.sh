#!/usr/bin/env bash

[[ "${TRACE}" ]] && set -x
set -eou pipefail
shopt -s nullglob

downloadTattletale() {
	if wget -q "https://drive.google.com/uc?export=download&id=1EgzLinKroQPqqfEUCrFRCUov110hw0qV" -O tattletale-1.1.2.Final.zip; then
		unzip "tattletale-1.1.2.Final.zip"
		rm "tattletale-1.1.2.Final.zip"
	fi
}

main() {
	cat <<EOF
 _   _ _                              _  __  __ 
| | | (_)                            (_)/ _|/ _|
| |_| |_ _ __  _ __   ___   __ _ _ __ _| |_| |_ 
|  _  | | '_ \| '_ \ / _ \ / _\` | '__| |  _|  _|
| | | | | |_) | |_) | (_) | (_| | |  | | | | |  
\_| |_/_| .__/| .__/ \___/ \__, |_|  |_|_| |_|  
        | |   | |           __/ |               
        |_|   |_|          |___/                
JDK 11 Migration Analysis Tool V 1.0
EOF

	TATTLETALE="tattletale-1.1.2.Final/tattletale.jar"
	if ! [[ -f "$TATTLETALE" ]]; then
		echo "Downloading tattletale"
		downloadTattletale
	fi

	projectDir="$1"

	if [ ! -d $projectDir"/target/docker" ]; then
		pushd $projectDir
		sbt docker:publishLocal
		popd
	fi

	echo "Generating dependency report"

	java -jar "$TATTLETALE" $projectDir'/target' $projectDir'/report'

	./analysis.py $projectDir"/report/classdependson/index.html"
}

main "$@"

#!/bin/sh

PROJECT_PATH=$(dirname "$0")
cd "${PROJECT_PATH}/releng/parent"

M2_REPO=".m2_test"
SETTINGS="${M2_REPO}/settings.xml"

if [ -d "${M2_REPO}" ];
then
	echo "Deleting already existing local Maven repo ${M2_REPO}."
	rm -rf "${M2_REPO}"
fi

mkdir "${M2_REPO}"
cat << EOF >> ${SETTINGS} 
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">
      <localRepository/>
      <interactiveMode/>
      <offline/>
      <pluginGroups/>
      <servers/>
      <mirrors/>
      <proxies/>
      <profiles/>
      <activeProfiles/>
   </settings>
EOF

echo "./mvnw $@ --settings=\"${SETTINGS}\" -Dmaven.repo.local=\"./${M2_REPO}/repository\" clean verify"
./mvnw $@ --settings="${SETTINGS}" -Dmaven.repo.local="./${M2_REPO}/repository" clean verify || { echo "Build failed, abort"; exit 1; }
cd - > /dev/null 2>&1

echo "Build successful"

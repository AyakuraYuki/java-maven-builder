#!/usr/bin/env bash

cur_dir=$(pwd)

maven_version="3.8.4"
image_tag="maven-${maven_version}-openjdk-11-cn"
maven_package="apache-maven-${maven_version}-bin.tar.gz"
maven_dir="apache-maven-${maven_version}"
jdk_package="microsoft-jdk-11.0.13.8.1-linux-x64.tar.gz"
jdk_dir="jdk-11.0.13+8"
jdk_safe_dir="jdk-11.0.13.8"

if [ ! -f "${cur_dir}/${maven_package}" ]; then
  wget "https://dlcdn.apache.org/maven/maven-3/${maven_version}/binaries/${maven_package}" -O "${cur_dir}/${maven_package}"
fi

if [ ! -f "${cur_dir}/${jdk_package}" ]; then
  wget "https://aka.ms/download-jdk/${jdk_package}" -O "${cur_dir}/${jdk_package}"
fi

tar -xzf "${cur_dir}/${maven_package}"
tar -xzf "${cur_dir}/${jdk_package}"
mv "${cur_dir}/${jdk_dir}" "${cur_dir}/${jdk_safe_dir}"

docker build -t java-maven-builder:${image_tag} .

rm "${cur_dir}/${maven_package}"
rm "${cur_dir}/${jdk_package}"
# shellcheck disable=SC2115
rm -rf "${cur_dir}/${maven_dir}"
# shellcheck disable=SC2115
rm -rf "${cur_dir}/${jdk_safe_dir}"

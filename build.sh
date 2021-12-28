#!/usr/bin/env bash

cur_dir=$(pwd)
image_tag="maven-3.8.4-openjdk-11-cn"
maven_package="apache-maven-3.8.4-bin.tar.gz"
maven_dir="apache-maven-3.8.4"
jdk_package="microsoft-jdk-11.0.13.8.1-linux-x64.tar.gz"
jdk_dir="jdk-11.0.13+8"
jdk_safe_dir="jdk-11.0.13.8"

if [ ! -f "${cur_dir}/${maven_package}" ]; then
  wget https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/${maven_package} -O "${cur_dir}/${maven_package}"
fi

if [ ! -f "${cur_dir}/${jdk_package}" ]; then
  wget https://aka.ms/download-jdk/${jdk_package} -O "${cur_dir}/${jdk_package}"
fi

tar -xzf "${cur_dir}/${maven_package}"
tar -xzf "${cur_dir}/${jdk_package}"
mv "${cur_dir}/${jdk_dir}" "${cur_dir}/${jdk_safe_dir}"

docker buildx build --platform=linux/amd64 -t java-maven-builder:${image_tag} .

#rm -v "${cur_dir}/${maven_package}"
#rm -v "${cur_dir}/${jdk_package}"

# shellcheck disable=SC2115
rm -rf "${cur_dir}/${maven_dir}"
# shellcheck disable=SC2115
rm -rf "${cur_dir}/${jdk_safe_dir}"

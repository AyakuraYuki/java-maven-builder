#!/usr/bin/env bash

source config.sh

cur_dir=$(pwd)

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

rm "${cur_dir}/${maven_package}"
rm "${cur_dir}/${jdk_package}"
# shellcheck disable=SC2115
rm -rf "${cur_dir}/${maven_dir}"
# shellcheck disable=SC2115
rm -rf "${cur_dir}/${jdk_safe_dir}"

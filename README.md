# java-maven-builder

> A basic docker image for building maven project.

## About this image

* It presented a non-root user environment
  * user_name=`codeboy`
  * user_home=`/home/codeboy`
* image tag, which ends with `-cn`, its apt repository and maven mirror has been changed to Aliyun.

## How to build

```shell
# get current workdir in host machine
cur_dir=$(pwd)

# define necessary variables
maven_version="3.8.4"
image_tag="maven-${maven_version}-openjdk-11-cn"
maven_package="apache-maven-${maven_version}-bin.tar.gz"
maven_dir="apache-maven-${maven_version}"
jdk_package="microsoft-jdk-11.0.13.8.1-linux-x64.tar.gz"
jdk_dir="jdk-11.0.13+8"
jdk_safe_dir="jdk-11.0.13.8"

# download maven and openjdk
wget "https://dlcdn.apache.org/maven/maven-3/${maven_version}/binaries/${maven_package}" -O "${cur_dir}/${maven_package}"
wget "https://aka.ms/download-jdk/${jdk_package}" -O "${cur_dir}/${jdk_package}"
tar -xzf "${cur_dir}/${maven_package}"
tar -xzf "${cur_dir}/${jdk_package}"
mv "${cur_dir}/${jdk_dir}" "${cur_dir}/${jdk_safe_dir}"

# build image
docker build -t "ayakurayuki/java-maven-builder:${image_tag}" .

# on apple silicon, use the following command to build image
docker buildx build --platform=linux/amd64 -t "ayakurayuki/java-maven-builder:${image_tag}" .

# cleanup
rm "${cur_dir}/${maven_package}"
rm "${cur_dir}/${jdk_package}"
rm -rf "${cur_dir}/${maven_dir}"
rm -rf "${cur_dir}/${jdk_safe_dir}"
```

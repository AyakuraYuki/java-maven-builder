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
cur_dir=$(pwd) \
  && tar -xzf "${cur_dir}/apache-maven-3.8.4-bin.tar.gz" \
  && tar -xzf "${cur_dir}/microsoft-jdk-11.0.13.8.1-linux-x64.tar.gz" \
  && mv "${cur_dir}/jdk-11.0.13+8" "${cur_dir}/jdk-11.0.13.8"

# build image
docker build -t "ayakurayuki/java-maven-builder:maven3.8.4-openjdk11-cn" .

# on apple silicon, use the following command to build image
docker buildx build --platform=linux/amd64 -t "ayakurayuki/java-maven-builder:maven3.8.4-openjdk11-cn" .

# cleanup
rm -rf "${cur_dir}/apache-maven-3.8.4" && rm -rf "${cur_dir}/jdk-11.0.13.8"
```

## Simple Buildbox 

A docker image that makes it easy to package up your build toolchains and in particular, JVM build tools.

The initial use case for creating this image was for use as a custom build image in AWS CodeBuild. By default AWS CodeBuild provides you with several Ubuntu based images that have either Docker OR Java OR Node etc installed. However if you have a build that requires both Docker and Java you are out of luck. AWS CodeBuild provides the option to specify your own custom docker images for this purpose.

While AWS CodeBuild was the initial driver for creating this image there is nothing that would stop this from being a general purpose image for development teams to package up a golden source / reference toolchain stack for building their applications (both on their local machines and in a CI tool like Jenkins).

## Whats Installed

By default the following tools are installed: 

* docker
* aws cli
* python 
* sdkman (and the folldwing sdkman managed tools)
  * java
  * maven
  * gradle
  * sbt

To see specific versions of the tools installed in a particular release refer to the [CHANGELOG](./CHANGELOG.md).

This image makes use of [Sdkman](http://sdkman.io) to manage the JVM related build tools. The neat thing about this is that:

* It's a one line change to edit the Dockerfile to add one of the many SDK's managed by Sdkman.
* It's a one line change to edit the Dockerfile to remove a tool you don't need.
* At build runtime you can easily switch the version of java, maven, sbt etc that you are using just for that particular run.

## Usage

### How To Use In AWS Code Build

TODO

### How To Extend This Image For Use In AWS Code Build

TODO

### How To Use As A Local Build Toolchain

TODO

## License

View the [LICENSE](./LICENSE) for the software contained in this image.

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

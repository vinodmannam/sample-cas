Windows Build Setup
============================
To build on Windows you should use the build.cmd command instead of build.sh.

Open a command prompt or execute cmd from your bash shell.

In order to run the build, you have to create the folder \etc\cas at the root of the driver letter where your working directory exists.

If your working directory is on the C drive, then you must create directory C:\etc\cas.

You must also have the path to the java bin directory where the keytool program exists.

ONce these prerequisites are met, run the following commands to get the program running locally.

```
build.cmd copy
build.cmd gencert
build.cmd run
```

Docker BUild
============================
To build the docker image, you must first run the build locally to create the target/cas.war file.

The docker build will copy the etc/cas/config directory, target/cas.war, and docker/entrypoint.sh files into the image.

The keystore file will not be copied into the docker image.  The keystore should not be part of the image, it should be mounted as a volume in the container at run time.

Any static configuration that should be the same in all deployment environments can be placed in the etc/cas/config/cas.properties file.

Any other configuration needs to be injected in the container at runtime using environment variables.

To build and run the container, run these commands.

```
docker build -t cas:local .
docker run --rm -p 8443:8443 -v `cygpath -w ${PWD}`/thekeystore:/etc/cas/thekeystore cas:local
```

*Note* With Docker for Windows, you have to convert the host path for a volume to the windows path if you are in bash.

CAS Overlay Template
============================

Generic CAS WAR overlay to exercise the latest versions of CAS. This overlay could be freely used as a starting template for local CAS war overlays. The CAS services management overlay is available [here](https://github.com/apereo/cas-services-management-overlay).

# Versions

```xml
<cas.version>5.3.x</cas.version>
```

# Requirements

* JDK 1.8+

# Configuration

The `etc` directory contains the configuration files and directories that need to be copied to `/etc/cas/config`.

# Build

To see what commands are available to the build script, run:

```bash
./build.sh help
```

To package the final web application, run:

```bash
./build.sh package
```

To update `SNAPSHOT` versions run:

```bash
./build.sh package -U
```

# Deployment

- Create a keystore file `thekeystore` under `/etc/cas`. Use the password `changeit` for both the keystore and the key/certificate entries.
- Ensure the keystore is loaded up with keys and certificates of the server.

On a successful deployment via the following methods, CAS will be available at:

* `http://cas.server.name:8080/cas`
* `https://cas.server.name:8443/cas`

## Executable WAR

Run the CAS web application as an executable WAR.

```bash
./build.sh run
```

## Spring Boot

Run the CAS web application as an executable WAR via Spring Boot. This is most useful during development and testing.

```bash
./build.sh bootrun
```

### Warning!

Be careful with this method of deployment. `bootRun` is not designed to work with already executable WAR artifacts such that CAS server web application. YMMV. Today, uses of this mode ONLY work when there is **NO OTHER** dependency added to the build script and the `cas-server-webapp` is the only present module. See [this issue](https://github.com/spring-projects/spring-boot/issues/8320) for more info.


## Spring Boot App Server Selection

There is an app.server property in the `pom.xml` that can be used to select a spring boot application server.
It defaults to `-tomcat` but `-jetty` and `-undertow` are supported.

It can also be set to an empty value (nothing) if you want to deploy CAS to an external application server of your choice.

```xml
<app.server>-tomcat<app.server>
```

## Windows Build

If you are building on windows, try `build.cmd` instead of `build.sh`. Arguments are similar but for usage, run:

```
build.cmd help
```

## External

Deploy resultant `target/cas.war`  to a servlet container of choice.


## Command Line Shell

Invokes the CAS Command Line Shell. For a list of commands either use no arguments or use `-h`. To enter the interactive shell use `-sh`.

```bash
./build.sh cli
```
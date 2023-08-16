# docker-snowball
Recently found myself in the unfortunate position of needing to rebuild a QNAP NAS with ~30TB of data, so decided to use an AWS Snowball as both a staging area for the rebuild, and a replication seed to kick off the offsite backup replication into S3 - Enter the dockerised snowball client to run on things like a QNAP or Synology NAS that have _'quirky'_ distros

## Building the container
```sh
git clone https://github.com/eXodus1440/docker-snowball.git
cd docker-snowball
docker build . -t snowball-cli:latest
```
Or if you're using an M1 Mac
```sh
docker build --platform linux/x86_64 . -t snowball-cli:latest
```

## Running snowballEdge
```sh
# docker run --rm -it snowball-cli <command>
docker run --rm -it snowball-cli configure
```

mounting local configuration and credentials (.aws) and current working directory to the container's /aws directory
```sh
# docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws snowball-cli <command>
docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws snowball-cli configure
```

Or if you're using an M1 Mac
```sh
# docker run --platform linux/x86_64 --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws snowball-cli <command>
docker run --platform linux/x86_64 --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws snowball-cli configure
```
Full list of `<commands>` available on the AWS site [here](https://docs.aws.amazon.com/snowball/latest/developer-guide/using-client-commands.html)

## How the command functions:

`docker run --rm -it repository/name` – The equivalent of the `snowballEdge` executable. Each time you run this command, Docker spins up a container of the built image, and executes your `snowballEdge` command

For example, to call the `snowballEdge help` command in Docker, you run the following:
```sh
docker run --rm -it snowball-cli help
```

* `--rm` – Specifies to clean up the container after the command exits
* `-it` – Specifies to open a pseudo-TTY with stdin. This enables you to provide input to `snowballEdge` while it's running in a container, for example, by using the `snowballEdge configure` and `snowballEdge help` commands. When choosing whether to omit -it, consider the following:
For more information about the `docker run` command, see the [Docker reference guide](https://docs.docker.com/engine/reference/run/).

## Shorten the docker run command
For basic access to the `snowballEdge` command
```sh
alias snowballEdge='docker run --rm -it snowball-cli'
```

For access to the host file system and configuration settings when using `snowballEdge` commands
```sh
alias snowballEdge='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws snowball-cli'
```

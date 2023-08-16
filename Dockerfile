FROM public.ecr.aws/amazonlinux/amazonlinux:2
RUN yum update -y \
  && yum install -y wget tar gzip \
  && yum clean all
ARG URL="https://snowball-client.s3.us-west-2.amazonaws.com/latest/snowball-client-linux.tar.gz"
RUN wget $URL \
  && mkdir /snowball-cli \
  && tar -zxf snowball-client-linux.tar.gz --directory /snowball-cli --strip-components=1
WORKDIR /aws
ENTRYPOINT ["/snowball-cli/bin/snowballEdge"]

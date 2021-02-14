FROM centos:8

RUN \
echo \
$'[gcsfuse]\n\
name=gcsfuse (packages.cloud.google.com)\n\
baseurl=https://packages.cloud.google.com/yum/repos/gcsfuse-el7-x86_64\n\
enabled=1\n\
gpgcheck=1\n\
repo_gpgcheck=1\n\
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg \
 https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg'\
> /etc/yum.repos.d/gcsfuse.repo

RUN yum -y install gcsfuse

ENV GCS_BUCKET=my-bucket
ENV PATH_TO_MOUNT=/mnt
ENV GOOGLE_APPLICATION_CREDENTIALS=/etc/gcloud/service-account.json
ENV GCSFUSE_ARGS=""

CMD gcsfuse ${GCSFUSE_ARGS} --foreground -o nonempty ${GCS_BUCKET} ${PATH_TO_MOUNT};
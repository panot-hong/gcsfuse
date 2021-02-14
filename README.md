# gcsfuse
The base image with gcsfuse on centos 8. This image can also be found at [panot/gcsfuse](https://hub.docker.com/r/panot/gcsfuse).

## What is gcsfuse
https://cloud.google.com/storage/docs/gcs-fuse

## Usage

Build image
```
docker build -t gcsfuse . --no-cache
```
Run container
```
docker run -d --privileged --device=/dev/fuse -v $(pwd)/secret:/etc/gcloud -e PATH_TO_MOUNT=/etc/mount -e GCS_BUCKET=mybucket -e GOOGLE_APPLICATION_CREDENTIALS=/etc/gcloud/service-account.json --name gcsfuse gcsfuse:latest
```
Running above command will create and run a container that accommodate a gcsfuse inside.

### Environment Variables
`PATH_TO_MOUNT` - path within the container to mount to the gcsfuse - <i>default is /mnt</i>.  
`GCS_BUCKET` - Google Cloud Storage bucket name to mount to - <i>default is /my-bucket</i>.  
`GOOGLE_APPLICATION_CREDENTIALS` - path to the service account json file within the container - <i>default is /etc/gcloud/service-account.json</i>.  
`GCSFUSE_ARGS` - gcsfuse arguments, see more details at https://github.com/GoogleCloudPlatform/gcsfuse - <i>default is empty</i>.

## **Important** Limitation 
Bind mount or volume mount from host, from another container or even within the container itself to the fuse mount location is overridden by the fuse mount. For example if applying following volume bind mount `-v $(pwd)/sourcedir:/mnt` to above `docker run` command, when gcsfuse started, the mount to the /mnt directory get override. Copying file to the `sourcedir` on host will not be synced to the GCS and vice versa.
Even with extra option setting to the mount `bind-propagation=shared` does not make any different.  
Hence I would recommend to consider this image as a base image and build what you aim to sync with the gcs in the same container.


## License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
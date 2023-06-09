#!/bin/sh
set -eu

srcimg=${1:?'source image'}
dstimg=${2:?'dest image'}

awsecr_publish() (
	set -eu
	region=${1}
	/srv/uws/deploy/host/ecr-login.sh "${region}"
	/srv/uws/deploy/cluster/ecr-push.sh "${region}" "${srcimg}" "${dstimg}"
)

awsecr_publish us-east-1
awsecr_publish us-east-2

awsecr_publish us-west-1
awsecr_publish us-west-2

exit 0

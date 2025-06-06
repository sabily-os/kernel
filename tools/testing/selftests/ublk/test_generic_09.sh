#!/bin/bash
# SPDX-License-Identifier: GPL-2.0

. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh

TID="generic_09"
ERR_CODE=0

if ! _have_feature "AUTO_BUF_REG"; then
	exit "$UBLK_SKIP_CODE"
fi

if ! _have_program fio; then
	exit "$UBLK_SKIP_CODE"
fi

_prep_test "null" "basic IO test"

dev_id=$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fallback)
_check_add_dev $TID $?

# run fio over the two disks
fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
ERR_CODE=$?

_cleanup_test "null"

_show_result $TID $ERR_CODE

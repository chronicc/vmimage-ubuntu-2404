#!/usr/bin/env bash

PROJECT_DIR="${CI_PROJECT_DIR:-$GITHUB_WORKSPACE}"
PROJECT_DIR="${PROJECT_DIR:-$(git rev-parse --show-toplevel)}"
PROJECT_NAME="$(basename "${PROJECT_DIR}")"

BACKEND="libvirt"
CPU="2"
DISK_SIZE="20G"
MEMORY="4096"
NAME="${PROJECT_NAME}"
OS_VARIANT="generic"

# Thanks Johannes for the help with argument parsing!
while [[ $# -gt 0 ]]; do
    case "$1" in
        --help|-h)
            HELP="Usage: $0 SOURCE_IMAGE [--backend BACKEND=<libvirt|qemu>] [--cpu N] [--disk-size SIZE]"
            HELP+=" [--memory SIZE] [--name NAME] [--os-variant VARIANT]"
            echo "${HELP}"
            echo ""
            echo "Arguments:"
            echo "  SOURCE_IMAGE          Path to the source image file"
            echo ""
            echo "Options:"
            echo "  --backend BACKEND     Backend to use (default: libvirt). When using the qemu backend, you need to"
            echo "                        provide a local web server to serve the cloud-init files."
            echo "  --cpu N               Number of CPU cores (default: 2)"
            echo "  --disk-size SIZE      Disk size (default: 20G)"
            echo "  --memory SIZE         Memory size in MB (default: 4096)"
            echo "  --name NAME           Name of the virtual machine (default: project directory name)"
            echo "  --os-variant VARIANT  OS variant for libvirt backend (default: generic)"
            echo ""
            exit 0
            ;;
        --backend)
            BACKEND="${2}"
            shift 2
            ;;
        --cpu)
            CPU="${2}"
            shift 2
            ;;
        --disk-size)
            DISK_SIZE="${2}"
            shift 2
            ;;
        --memory)
            MEMORY="${2}"
            shift 2
            ;;
        --name)
            NAME="${2}"
            shift 2
            ;;
        --os-variant)
            OS_VARIANT="${2}"
            shift 2
            ;;
        *)
            SOURCE_IMAGE="${1}"
            shift
            ;;
    esac
done

set -euo pipefail

SUMMARY="Project Directory:${PROJECT_DIR}\n"
SUMMARY+="Source Image:${SOURCE_IMAGE}\n"
SUMMARY+="Machine Name:${NAME}\n"
SUMMARY+="OS Variant:${OS_VARIANT}\n"
SUMMARY+="CPU:${CPU}\n"
SUMMARY+="Memory:${MEMORY} MB\n"
SUMMARY+="Disk Size:${DISK_SIZE}\n"
echo "---"
echo -e "${SUMMARY}" | column -t -s ':'
echo "---"

mkdir -p "${PROJECT_DIR}/build/qemu"
QEMU_IMG="${PROJECT_DIR}/build/qemu/disk.qcow2"

echo "Copying source image to ${QEMU_IMG}"
cp "${SOURCE_IMAGE}" "${QEMU_IMG}"

echo "Resizing disk image to ${DISK_SIZE}"
qemu-img resize "${QEMU_IMG}" "${DISK_SIZE}"

case "${BACKEND}" in
    qemu)
        echo "Using QEMU backend"
        qemu-system-x86_64 \
            -hda "${QEMU_IMG}" \
            -m "${MEMORY}" \
            -net nic \
            -net user \
            -nographic \
            -smbios type=1,serial=ds='nocloud;s=http://10.0.2.2:8000/' \
            -smp "${CPU}"
        ;;
    libvirt)
        echo "Using libvirt backend"
        virt-install \
            --cloud-init "user-data=${PROJECT_DIR}/user-data,meta-data=${PROJECT_DIR}/meta-data" \
            --disk "path=${QEMU_IMG},format=qcow2" \
            --graphics none \
            --name "${NAME}" \
            --os-variant "${OS_VARIANT}" \
            --ram "${MEMORY}" \
            --vcpus "${CPU}" \
            --virt-type kvm
        virsh undefine "${NAME}"
        ;;
    *)
        echo "Unknown backend: ${BACKEND}"
        exit 1
        ;;
esac

echo "Optimizing image size"
virt-sparsify --in-place "${QEMU_IMG}"

qemu-img info "${QEMU_IMG}"

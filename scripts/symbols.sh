#!/bin/bash

clear && echo "" && [[ -x "$(command -v figlet)" ]] && figlet "symbol.sh" && echo ""

common=(
    # General setup
    "-e" "CONFIG_IKCONFIG" # Kernel .config support
    "-e" "CONFIG_IKCONFIG_PROC" # Enable access to .config through /proc/"CONFIG.gz
    # Device drivers
    "-e" "CONFIG_BLK_DEV_NVME" # NVM Express block device
    "-e" "CONFIG_DM_CRYPT" # Crypt target support
    # Memory Management options
    "-e" "CONFIG_TRANSPARENT_HUGEPAGE" # Transparent Hugepage Support
    # File systems
    "-e" "CONFIG_BTRFS_FS" # Btrfs filesystem support
    "-e" "CONFIG_FUSE_FS" # FUSE (Filesystem in Userspace) support
    "-e" "CONFIG_NTFS_FS" # NTFS file system support
    "-e" "CONFIG_NTFS_RW" # NTFS write support
    # Cryptographic API
    "-e" "CONFIG_CRYPTO_USER_API_HASH" # User-space interface for hash algorithms
    "-e" "CONFIG_CRYPTO_USER_API_SKCIPHER" # User-space interface for symmetric key cipher algorithms
    "-e" "CONFIG_CRYPTO_XTS" # XTS support
    "-e" "CONFIG_CRYPTO_ZSTD" # Zstd compression algorithm
    # Docker support
    "-e" "CONFIG_CGROUP_DEVICE"
    "-e" "CONFIG_MEMCG"
    "-e" "CONFIG_VETH"
    "-e" "CONFIG_BRIDGE"
    "-e" "CONFIG_BRIDGE_NETFILTER"
    "-e" "CONFIG_NETFILTER_ADVANCED"
    "-e" "CONFIG_NETFILTER_FAMILY_BRIDGE"
    "-e" "CONFIG_NETFILTER_XT_MATCH_IPVS"
    "-e" "CONFIG_CGROUP_BPF"
    "-e" "CONFIG_BPF_SYSCALL"
    "-e" "CONFIG_USER_NS"
    "-e" "CONFIG_CGROUP_PIDS"
    "-e" "CONFIG_MEMCG_SWAP"
    "-e" "CONFIG_BLK_CGROUP"
    "-e" "CONFIG_BLK_DEV_THROTTLING"
    "-e" "CONFIG_CGROUP_PERF"
    "-e" "CONFIG_CGROUP_HUGETLB"
    "-e" "CONFIG_NET_CLS_CGROUP"
    "-e" "CONFIG_CGROUP_NET_PRIO"
    "-e" "CONFIG_CFS_BANDWIDTH"
    "-e" "CONFIG_RT_GROUP_SCHED"
    "-e" "CONFIG_IP_NF_TARGET_REDIRECT"
    "-e" "CONFIG_IP_VS"
    "-e" "CONFIG_IP_VS_NFCT"
    "-e" "CONFIG_IP_VS_PROTO_TCP"
    "-e" "CONFIG_IP_VS_PROTO_UDP"
    "-e" "CONFIG_IP_VS_RR"
    "-e" "CONFIG_VXLAN"
    "-e" "CONFIG_BRIDGE_VLAN_FILTERING"
    "-e" "CONFIG_VLAN_8021Q"
    "-e" "CONFIG_INET_ESP"
    "-e" "CONFIG_IPVLAN"
    "-e" "CONFIG_MACVLAN"
    "-e" "CONFIG_DUMMY"
    "-e" "CONFIG_NF_NAT_TFTP"
    "-e" "CONFIG_NF_CONNTRACK_TFTP"
    "-e" "CONFIG_BTRFS_FS"
    "-e" "CONFIG_BTRFS_FS_POSIX_ACL"
    "-e" "CONFIG_DM_THIN_PROVISIONING"
    "-e" "CONFIG_OVERLAY_FS"
)

desktop=(
    # Device drivers
    "-e" "CONFIG_SND_HDA_CODEC_REALTEK" # Build Realtek HD-audio codec support
    "-e" "CONFIG_SND_USB_AUDIO" # USB sound devices 
    "-m" "CONFIG_DRM_AMDGPU" # AMD GPU
    "-m" "CONFIG_SND_CTXFI" # Creative Sound Blaster X-Fi
)

laptop=(
  # TODO:
)

if [[ $(hostname) == "desktop" ]]; then
    options=("${desktop[@]}" "${common[@]}")
elif [[ $(hostname) == "laptop" ]]; then
    options=("${laptop[@]}" "${common[@]}")
else
  echo "Unknown hostname, goodbye" && exit 1
fi

make defconfig && scripts/config "${options[@]}" && eclectic installkernel set -2 && yes "" | make -j$(nproc) && make modules_install && make install

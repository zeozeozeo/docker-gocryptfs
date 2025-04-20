# gocryptfs

Dockerized [rfjakob/gocryptfs](https://github.com/rfjakob/gocryptfs)

## Usage Example

1. Initialize the mountpoint

    ```bash
    sudo docker run --rm -it \
      --privileged \
      --cap-add SYS_ADMIN \
      --device /dev/fuse \
      --security-opt apparmor:unconfined \
      -v ./encrypted_folder1:/encrypted/folder1 \
      -v ./decrypted_folder1:/decrypted/folder1:shared \
      ghcr.io/zeozeozeo/gocryptfs \
      gocryptfs -init /encrypted/folder1
    ```
2. Run the image

    ```bash
    docker run -d \
      --restart=unless-stopped \
      --name=gocryptfs \
      --privileged \
      --cap-add SYS_ADMIN \
      --device /dev/fuse \
      -e PASSWD=<password> \
      -v </path/to/encrypted/folder1>:/encrypted/<folder1> \
      -v </path/to/encrypted/folder2>:/encrypted/<folder2> \
      -v </path/to/decrypted/folders/>:/decrypted:shared \
      ghcr.io/zeozeozeo/gocryptfs
    ```

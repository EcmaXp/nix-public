{ ... }:
let
  diskName = "ramfs";
  diskSize = "2097152"; # 1 GB
  diskMountPoint = "/tmp/ram";
in
{
  launchd.agents.ramfs = {
    script = ''
      disk_mountpoint="${diskMountPoint}"
      ls $disk_mountpoint && exit 0
      mkdir $disk_mountpoint

      disk_name="${diskName}"
      disk_size="${diskSize}"
      disk_dev=`hdiutil attach -nobrowse -nomount ram://$disk_size`

      diskutil erasevolume APFS $disk_name $disk_dev
      diskutil umount /Volumes/$disk_name
      diskutil mount -mountPoint $disk_mountpoint $disk_name

      chmod 777 $disk_mountpoint
      chmod +t $disk_mountpoint
    '';
    serviceConfig = {
      RunAtLoad = true;
    };
  };
}

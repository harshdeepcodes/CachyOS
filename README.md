# CachyOS

# Post-Installation

### Automounting drives
```bash
sudo vim etc/fstab
```
add below line
```
UUID=your_hdd_uid /mnt/your_desired_hdd_path   ext4    defaults,nofail,x-systemd.device-timeout=10 0 2
```
replace UID with your desired drive

### Paru Configuration
```bash
sudo vim /etc/paru.conf
```
uncomment #BottomUp

### Bluetooth Configuration
```bash
systemctl enable bluetooth.service
```

